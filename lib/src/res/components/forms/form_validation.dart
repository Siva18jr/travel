import 'package:flutter/material.dart';

class FormValidation{

  static bool isEmpty(TextEditingController txt){

    if(txt.text.toString().isEmpty){

      return true;

    }else{

      return false;

    }

  }

}