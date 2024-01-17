import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {

  final String title;
  final bool loading;
  final VoidCallback onPressed;
  final double btnWidth;
  final double btnHeight;
  final double txtFontSize;

  const LoadingButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPressed,
    required this.btnWidth,
    this.btnHeight = 30,
    this.txtFontSize = 16
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(
            left: 8,
            right: 5
        ),
        height: btnHeight,
        width: btnWidth,
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
            child: loading ?
            const CircularProgressIndicator(
                color: AppColors.whiteColor
            ) :
            Text(
              title,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: txtFontSize
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

  }

}