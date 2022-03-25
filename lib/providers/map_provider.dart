import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  Marker? _marker;
  LatLng? _choosedPosition;
  late bool _isMarked;
  late bool _isCurrentPosition;

  MapProvider() {
    _isMarked = false;
    _isCurrentPosition = false;
  }

  //getters
  Marker? get marker => _marker;
  LatLng? get choosedPosition => _choosedPosition;
  bool get isMarked => _isMarked;
  bool get isCurrentPosition => _isCurrentPosition;

  //setter
  initializeMarker(LatLng position) {
    _isMarked = true;
    _marker = Marker(
      markerId: const MarkerId('location'),
      infoWindow: const InfoWindow(title: "Location"),
      position: position,
    );
    _choosedPosition = position;
  }

  addMarker(LatLng position) {
    _choosedPosition = position;
    _isMarked = true;
    _marker = Marker(
      markerId: const MarkerId('location'),
      infoWindow: const InfoWindow(title: "Location"),
      position: position,
    );
    notifyListeners();
  }

  deleteMarker() {
    _choosedPosition = null;
    _marker = null;
    _isMarked = false;
    notifyListeners();
  }
}
