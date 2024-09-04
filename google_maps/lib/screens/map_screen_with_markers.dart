import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps/data/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenWithMarkers extends StatefulWidget {
  const MapScreenWithMarkers({super.key});

  @override
  State<MapScreenWithMarkers> createState() => MapScreenWithMarkersState();
}

class MapScreenWithMarkersState extends State<MapScreenWithMarkers> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = <Marker>{};

  bool _obfuscatePositions = false;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: const MarkerId('berlin'),
      position: MapData.cpLeipzig.target,
      infoWindow: const InfoWindow(
        title: 'You',
      ),
    ));
    MapData.getRandomCameraPositions(13).forEach((CameraPosition position) {
      _markers.add(
        Marker(
          markerId: MarkerId(position.target.toString()),
          position: position.target,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: const InfoWindow(
            title: 'Someone else',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: MapData.cpLeipzig,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _obfuscatePositions ? <Marker>{_markers.first} : _markers,
        circles: _obfuscatePositions
            ? <Circle>{
                Circle(
                  circleId: const CircleId('others'),
                  center: MapData.cpLeipzig.target,
                  radius: 500,
                  strokeWidth: 1,
                  fillColor: Colors.blue.withOpacity(0.5),
                  strokeColor: Colors.blue,
                )
              }
            : <Circle>{},
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: _obfuscatePositions
            ? const Text("Deobfuscate Positions")
            : const Text("Obfuscate Positions"),
        icon: _obfuscatePositions
            ? const Icon(Icons.lock_open_sharp)
            : const Icon(Icons.lock_sharp),
        onPressed: () {
          setState(() {
            _obfuscatePositions = !_obfuscatePositions;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
