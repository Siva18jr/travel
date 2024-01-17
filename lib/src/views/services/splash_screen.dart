import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _navigateToActivity(context) async {

    // await Navigator.pushNamed(context, RoutesName.introductionScreen);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool("firstInstall");

    if(firstTime == null){

      await Navigator.pushNamed(context, RoutesName.introductionScreen);

    }else{

      if(bool.parse(firstTime.toString()) == true){

        await Navigator.pushNamed(context, RoutesName.introductionScreen);

      }else{

        await Navigator.pushNamed(context, RoutesName.homeActivity);

      }

    }

  }

  @override
  void initState() {

    super.initState();

    Future.delayed(
        const Duration(
            milliseconds: 3000
        ),
        () => _navigateToActivity(context)
    );
    
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Levitate",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackColor,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.appPrimaryColor,
        child: Text(
          "Powered by Feline",
          style: TextStyle(
            color: AppColors.greyTxtColor,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

  }

}