import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:flutter/material.dart';

class GroupWidgets{

  Widget horizontalListBuilder({required BuildContext context, required int itemCount, required Widget child}){

    final screenHeight = Utils.getActivityScreenHeight(context);

    return SizedBox(
      height: screenHeight * 0.1,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){

            return child;

          }
      ),
    );

  }

  Widget fixedCrossGridBuilder({required int crossCount, required Function onClick}){

    return GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8,
          mainAxisSpacing: 3,
          crossAxisCount: crossCount,
        ),
        itemCount: 10,
        itemBuilder: (_, index){

          return InkWell(
            onTap: () => onClick(),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color : AppColors.denimBlueColor,
                  border: Border.all(
                      color: AppColors.widgetBorderColor
                  ),
                  borderRadius: BorderRadius.circular(
                      10
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 2
                      ),
                      height: 80,
                      width: 80,
                      child: Image.asset(
                          "assets/images/intro_three.png"
                      )
                  ),
                ],
              ),
            ),
          );

        }
    );

  }

  Widget verticalListBuilder({required BuildContext context, required int itemCount, required Widget child}){

    return ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: child
          );

        }
    );

  }

}