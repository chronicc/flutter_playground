import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapData {
  static const double defaultZoom = 15.0;
  static const double maxDeviation = 0.005;
  static const double minDeviation = 0.0001;

  static const CameraPosition cpLeipzig = CameraPosition(
    target: LatLng(51.3400754, 12.3721149),
    zoom: defaultZoom,
  );

  static CameraPosition getRandomCameraPosition() {
    final double lat = cpLeipzig.target.latitude +
        (maxDeviation - minDeviation) * (2 * (0.5 - Random().nextDouble()));
    final double lng = cpLeipzig.target.longitude +
        (maxDeviation - minDeviation) * (2 * (0.5 - Random().nextDouble()));
    return CameraPosition(
      target: LatLng(lat, lng),
      zoom: defaultZoom,
    );
  }

  static List<CameraPosition> getRandomCameraPositions(int count) {
    final List<CameraPosition> positions = <CameraPosition>[];
    for (int i = 0; i < count; i++) {
      positions.add(getRandomCameraPosition());
    }
    return positions;
  }
}
