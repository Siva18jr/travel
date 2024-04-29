import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:levitate/firebase_options.dart';
import 'package:levitate/src/model/provider_state/auth_form_provider.dart';
import 'package:levitate/src/model/provider_state/booking_placed.dart';
import 'package:levitate/src/model/provider_state/budget_prediction_provider.dart';
import 'package:levitate/src/model/provider_state/global_provider.dart';
import 'package:levitate/src/model/provider_state/home_provider.dart';
import 'package:levitate/src/model/provider_state/place_details_provider.dart';
import 'package:levitate/src/res/data_urls/local_keys.dart';
import 'package:levitate/src/utils/routes/routes.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:levitate/src/model/provider_state/package_info_model.dart';
import 'package:levitate/src/view_model/auth_view_model.dart';
import 'package:levitate/src/view_model/category_view_model.dart';
import 'package:levitate/src/view_model/favourites_view_model.dart';
import 'package:levitate/src/view_model/hotels_view_model.dart';
import 'package:levitate/src/view_model/local_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:levitate/src/view_model/places_view_model.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox(LocalKeys.favouritesDatabase);
  await Hive.openBox(LocalKeys.localServerDatabase);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PackageInfoModel()
        ),
        ChangeNotifierProvider(
            create: (_) => LocalDataViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => AuthFormProvider()
        ),
        ChangeNotifierProvider(
            create: (_) => AuthViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => PlacesViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => CategoryViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => HomeProvider()
        ),
        ChangeNotifierProvider(
            create: (_) => FavouritesViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => PlaceDetailsProvider()
        ),
        ChangeNotifierProvider(
            create: (_) => GlobalProvider()
        ),
        ChangeNotifierProvider(
            create: (_) => HotelsViewModel()
        ),
        ChangeNotifierProvider(
            create: (_) => BookingPlaced()
        ),
        ChangeNotifierProvider(
            create: (_) => BudgetPredictionProvider()
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRouteSettings,
      ),
    );

  }

}