import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/screens/weather_page.dart';
import 'package:weather_app/services/location_api.dart';

class LocationMap extends StatefulWidget {
  final String title;
  const LocationMap({Key? key, required this.title}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  final CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(0, 0));
  LatLng? _myPosition;
  late GoogleMapController _googleMapController;
  Marker? _marker;
  LatLng? _choosedPosition;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.grey.shade900),
        ),
        leading: _choosedPosition != null
            ? SafeArea(
                child: IconButton(
                  onPressed: () => setState(() {
                    _choosedPosition = null;
                    _marker = null;
                  }),
                  icon: Icon(Icons.close, color: Colors.grey.shade900),
                ),
              )
            : SafeArea(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back, color: Colors.grey.shade900),
                ),
              ),
        actions: [
          if (_choosedPosition != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: onClickChoose,
                child: Text(
                  "Choose",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
        ],
      ),
      body: FutureBuilder<LatLng>(
          future: LocationApi().getCurrentLocation(),
          builder: (context, AsyncSnapshot<LatLng> position) {
            if (position.hasData) {
              _myPosition = position.data ?? position.requireData;
            }
            return GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {if (_marker != null) _marker!},
              onLongPress: _addMarker,
              mapToolbarEnabled: true,
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.location_searching_outlined),
        onPressed: () {
          if (_myPosition != null) {
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 12,
                  target: LatLng(
                    _myPosition!.latitude,
                    _myPosition!.longitude,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _addMarker(LatLng latLng) {
    _choosedPosition = latLng;
    setState(() {
      _marker = Marker(
        markerId: const MarkerId('location'),
        infoWindow: const InfoWindow(title: "Location"),
        position: latLng,
      );
    });
  }

  void onClickChoose() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => WeatherPage(
          title: "Weather app",
          choosedPosition: _choosedPosition,
        ),
      ),
    );
  }
}
