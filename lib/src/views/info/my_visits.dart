import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyVisitsActivity extends StatefulWidget {
  const MyVisitsActivity({super.key});

  @override
  State<MyVisitsActivity> createState() => _MyVisitsActivityState();
}

class _MyVisitsActivityState extends State<MyVisitsActivity> {

  final AppbarWidget _appbarWidget = AppbarWidget();

  @override
  Widget build(BuildContext context) {

    final screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.greyColor10,
      appBar: AppBar(
        backgroundColor: AppColors.greyColor10,
        elevation: 0,
        leading: _appbarWidget.leadingBackButton(
            onPressed: () => Navigator.pushNamed(context, RoutesName.homeActivity)
        ),
        title: _appbarWidget.appbarTitle(
            title: "Your Visits"
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8
            ),
            child: Center(
              child: InkWell(
                onTap: (){},
                child: const Text(
                  "Repeat Order",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Image.asset(
          "assets/images/img_empty.png",
          width: screenWidth - 100,
        ),
      ),
    );

  }

}