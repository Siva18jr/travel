import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:levitate/src/model/api_models/user_data_model.dart';
import 'package:levitate/src/repository/auth_repository.dart';
import 'package:levitate/src/repository/user_repository.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();
  final _userRepo = UserRepository();
  final UserViewModel _userViewModel = UserViewModel();

  bool _signupLoading = false;
  bool _loginLoading = false;

  bool get signupLoading => _signupLoading;
  bool get loginLoading => _loginLoading;

  _setSignupLoading(bool value){

    _signupLoading = value;
    notifyListeners();

  }

  _setLoginLoading(bool value){

    _loginLoading = value;
    notifyListeners();

  }

  Future<void> signupApi({required BuildContext context, required String email, required String password, required String userName}) async{

    _setSignupLoading(true);

    _myRepo.registerApi(email, password).then((value){

      // _userRepo.addUserData(
      //
      // );

      FirebaseAuth auth = FirebaseAuth.instance;

      _userRepo.addUserData(
        UserDataModel(
            id: auth.currentUser!.uid.toString(),
            name: userName,
            email: email,
            password: password
        ).toJson()
      );

      _setSignupLoading(false);

      Utils.flushBarMessage(
          title: 'Success',
          message: "Registered Successfully",
          context: context,
          bgColor: AppColors.greenColor
      );

      Navigator.pushNamed(context, RoutesName.loginActivity);

    }).onError((error, stackTrace){

      _setSignupLoading(false);

      Utils.flushBarMessage(
          title: 'Error',
          message: "Something went wrong",
          context: context,
          bgColor: AppColors.redColor
      );

    });

  }

  Future<void> loginApi({required BuildContext context, required String email, required String password}) async{

    _setLoginLoading(true);

    await _myRepo.loginApi(email, password).then((value){

      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      log(firebaseAuth.currentUser!.uid.toString());

      _setLoginLoading(false);

      _userViewModel.saveUser();

      Navigator.pushNamed(context, RoutesName.homeActivity);

      Utils.flushBarMessage(
          title: "Success",
          message: "Successfully Logged In",
          context: context,
          bgColor: AppColors.greenColor
      );

      log(value.toString());

    }).onError((error, stackTrace){

      _setLoginLoading(false);

      Utils.flushBarMessage(
          title: "Error",
          message: "The supplied auth credential is incorrect, malformed or has expired.",
          context: context,
          bgColor: AppColors.redColor
      );

      log(error.toString());

    });

  }

  Future<void> logoutApi(BuildContext context) async {

    await FirebaseAuth.instance.signOut().then((value){

      _userViewModel.remove().then((value){

        Utils.toastMessage(
            message: 'Logged out',
            bgColor: AppColors.blackColor
        );

        Navigator.pushNamed(context, RoutesName.loginActivity);

      }).onError((error, stackTrace){

        Utils.toastMessage(
            message: 'Something went wrong',
            bgColor: AppColors.blackColor
        );

      });

    }).onError((error, stackTrace){

      _userViewModel.saveUser().then((value){

        Utils.toastMessage(
            message: 'Something went wrong',
            bgColor: AppColors.blackColor
        );

      });

      log(error.toString());

    });

  }

}