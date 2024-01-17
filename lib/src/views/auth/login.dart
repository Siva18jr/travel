import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/forms/login_form.dart';
import 'package:levitate/src/res/components/forms/register_form.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({super.key});

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> with SingleTickerProviderStateMixin{

  late TabController tabController;
  final AppbarWidget _appbarWidget = AppbarWidget();

  @override
  void initState() {

    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {

    super.dispose();
    tabController.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = Utils.getActivityScreenHeight(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (_){

        Navigator.pushNamed(context, RoutesName.homeActivity);

      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: _appbarWidget.leadingBackButton(
                onPressed: ()=> Navigator.pushNamed(context, RoutesName.homeActivity)
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 10
                ),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: AppColors.textFieldBgColor,
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: const BoxDecoration(
                          color: AppColors.textFieldBgColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(55)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 55,
                            right: 55
                        ),
                        child: Center(
                          child: TabBar(
                              controller: tabController,
                              indicatorPadding: const EdgeInsets.only(
                                  top: 18
                              ),
                              indicatorColor: AppColors.appPrimaryColor,
                              unselectedLabelColor: AppColors.blackColor,
                              labelColor: AppColors.blackColor,
                              tabs: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8
                                  ),
                                  child: Text(
                                      "Login"
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8
                                  ),
                                  child: Text(
                                      "Sign Up"
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight - screenHeight / 4,
                      child: TabBarView(
                          controller: tabController,
                          children: const [
                            LoginForm(),
                            RegisterForm()
                          ]
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );

  }

}