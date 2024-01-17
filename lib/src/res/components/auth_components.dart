import 'package:flutter/material.dart';

class AuthComponents{

  static Widget fullWidthTextField({
    required String label,
    required Widget child,
    double height = 98
  }){

    return Padding(
      padding: const EdgeInsets.only(
          top: 8
      ),
      child: Container(
        padding: const EdgeInsets.only(
            left: 8,
            right: 5
        ),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 6,
                    bottom: 6
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            child
          ],
        ),
      ),
    );

  }

}