import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static double getActivityScreenWidth(BuildContext context){

    return MediaQuery.of(context).size.width;

  }

  static double getActivityScreenHeight(BuildContext context){

    return MediaQuery.of(context).size.height;

  }

  static void fieldFocusChange({required BuildContext context, required FocusNode currentFocus, required FocusNode nextFocus}){

    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);

  }

  static toastMessage({required String message, required Color bgColor}){

    Fluttertoast.showToast(
        msg: message,
        backgroundColor: bgColor,
        textColor: AppColors.whiteColor
    );

  }

  static flushBarMessage({required String title, required String message, required BuildContext context, required Color bgColor}){

    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10
          ),
          padding: const EdgeInsets.all(15),
          borderRadius: BorderRadius.circular(20),
          reverseAnimationCurve: Curves.easeOut,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          title: title,
          backgroundColor: bgColor,
          duration: const Duration(
              seconds: 3
          ),
          message: message,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: AppColors.whiteColor,
          ),
        )..show(context)
    );

  }

  static snackBar({required String message, required BuildContext context}){

    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
                message
            )
        )
    );

  }

  static String convertDateFormat(String dateTime){

    try{

      final List<String> formatSplit = dateTime.split('-');

      if(formatSplit[1].length != 2){

        formatSplit[1] = '0${formatSplit[1]}';

      }

      return '${formatSplit[2]}-${formatSplit[1]}-${formatSplit[0]}';

    }on Exception catch (e){

      return e.toString();

    }

  }

}