import 'package:flutter/material.dart';
import 'package:levitate/src/model/api_models/map_route_model.dart';
import 'package:levitate/src/utils/routes/routes_name.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GMapRoute extends StatefulWidget {

  final MapRouteModel items;

  const GMapRoute({super.key, required this.items});

  @override
  State<GMapRoute> createState() => _GMapRouteState();
}

class _GMapRouteState extends State<GMapRoute> {

  late WebViewController _controller;

  @override
  void initState() {

    super.initState();

    _controller = WebViewController.fromPlatformCreationParams(const PlatformWebViewControllerCreationParams())
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.google.com/maps/dir/${widget.items.userLatitude},${widget.items.userLongitude}/${widget.items.placeLatitude},${widget.items.placeLongitude}/?entry=ttu')
      );

  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      onPopInvoked: (val){

        WidgetsBinding.instance.addPostFrameCallback((_) {

          Navigator.pushNamed(context, RoutesName.homeActivity);

        });

      },
      child: Scaffold(
        body: WebViewWidget(
            controller: _controller
        )
      )
    );

  }

}


// class GMapRoute extends StatefulWidget {
//   const GMapRoute({super.key});
//
//   @override
//   State<GMapRoute> createState() => _GMapRouteState();
// }
//
// class _GMapRouteState extends State<GMapRoute> {
//
//   final Completer<GoogleMapController> _completer = Completer();
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//       target: LatLng(33.6844, 73.0479),
//     zoom: 14
//   );
//
//   final List<Marker> _markers = <Marker>[
//     const Marker(
//         markerId: MarkerId('1'),
//       position: LatLng(33.6844, 73.0479),
//       infoWindow: InfoWindow(
//         title: 'Initial Position'
//       )
//     )
//   ];
//
//   Future<Position> _getUserCurrentLocation() async{
//
//     await Geolocator.requestPermission().then((value){
//
//     }).onError((error, stackTrace){
//
//       log(error.toString());
//
//     });
//
//     return await Geolocator.getCurrentPosition();
//
//   }
//
//   _loadData(){
//
//     _getUserCurrentLocation().then((value) async {
//
//       _markers.add(
//           Marker(
//               markerId: const MarkerId('2'),
//               position: LatLng(value.latitude, value.longitude),
//               infoWindow: const InfoWindow(
//                   title: 'My Location'
//               )
//           )
//       );
//
//       CameraPosition cameraPosition = CameraPosition(
//           zoom: 14,
//           target: LatLng(value.longitude, value.longitude)
//       );
//
//       final GoogleMapController controller = await _completer.future;
//
//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//
//     });
//
//   }
//
//   @override
//   void initState() {
//
//     super.initState();
//     _loadData();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//         markers: Set<Marker>.of(_markers),
//         onMapCreated: (GoogleMapController control)=> _completer.complete(control),
//       )
//     );
//
//   }
//
// }