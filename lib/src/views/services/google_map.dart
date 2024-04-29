import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {

  final double latitude;
  final double longitude;

  const GoogleMapWidget({super.key, required this.latitude, required this.longitude});

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {

    CameraPosition initialPlace = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 13
    );

    return GoogleMap(
      initialCameraPosition: initialPlace,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );

  }

}