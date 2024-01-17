import 'package:levitate/src/model/api_models/places_model.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/views/auth/login.dart';
import 'package:levitate/src/views/category_data.dart';
import 'package:levitate/src/views/firm/about_activity.dart';
import 'package:levitate/src/views/firm/contact_activity.dart';
import 'package:levitate/src/views/home.dart';
import 'package:levitate/src/views/info/my_favourites.dart';
import 'package:levitate/src/views/info/my_notifications.dart';
import 'package:levitate/src/views/info/my_visits.dart';
import 'package:levitate/src/views/firm/privacy_policy_activity.dart';
import 'package:levitate/src/views/place_detail.dart';
import 'package:levitate/src/views/search_places.dart';
import 'package:levitate/src/views/services/intro_screen.dart';
import 'package:levitate/src/views/services/splash_screen.dart';
import 'package:levitate/src/views/firm/terms_activity.dart';
import 'package:flutter/material.dart';

class Routes{

  static Route<dynamic> generateRouteSettings(RouteSettings settings){

    switch(settings.name){

      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen()
        );

      case RoutesName.introductionScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingPage()
        );

      case RoutesName.homeActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Home()
        );

      case RoutesName.myOrdersActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyVisitsActivity()
        );

      case RoutesName.contactActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactUsActivity()
        );

      case RoutesName.aboutActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AboutUsActivity()
        );

      case RoutesName.privacyActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PrivacyPolicyActivity()
        );

      case RoutesName.termsActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TermsActivity()
        );

      case RoutesName.notificationActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyNotifications()
        );

      case RoutesName.loginActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginActivity()
        );

      case RoutesName.searchPlacesActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SearchPlaces()
        );

      case RoutesName.myFavouritesActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyFavourites()
        );

      case RoutesName.placeDetailActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => PlaceDetail(
              item: settings.arguments as PlacesModel,
            )
        );

      case RoutesName.categoryDataActivity:
        return MaterialPageRoute(
            builder: (BuildContext context) => CategoryData(
                category: settings.arguments.toString()
            )
        );

      default:
        return MaterialPageRoute(
            builder: (_){

              return const Scaffold(
                body: Center(
                  child: Text(
                      "No route Found"
                  ),
                ),
              );

            }
        );

    }

  }

}