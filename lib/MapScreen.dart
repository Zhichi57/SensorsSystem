import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensors_system/GeoSensors.dart';

import 'customDrawer.dart';


class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState()=> _MapScreenState();
}

class _MapScreenState extends State<MapScreen>{
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(53.0212753, 36.0330878);

  final Set<Marker> _markers = {};


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    addMarkers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Карта"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
        markers: _markers,
      ),
      drawer: CustomDrawer(
      ),
    );
  }

  void addMarkers(){

    setState(() {
      for (int i=0; i<=geoList.length-1; i++){
        _markers.add(
          Marker(
            markerId: MarkerId('$i'),
            position:geoList[i],
            infoWindow: InfoWindow(
                title: 'Датчик №${i+1}',
                snippet: 'Показание ${geoData[i]}%'
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      }
    });
  }
}
