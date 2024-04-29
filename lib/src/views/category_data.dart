import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/status.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/res/components/widgets/custom_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/places_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CategoryData extends StatefulWidget {

  final String category;

  const CategoryData({super.key, required this.category});

  @override
  State<CategoryData> createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> {

  final PlacesViewModel _placesViewModel = PlacesViewModel();
  final AppbarWidget _appbarWidget = AppbarWidget();
  final CustomWidgets _widgets = CustomWidgets();

  @override
  void initState() {

    super.initState();
    _placesViewModel.fetchPlaceDataListByCategory(widget.category);

  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: _appbarWidget.leadingBackButton(
            onPressed: ()=> Navigator.pushNamed(context, RoutesName.homeActivity)
        ),
        title: Text(
          widget.category
        ),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              top: 18
          ),
          child: ChangeNotifierProvider(
              create: (BuildContext context) => _placesViewModel,
              child: Consumer<PlacesViewModel>(
                builder: (context, value, _){

                  switch(value.placeDataList.status){

                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case Status.COMPLETED:
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.placeDataList.data!.length,
                          itemBuilder: (context, index){

                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(context, RoutesName.placeDetailActivity, arguments: value.placeDataList.data![index]),
                                  child: _widgets.placesContainer(
                                      zerothColor: AppColors.greyColor,
                                      firstColor: AppColors.whiteColor,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            color: AppColors.whiteColor,
                                            width: screenWidth / 3,
                                            height: 150,
                                            child: CachedNetworkImage(
                                                imageUrl: value.placeDataList.data![index].imgUrl.toString(),
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
                                                )
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: screenWidth / 2,
                                                child: Text(
                                                  value.placeDataList.data![index].title.toString(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    bottom: 8
                                                ),
                                                child: Text(
                                                    value.placeDataList.data![index].place.toString()
                                                ),
                                              ),
                                              Text(
                                                  value.placeDataList.data![index].price.toString()
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            );

                          }
                      );

                    case Status.ERROR:
                      return const Center(
                        child: Text(
                            "No places Found"
                        ),
                      );

                    default:
                      return Container();

                  }

                },
              )
          )
      ),
    );

  }

}