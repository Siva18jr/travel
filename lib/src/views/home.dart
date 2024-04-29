import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/data/response/status.dart';
import 'package:levitate/src/model/provider_state/home_provider.dart';
import 'package:levitate/src/res/colors/color.dart';
import 'package:levitate/src/res/components/home_navigation_drawer.dart';
import 'package:levitate/src/res/components/widgets/custom_widgets.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:levitate/src/view_model/category_view_model.dart';
import 'package:levitate/src/view_model/hotels_view_model.dart';
import 'package:levitate/src/view_model/places_view_model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PlacesViewModel _placesViewModel = PlacesViewModel();
  final CategoryViewModel _categoryViewModel = CategoryViewModel();
  final CustomWidgets _widgets = CustomWidgets();
  final HotelsViewModel _hotelsViewModel = HotelsViewModel();

  @override
  void initState() {

    super.initState();
    _placesViewModel.fetchPlaceDataList();
    _categoryViewModel.fetchCategoryDataList();
    _hotelsViewModel.fetchHotelsDataList();

  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);
    List<String> imgPath = ["assets/images/banner-1.jpg", "assets/images/banner-2.png", "assets/images/banner-3.jpg"];

    return Consumer<HomeProvider>(
     builder: (context, searchValue, _){

       return Scaffold(
           backgroundColor: AppColors.whiteColor,
           drawer: const HomeNavigationDrawer(),
           appBar: AppBar(
             backgroundColor: AppColors.appPrimaryColor,
             elevation: 0,
             title: const Text(
               "Levitate",
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: AppColors.whiteColor
               ),
             ),
             actions: [
               // InkWell(
               //   onTap: () => Navigator.pushNamed(context, RoutesName.notificationActivity),
               //   child: const Icon(
               //     Icons.notification_important,
               //     color: AppColors.whiteColor,
               //   ),
               // ),
                Padding(
                 padding: const EdgeInsets.only(
                     left: 8,
                     right: 8
                 ),
                 child: InkWell(
                   onTap: ()=> Navigator.pushNamed(context, RoutesName.myFavouritesActivity),
                   child: const Icon(
                     Icons.favorite,
                     color: AppColors.loveRed,
                   ),
                 ),
               )
             ],
           ),
           body: LiquidPullToRefresh(
             showChildOpacityTransition: true,
             backgroundColor: AppColors.whiteColor,
             color: AppColors.appPrimaryColor,
             onRefresh: () async {

               _placesViewModel.fetchPlaceDataList();
               _categoryViewModel.fetchCategoryDataList();

             },
             child: SingleChildScrollView(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(
                     height: screenHeight * 0.35,
                     width: double.infinity,
                     /// top widget
                     child: Stack(
                       children: [
                         Align(
                           alignment: Alignment.topLeft,
                           child: Container(
                             height: screenHeight * 0.20,
                             width: double.infinity,
                             color: AppColors.appPrimaryColor,
                             /// search widget
                             child: Align(
                               alignment: Alignment.topCenter,
                               child: InkWell(
                                 onTap: () => Navigator.pushNamed(context, RoutesName.searchPlacesActivity),
                                 child: Container(
                                   width: screenWidth - 40,
                                   height: screenHeight * 0.06,
                                   decoration: const BoxDecoration(
                                       color: AppColors.textFieldBgColor,
                                       borderRadius: BorderRadius.all(
                                           Radius.circular(23)
                                       )
                                   ),
                                   child: const Padding(
                                     padding: EdgeInsets.only(
                                         left: 8
                                     ),
                                     child: Row(
                                       children: [
                                         SizedBox(
                                           height: 30,
                                           width: 30,
                                           child: Icon(
                                             Icons.search,
                                             color: AppColors.appPrimaryColor,
                                           )
                                         ),
                                         SizedBox(
                                           width: 10,
                                         ),
                                         Text(
                                             "Search for Travel Places"
                                         )
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ),
                         /// banner widget
                         Center(
                             child: Padding(
                               padding: const EdgeInsets.only(
                                   top: 18
                               ),
                               child: SizedBox(
                                 height: screenHeight * 0.19,
                                 child: ListView.builder(
                                     shrinkWrap: true,
                                     scrollDirection: Axis.horizontal,
                                     itemCount: imgPath.length,
                                     itemBuilder: (context, index){
             
                                       return Padding(
                                         padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                                         child: SizedBox(
                                             height: screenHeight * 0.18,
                                             width: screenWidth - 100,
                                             child: Container(
                                               decoration: BoxDecoration(
                                                 boxShadow: const [
                                                   BoxShadow(
                                                       color: AppColors.greyColor100,
                                                       blurRadius: 8
                                                   )
                                                 ],
                                                 borderRadius: const BorderRadius.all(
                                                     Radius.circular(23)
                                                 ),
                                                 image: DecorationImage(
                                                     image: AssetImage(
                                                         imgPath[index]
                                                     ),
                                                     fit: BoxFit.cover
                                                 ),
                                               ),
                                             )
                                             // CachedNetworkImage(
                                             //   imageUrl: imgPath[index],
                                             //   imageBuilder: (context, imageProvider){
                                             //
                                             //     return Container(
                                             //       decoration: BoxDecoration(
                                             //         boxShadow: const [
                                             //           BoxShadow(
                                             //               color: AppColors.greyColor100,
                                             //               blurRadius: 8
                                             //           )
                                             //         ],
                                             //         borderRadius: const BorderRadius.all(
                                             //             Radius.circular(23)
                                             //         ),
                                             //         image: DecorationImage(
                                             //             image: imageProvider,
                                             //             fit: BoxFit.cover
                                             //         ),
                                             //       ),
                                             //     );
                                             //
                                             //   },
                                             //   placeholder: (context, url){
                                             //
                                             //     return Center(
                                             //         child: LoadingAnimationWidget.inkDrop(
                                             //             color: AppColors.denimBlueColor,
                                             //             size: 23
                                             //         )
                                             //     );
                                             //   },
                                             //   errorWidget: (context, url, error) => const Icon(
                                             //       Icons.error
                                             //   ),
                                             // )
                                         ),
                                       );
             
                                     }
                                 ),
                               ),
                             )
                         ),
                       ],
                     ),
                   ),
                   /// category section
                   const Padding(
                     padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                     child: Text(
                         "Categories"
                     ),
                   ),
                   ChangeNotifierProvider<CategoryViewModel>(
                       create: (BuildContext context) => _categoryViewModel,
                       child: Consumer<CategoryViewModel>(
                           builder: (context, value, _){
             
                             switch(value.categoryDataList.status){
             
                               case Status.LOADING:
                                 return const Center(
                                   child: CircularProgressIndicator(),
                                 );
             
                               case Status.COMPLETED:
                                 return Padding(
                                   padding: const EdgeInsets.only(
                                       left: 8
                                   ),
                                   child: SizedBox(
                                     height: screenHeight * 0.330,
                                     child: GridView.builder(
                                       scrollDirection: Axis.horizontal,
                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                         crossAxisSpacing: 8,
                                         mainAxisSpacing: 3,
                                         crossAxisCount: 2,
                                       ),
                                       itemCount: value.categoryDataList.data!.length,
                                       itemBuilder: (context, index){
             
                                         return Container(
                                           decoration: BoxDecoration(
                                               color: AppColors.whiteColor,
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: InkWell(
                                             onTap: ()=> Navigator.pushNamed(
                                                 context,
                                                 RoutesName.categoryDataActivity,
                                                 arguments: value.categoryDataList.data![index].name.toString()
                                             ),
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               children: [
                                                 SizedBox(
                                                     height: screenHeight * 0.11,
                                                     width: screenWidth * 0.7,
                                                     child: CachedNetworkImage(
                                                         imageUrl: value.categoryDataList.data![index].imgUrl.toString(),
                                                         imageBuilder: (context, imageProvider){
             
                                                           return CircleAvatar(
                                                             backgroundImage: imageProvider,
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
                                                         )
                                                     )
                                                 ),
                                                 Text(
                                                   value.categoryDataList.data![index].name.toString(),
                                                   style: const TextStyle(
                                                       fontSize: 11,
                                                       color: AppColors.blackColor
                                                   ),
                                                   textAlign: TextAlign.center,
                                                 )
                                               ],
                                             ),
                                           ),
                                         );
             
                                       },
                                     ),
                                   ),
                                 );
             
                               case Status.ERROR:
                                 return Text(
                                     value.categoryDataList.message.toString()
                                 );
             
                               default:
                                 return Container();
             
                             }
             
                           }
                       )
                   ),
                   SizedBox(
                       height: screenHeight * 0.005
                   ),
                   /// Places
                   Padding(
                     padding: const EdgeInsets.fromLTRB(18, 10, 0, 10),
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
                                 log(value.placeDataList.data.toString());
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
                                 return Text(
                                     value.placeDataList.message.toString()
                                 );
             
                               default:
                                 return Container();
             
                             }
             
                           },
                         )
                     ),
                   ),
                   SizedBox(
                       height: screenHeight * 0.008
                   ),
                 ],
               ),
             ),
           ),
       );

     }
    );

  }

}