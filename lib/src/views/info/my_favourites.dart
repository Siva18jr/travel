import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/status.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/widgets/appbar_widgets.dart';
import 'package:levitate/src/res/components/widgets/custom_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/favourites_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {

  final AppbarWidget _appbarWidget = AppbarWidget();
  final CustomWidgets _widgets = CustomWidgets();
  final FavouritesViewModel _favouritesViewModel = FavouritesViewModel();

  @override
  void initState() {

    super.initState();
    _favouritesViewModel.fetchMyFavouritesDataApi();

  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      appBar: AppBar(
        leading: _appbarWidget.leadingBackButton(
            onPressed: ()=> Navigator.pushNamed(context, RoutesName.homeActivity)
        ),
        title: _appbarWidget.appbarTitle(
            title: 'Favourites'
        ),
      ),
      body: ChangeNotifierProvider<FavouritesViewModel>(
        create: (BuildContext context) => _favouritesViewModel,
        child: Consumer<FavouritesViewModel>(
          builder: (context, value, _){

            switch(value.favouritesDataList.status){

              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Status.COMPLETED:
                return value.favouritesDataList.data!.isEmpty ?
                    const Center(
                      child: Text(
                        "No favourites found"
                      ),
                    ) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.favouritesDataList.data!.length,
                    itemBuilder: (context, index){

                      return InkWell(
                        onTap: ()=> Navigator.pushNamed(context, RoutesName.placeDetailActivity, arguments: value.favouritesDataList.data![index]),
                        child: Card(
                          child: _widgets.placesContainer(
                              zerothColor: AppColors.greyColor,
                              firstColor: AppColors.whiteColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    color: AppColors.whiteColor,
                                    width: screenWidth / 4,
                                    height: 100,
                                    child: CachedNetworkImage(
                                        imageUrl: value.favouritesDataList.data![index].imgUrl.toString(),
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
                                        width: screenWidth / 3,
                                        child: Text(
                                          value.favouritesDataList.data![index].title.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8
                                        ),
                                        child: SizedBox(
                                          width: screenWidth / 4,
                                          child: Text(
                                              value.favouritesDataList.data![index].place.toString(),
                                            overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ),
                                      Text(
                                          value.favouritesDataList.data![index].price.toString()
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => _favouritesViewModel.removeItemFromFavouritesAPi(value.favouritesDataList.data![index].id.toString()),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: AppColors.redColor
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      );

                    }
                );

              case Status.ERROR:
                return Text(
                  value.favouritesDataList.message.toString()
                );

              default:
                return Container();

            }

          }
        )
      ),
    );

  }

}