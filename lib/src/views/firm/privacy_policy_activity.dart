import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyActivity extends StatefulWidget {
  const PrivacyPolicyActivity({super.key});

  @override
  State<PrivacyPolicyActivity> createState() => _PrivacyPolicyActivityState();
}

class _PrivacyPolicyActivityState extends State<PrivacyPolicyActivity> {

  final AppbarWidget _appbarWidget = AppbarWidget();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: _appbarWidget.leadingBackButton(
            onPressed: () => Navigator.pushNamed(context, RoutesName.homeActivity)
        ),
        title: _appbarWidget.appbarTitle(
            title: 'Privacy Policy'
        ),
      ),
    );

  }

}