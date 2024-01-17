import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class AppbarWidget{

  Widget leadingBackButton({required Function onPressed}){

    return InkWell(
      onTap: () => onPressed(),
      child: const Icon(
          Icons.arrow_back,
        color: AppColors.blackColor,
      ),
    );

  }

  Widget appbarTitle({required String title}){

    return Text(
      title,
      style: const TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),
    );

  }

}