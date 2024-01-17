import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class CustomWidgets{

  Widget productContainer({required Color zerothColor, required Color firstColor, required Widget child}){

    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: zerothColor,
            borderRadius: const BorderRadius.all(
                Radius.circular(16)
            )
        ),
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: firstColor,
                borderRadius: const BorderRadius.all(
                    Radius.circular(16)
                )
            ),
            child: child
        )
    );

  }

  Widget bottomContainer({required double containerWidth, required Widget child}){

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AppColors.appPrimaryColor,
          borderRadius: BorderRadius.all(
              Radius.circular(23)
          )
      ),
      child: child,
    );

  }

}