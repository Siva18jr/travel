import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class CustomWidgets{

  Widget placesContainer({required Color zerothColor, required Color firstColor, required Widget child}){

    return Container(
        padding: const EdgeInsets.all(8),
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

  Widget budgetTotalCountTile({
    required String title,
    required String count,
    required double screenWidth,
    Color txtColor = AppColors.greyColor100,
    bool divide = true
  }){

    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8
        ),
        child: Column(
            children: <Widget>[
              ListTile(
                  visualDensity: const VisualDensity(
                      vertical: -4
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                        fontSize: 13,
                        color: txtColor
                    ),
                  ),
                  trailing: Text(
                      count,
                      style: TextStyle(
                          fontSize: 13,
                          color: txtColor
                      )
                  )
              ),
              divide == true ?
              SizedBox(
                width: screenWidth - 55,
                child: const Divider(
                  thickness: 1,
                  color: AppColors.greyColor100,
                ),
              ) :
              const SizedBox()
            ]
        )
    );

  }

}