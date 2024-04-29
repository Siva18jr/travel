import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class CustomButtons{

  Widget roundedRectangularButton({
    required String btnTxt,
    required double btnWidth,
    double btnHeight = 30,
    required Function onPressed
  }){

    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: btnWidth,
        height: btnHeight,
        decoration: BoxDecoration(
            color: AppColors.appPrimaryColor,
            borderRadius: BorderRadius.circular(18)
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8,
              bottom: 8
          ),
          child: Center(
            child: Text(
              btnTxt,
              style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

  }

  Widget bookNowButton({
    bool isResponsive = false,
    required String text,
    double width = 120,
    required Function onPressed
  }){

    return Flexible(
      child: InkWell(
        onTap: ()=> onPressed(),
        child: Container(
          width: isResponsive ? double.maxFinite : width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.violetCustomized,
          ),
          child: Row(
            mainAxisAlignment: isResponsive
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
              Image.asset(
                  "assets/images/swipe.png"
              )
            ],
          ),
        ),
      ),
    );

  }

}