import 'package:customizable_counter/customizable_counter.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:flutter/material.dart';

class BottomSheets{

  static productBottomSheet({required BuildContext context, required double screenHeight, required double screenWidth}){

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(33)
        )
      ),
        context: context,
        builder: (BuildContext context){

          return Container(
            color: AppColors.whiteColor,
            height: (screenHeight / 2) + 20,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16)
                    )
                ),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: (screenHeight / 4) - 15,
                        width: screenWidth / 4,
                        child: Image.asset(
                          "assets/images/intro_three.png"
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(13)
                        )
                      ),
                      width: screenWidth,
                      height: (screenHeight / 4) + 25 ,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "Himalayan Rock Salt\nOrganic Rock Salt Granules",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                                "500 g",
                              style: TextStyle(
                                color: AppColors.greyColor100,
                                  fontSize: 11
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                                "&65",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  fontSize: 11
                              ),
                            ),
                            SizedBox(
                              width: screenWidth - 30,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CustomizableCounter(
                                  showButtonText: false,
                                  borderColor: AppColors.whiteColor,
                                  borderRadius: 100,
                                  backgroundColor: AppColors.whiteColor,
                                  textColor: AppColors.blackColor,
                                  textSize: 16,
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
                                      size: 11,
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
                                      size: 11,
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
                            Container(
                              width: screenWidth - 20,
                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                              decoration: const BoxDecoration(
                                color: AppColors.appPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23)
                                )
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: AppColors.whiteColor,
                                        ),
                                        VerticalDivider(
                                          width: 20,
                                          color: AppColors.whiteColor,
                                          thickness: 2,
                                        ),
                                        Text(
                                          "Item 1\n&65",
                                          style: TextStyle(
                                            color: AppColors.whiteColor,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Proceed to Cart",
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: AppColors.whiteColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

        }
    );

  }

}