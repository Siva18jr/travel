import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/custom_buttons.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlaceDetail extends StatefulWidget {

  final PlacesModel item;

  const PlaceDetail({super.key, required this.item});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {

  final CustomButtons _buttons = CustomButtons();
  int gottenStarts = 3;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          height: screenHeight + 55,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(),
              Positioned(
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: screenHeight / 2,
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imgUrl.toString(),
                      imageBuilder: (context, imageProvider){

                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover
                              )
                          ),
                        );

                      },
                      placeholder: (context, url){

                        return Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.denimBlueColor,
                                size: 23
                            )
                        );

                      },
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error
                      ),
                    ),
                  )
              ),
              Positioned(
                top: 330,
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 30
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight / 2,
                  decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item.title.toString(),
                            style: TextStyle(
                              color: AppColors.blackColor54.withOpacity(0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                              widget.item.price.toString(),
                              style: const TextStyle(
                                  color: AppColors.blackColor54,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.lightViolet,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${widget.item.place},${widget.item.city}",
                              style: const TextStyle(
                                fontSize: 16,
                                  color: AppColors.blackColor54
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                          children: [
                            Text(
                              "Number of people in group",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.greyCustomized
                              ),
                            )
                          ]
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: List.generate(
                          5,
                              (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.detailPageBtn,
                                        width: 1.0
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    color: index == selectedIndex ?
                                    AppColors.violetCustomized
                                    : AppColors.blackColor26,
                                ),
                                child: Center(
                                  child: Text(
                                      (index + 1).toString(),
                                    style: const TextStyle(
                                      color: AppColors.blackColor
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Description",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.item.description.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor54
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.lightVioletBorder,
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteColor
              ),
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.lightViolet,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            _buttons.bookNowButton(
              text: "Book Trip Now",
              isResponsive: true,
            )
          ],
        ),
      ),
    );

  }

}