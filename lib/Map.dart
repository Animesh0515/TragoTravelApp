import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Map")),
      ),
      body: Stack(
        children: <Widget>[googleMap(context)],
      ),
    );
  }

  Widget googleMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(27.2046, 77.4977), zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {kathmanduMarker},
        )
        // GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(27.2046, 77.4977),zoom: 12))
        );
  }
}

Marker kathmanduMarker = Marker(
    markerId: MarkerId("Kathamandu"),
    position: LatLng(27.7172, 85.3240),
    infoWindow: InfoWindow(title: 'Kathmandu'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
