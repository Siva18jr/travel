import 'dart:developer' as dev;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:levitate/src/data/response/status.dart';
import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/model/provider_state/place_details_provider.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/view_model/hotels_view_model.dart';
import 'package:levitate/src/view_model/local_data_view_model.dart';
import 'package:levitate/src/views/services/google_map.dart';
import 'package:levitate/src/res/components/widgets/custom_buttons.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/favourites_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {

  final PlacesModel item;

  const PlaceDetail({super.key, required this.item});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {

  final CustomButtons _buttons = CustomButtons();
  final FavouritesViewModel _favouritesViewModel = FavouritesViewModel();
  final LocalDataViewModel _localDataViewModel = LocalDataViewModel();
  final HotelsViewModel _hotelsViewModel = HotelsViewModel();

  @override
  void initState() {

    super.initState();
    _hotelsViewModel.fetchHotelsDataByDistrictAPI(widget.item.city.toString());
    _favouritesViewModel.fetchMyFavouritesDataApi();
    _localDataViewModel.fetchBoolDataList(LocalKeys.localLoginBoolKey);

  }

  void calculateDistance(LatLng start, LatLng end) {

    const double earthRadius = 6371.0; // Radius of the Earth in kilometers

    // Convert coordinates to radians
    final double lat1 = start.latitude * (pi / 180.0);
    final double lon1 = start.longitude * (pi / 180.0);
    final double lat2 = end.latitude * (pi / 180.0);
    final double lon2 = end.longitude * (pi / 180.0);

    // Calculate the differences between the coordinates
    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    // Apply the Haversine formula
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    dev.log(distance.toString());// Distance in kilometers, add "*1000" to get meters

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    List coordinates = widget.item.coordinates.toString().split(",");

    double distanceInMeters = Geolocator.distanceBetween(12.97194, 77.59369, double.parse(coordinates[0]), double.parse(coordinates[1]));

    dev.log('s = $distanceInMeters');
    calculateDistance(const LatLng(12.97194, 77.59369), LatLng(double.parse(coordinates[0]), double.parse(coordinates[1])));

    return Consumer<PlaceDetailsProvider>(
      builder: (context, globalValue, _){

        return PopScope(
          canPop: true,
          onPopInvoked: (pop) => globalValue.setSelectedIndex(-1),
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                height: screenHeight * 1.8,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
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
                                )
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
                        width: screenWidth,
                        height: screenHeight * 1.5,
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
                                SizedBox(
                                  width: screenWidth / 1.5,
                                  child: Text(
                                    widget.item.title.toString(),
                                    style: TextStyle(
                                        color: AppColors.blackColor54.withOpacity(0.8),
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.item.price.toString(),
                                  style: const TextStyle(
                                      color: AppColors.blackColor54,
                                      fontSize: 23,
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
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    globalValue.totalAmount == 0 ?
                                    "Book a hotel" : '₹${globalValue.totalAmount}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor54
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async{

                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now().add(const Duration(days: 1)), // Refer step 1
                                        firstDate: DateTime.now().add(const Duration(days: 1)),
                                        lastDate: DateTime.now().add(const Duration(days: 28)),
                                      );
                                      if (picked != null){

                                        globalValue.setSelectedDate(picked.toString());

                                      }

                                      dev.log(globalValue.selectedDate);

                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      color: globalValue.selectedDate == '' ?
                                          AppColors.redColor : AppColors.greenColor
                                    ),
                                  )
                                ]
                            ),
                            const SizedBox(
                              height: 10
                            ),
                            SizedBox(
                              child: ChangeNotifierProvider<HotelsViewModel>(
                                create: (BuildContext context)=> _hotelsViewModel,
                                child: Consumer<HotelsViewModel>(
                                  builder: (BuildContext context, HotelsViewModel value, _){

                                    switch(value.hotelsDataList.status){

                                      case Status.LOADING:
                                        return const CircularProgressIndicator();

                                      case Status.COMPLETED:
                                        return GroupButton<String>(
                                          buttons: value.hotelsInfo,
                                          onSelected: (String val, int index, bool isSelected){

                                            globalValue.setSelectedHotelPrice(int.parse(value.hotelsPrice[index]));
                                            globalValue.setSelectedHotel(val);

                                            if(globalValue.selectedIndex != -1){

                                              globalValue.setTotalAmount();

                                            }

                                          },
                                          options: GroupButtonOptions(
                                            textPadding: const EdgeInsets.all(8),
                                            buttonWidth: 100,
                                            crossGroupAlignment: CrossGroupAlignment.start,
                                            borderRadius: BorderRadius.circular(15),
                                            selectedColor: AppColors.appPrimaryColor,
                                            unselectedColor: AppColors.greyColor,
                                            selectedTextStyle: const TextStyle(
                                                color: AppColors.whiteColor,
                                              fontSize: 13
                                            ),
                                            unselectedTextStyle: const TextStyle(
                                                color: AppColors.blackColor,
                                              fontSize: 13
                                            ),
                                          ),
                                        );

                                      case Status.ERROR:
                                        return const Center(
                                          child: Text(
                                            'Something went wrong'
                                          )
                                        );

                                      default:
                                        return Container();

                                    }

                                  }
                                )
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18),
                              child: Wrap(
                                children: List.generate(10, (index) => InkWell(
                                  onTap: () {

                                    globalValue.setSelectedIndex(index);

                                    if(globalValue.selectedHotelPrice != -1){

                                      globalValue.setTotalAmount();

                                    }

                                  },
                                  child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.detailPageBtn,
                                            width: 1.0
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        color: index == globalValue.selectedIndex ?
                                        AppColors.appPrimaryColor
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
                            SizedBox(
                              height: screenHeight * 0.005,
                            ),
                            Text(
                              widget.item.description.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackColor54
                              ),
                            ),
                            SizedBox(
                              height: screenWidth * 0.05,
                            ),
                            SizedBox(
                              height: screenHeight / 1.5,
                              child: GoogleMapWidget(
                                latitude: double.parse(coordinates[0]),
                                longitude: double.parse(coordinates[1]),
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
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_home,
                overlayOpacity: 0.4,
                children: [
                  SpeedDialChild(
                    child: const Icon(
                      Icons.directions
                    ),
                    onTap: () async {

                      await Geolocator.requestPermission().then((value){

                        Navigator.pushNamed(context, RoutesName.userLocationActivity, arguments: <String>[coordinates[0], coordinates[1]]);

                      }).onError((error, stackTrace){

                        dev.log(error.toString());

                      });

                    }
                  ),
                  SpeedDialChild(
                    onTap: (){

                      int min = 800, max = 1200;
                      int randomNumber = int.parse((min + Random().nextInt(max - min)).toString());

                      Navigator.pushNamed(context, RoutesName.budgetPredictionActivity, arguments: <String>[distanceInMeters.toString(), randomNumber.toString()]);

                    },
                    child: const Icon(
                      Icons.account_balance_wallet_outlined
                    )
                  )
                ]
            ),
            bottomNavigationBar: BottomAppBar(
              surfaceTintColor: AppColors.whiteColor,
              child: Row(
                children: [
                  Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.lightVioletBorder,
                              width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.whiteColor
                      ),
                      child: ChangeNotifierProvider<FavouritesViewModel>(
                          create: (BuildContext context) => _favouritesViewModel,
                          child: Consumer<FavouritesViewModel>(
                              builder: (context, value, _){

                                switch(value.favouritesDataList.status){

                                  case Status.LOADING:
                                    return const Center(
                                        child: CircularProgressIndicator()
                                    );

                                  case Status.COMPLETED:
                                    List<PlacesModel> favouritesData = value.favouritesDataList.data!.where((element) => (element.id) == widget.item.id).toList();
                                    return InkWell(
                                      onTap:(){

                                        if(favouritesData.isEmpty){

                                          Map<String,dynamic> data = PlacesModel(
                                            id: widget.item.id,
                                            category: widget.item.category,
                                            city: widget.item.city,
                                            country: widget.item.country,
                                            description: widget.item.description,
                                            imgUrl: widget.item.imgUrl,
                                            place: widget.item.place,
                                            price: widget.item.price,
                                            title: widget.item.title,
                                            coordinates: widget.item.coordinates
                                          ).toJson();

                                          _favouritesViewModel.addToFavouritesApi(
                                              key: widget.item.id.toString(),
                                              data: data,
                                              context: context
                                          );

                                        }else{

                                          _favouritesViewModel.removeItemFromFavouritesAPi(
                                            widget.item.id.toString()
                                          );

                                        }

                                      },
                                      child: favouritesData.isEmpty ?
                                          const Icon(
                                            Icons.favorite_border,
                                            color: AppColors.lightViolet
                                          ) :
                                      const Icon(
                                        Icons.favorite,
                                        color: AppColors.loveRed,
                                      ),
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
                      )
                  ),
                  const SizedBox(
                    width: 20
                  ),
                  ChangeNotifierProvider<LocalDataViewModel>(
                    create: (BuildContext context)=> _localDataViewModel,
                    child: Consumer<LocalDataViewModel>(
                      builder: (context, loginValue, _){

                        return _buttons.bookNowButton(
                            text: "Book Trip Now",
                            isResponsive: true,
                            onPressed: (){

                              if(bool.parse(loginValue.loginBoolData.data.toString()) == true) {

                                if (globalValue.selectedIndex == -1 || globalValue.selectedHotelPrice == -1) {

                                  Utils.flushBarMessage(
                                      title: 'Pending',
                                      message: 'Please select the hotel booking info',
                                      context: context,
                                      bgColor: AppColors.redColor
                                  );

                                } else if(globalValue.selectedDate == ''){

                                  Utils.flushBarMessage(
                                      title: 'Pending',
                                      message: 'Please pick the date',
                                      context: context,
                                      bgColor: AppColors.redColor
                                  );

                                }else {

                                  Navigator.pushNamed(context, RoutesName.bookingActivity, arguments: <String>[(globalValue.totalAmount + 45).toString(), globalValue.selectedHotel.toString(), (globalValue.selectedIndex + 1).toString(), globalValue.selectedDate]);

                                }

                              }else{

                                Utils.flushBarMessage(
                                    title: 'Login Required',
                                    message: 'Please login to book',
                                    context: context,
                                    bgColor: AppColors.redColor
                                );

                              }

                            }
                        );

                      }
                    )
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