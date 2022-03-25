// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/map_provider.dart';

// ignore: must_be_immutable
class ChooseLocation extends StatelessWidget {
  ChooseLocation({
    Key? key,
  }) : super(key: key);

  late final GoogleMapController _googleMapController;
  CameraPosition? _initialCameraPosition;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: Consumer2<MapProvider, LocationProvider>(
        builder: (ctx, MapProvider coMap, LocationProvider coLocation, child) {
          if (_initialCameraPosition == null) {
            if (coLocation.location != null) {
              _initialCameraPosition =
                  CameraPosition(target: coLocation.location!, zoom: 5);
              coMap.initializeMarker(coLocation.location!);
            } else {
              _initialCameraPosition =
                  const CameraPosition(target: LatLng(0, 0));
            }
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Change location",
                style: TextStyle(color: Colors.blueGrey.shade800),
              ),
              iconTheme: IconThemeData(color: Colors.blueGrey.shade800),
              leading: coMap.isMarked
                  ? SafeArea(
                      child: IconButton(
                        onPressed: () => coMap.deleteMarker(),
                        icon: const Icon(Icons.close),
                      ),
                    )
                  : null,
              actions: [
                if (coMap.isMarked)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      onPressed: () {
                        coLocation.setLocation(coMap.choosedPosition);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Choose",
                        style: TextStyle(
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            body: GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: _initialCameraPosition!,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {if (coMap.isMarked) coMap.marker!},
              onLongPress: (position) => coMap.addMarker(position),
              mapToolbarEnabled: true,
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.my_location),
              onPressed: () async {
                if (coLocation.currentLocation != null) {
                  await _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          zoom: 5, target: coLocation.currentLocation!),
                    ),
                  );
                  coMap.addMarker(coLocation.currentLocation!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
