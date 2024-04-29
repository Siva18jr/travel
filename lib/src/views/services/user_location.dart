import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levitate/src/model/api_models/map_route_model.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';

class UserCurrentPosition extends StatefulWidget {

  final String latitude;
  final String longitude;

  const UserCurrentPosition({super.key, required this.latitude, required this.longitude});

  @override
  State<UserCurrentPosition> createState() => _UserCurrentPositionState();
}

class _UserCurrentPositionState extends State<UserCurrentPosition> {

  _getUserLocation(BuildContext context) async{

    await Geolocator.getCurrentPosition().then((value){

      Navigator.pushNamed(
          context,
          RoutesName.gMapRouteActivity,
          arguments: MapRouteModel(
            userLatitude: widget.latitude,
            userLongitude: widget.longitude,
            placeLatitude: value.latitude.toString(),
            placeLongitude: value.longitude.toString()
          )
      );

    });

  }

  @override
  void initState() {

    super.initState();

    _getUserLocation(context);

  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      )
    );

  }

}