import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/res/components/widgets/group_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {

  final AppbarWidget _appbarWidget = AppbarWidget();
  final bool _notification = true;
  final GroupWidgets _groupWidgets = GroupWidgets();

  @override
  Widget build(BuildContext context) {

    final screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: _appbarWidget.leadingBackButton(
              onPressed: () => Navigator.pushNamed(context, RoutesName.homeActivity)
          ),
          title: _appbarWidget.appbarTitle(
              title: "Notification"
          )
      ),
      body: _notification == true ?
          SingleChildScrollView(
            child: _groupWidgets.verticalListBuilder(
                context: context,
                itemCount: 1,
                child: Card(
                  color: AppColors.whiteColor,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: AppColors.appPrimaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(23)
                                )
                            ),
                            child: const Text(
                              "Order Received!!",
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.whiteColor
                              ),
                            ),
                          ),
                          const Text(
                              "06-Jan-2024 10:55 pm",
                            style: TextStyle(
                              fontSize: 12
                            ),
                          )
                        ],
                      ),
                    ),
                    subtitle: const Text(
                      "Siva, Your Order #96 Has Been Received",
                      style: TextStyle(
                        fontSize: 13
                      ),
                    ),
                  ),
                )
            ),
          ) :
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/img_empty.png",
              width: screenWidth - 100,
            ),
            const Padding(
              padding: EdgeInsets.only(
                  top: 38,
              ),
              child: Text(
                "Notification List Retrieved",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}