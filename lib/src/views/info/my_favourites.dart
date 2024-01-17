import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/res/components/widgets/custom_widgets.dart';
import 'package:levitate/src/res/components/widgets/group_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {

  final AppbarWidget _appbarWidget = AppbarWidget();
  final GroupWidgets _groupWidgets = GroupWidgets();
  final CustomWidgets _widgets = CustomWidgets();

  @override
  Widget build(BuildContext context) {

    final screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      appBar: AppBar(
        leading: _appbarWidget.leadingBackButton(
            onPressed: ()=> Navigator.pushNamed(context, RoutesName.homeActivity)
        ),
        title: _appbarWidget.appbarTitle(
            title: 'Cart'
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _groupWidgets.verticalListBuilder(
                context: context,
                itemCount: 2,
                child: Card(
                  child: _widgets.productContainer(
                      zerothColor: AppColors.greyColor,
                      firstColor: AppColors.whiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenWidth / 3,
                            height: 150,
                            child: Card(
                              child: Image.asset(
                                  "assets/images/img_empty.png"
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: screenWidth / 2,
                                child: const Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                      Icons.delete_forever,
                                    color: AppColors.redColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 2,
                                child: const Text(
                                  "Chithirai Cold Pressed Coconut Oil",
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 2,
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 3,
                                      bottom: 3
                                  ),
                                  child: Text(
                                    "1 l",
                                    style: TextStyle(
                                      fontSize: 11
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 2 ,
                                child: const Text(
                                  "& 400",
                                  style: TextStyle(
                                      fontSize: 11
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomizableCounter(
                                    showButtonText: false,
                                    borderColor: AppColors.whiteColor,
                                    borderRadius: 100,
                                    backgroundColor: AppColors.whiteColor,
                                    textColor: AppColors.blackColor,
                                    textSize: 13,
                                    count: 1,
                                    step: 1,
                                    minCount: 1,
                                    maxCount: 30,
                                    incrementIcon: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                          color: AppColors.greyColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)
                                          )
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.blackColor,
                                        size: 8,
                                      ),
                                    ),
                                    decrementIcon: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.greyColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)
                                          )
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.remove,
                                        color: AppColors.blackColor,
                                        size: 8,
                                      ),
                                    ),
                                    onCountChange: (count) {

                                    },
                                    onIncrement: (count) {

                                    },
                                    onDecrement: (count) {

                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                )
            )
          ],
        ),
      ),
    );

  }

}