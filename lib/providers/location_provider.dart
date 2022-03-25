import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/services/location_api.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _location;
  LatLng? _currentLocation;
  late bool _isCurrentLocation;
  late bool _error;
  late String _errorMessage;

  LocationProvider() {
    _error = false;
    _errorMessage = '';
    _isCurrentLocation = true;
    setLocation();
  }

  //getter
  LatLng? get location => _location;
  LatLng? get currentLocation => _currentLocation;
  bool get isCurrentLocation => _isCurrentLocation;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  //Setter
  void setLocation([LatLng? location]) async {
    if (location != null) {
      _location = location;
      if (_currentLocation != null && _currentLocation == _location) {
        _isCurrentLocation = true;
      } else {
        _isCurrentLocation = false;
      }
    } else {
      try {
        LatLng currentLocation = await LocationApi().getCurrentLocation();
        _location = currentLocation;
        _currentLocation = currentLocation;
        _isCurrentLocation = true;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
      }
    }
    notifyListeners();
  }
}
