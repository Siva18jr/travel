import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{

  Future<dynamic> registerApi(String email, String password) async{

    try{

      dynamic response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return response;

    }catch (e){

      rethrow;

    }

  }

  Future<dynamic> loginApi(String email, String password) async{

    try{

      dynamic response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
        password: password
      );
      return response;

    }catch(e){

      rethrow;

    }

  }

}