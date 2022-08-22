import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../global/global.dart';

class GoogleMapsPage extends StatefulWidget {


  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  MapType currentMapType = MapType.normal;
  BitmapDescriptor? customIcon;

  static final CameraPosition initCameraPosition = CameraPosition(
      bearing: 30,
      target: LatLng(2.225349, 102.455358),
      tilt: 45,
      zoom: 13.5);

  @override
  Widget build(BuildContext context) {
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(2.221603, 102.453159),
        infoWindow: InfoWindow(title: "La Sagrada Familia"),
        icon: customIcon!
    ));

    DatabaseReference ref = FirebaseDatabase.instance.ref().child("Drivers")
        .child(currentFirebaseUser!.uid).child("CheckPoint");

    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: currentMapType,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initCameraPosition,
              compassEnabled: true,
              markers: listMarkers,
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                child: const Icon(Icons.map, size: 30),
                onPressed: _onMapTypeChanged,
              ),
            )
          ],
        ));
  }

  void _onMapTypeChanged() {
    setState(() {
      mapType: MapType.normal;
    });
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "images/pin.png");
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }
}