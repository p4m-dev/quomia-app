import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo; // alias geolocator
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox; // alias mapbox
import 'package:quomia/screens/ar_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/maps/buy_box_modal.dart';
import 'dart:typed_data';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  mapbox.MapboxMap? mapboxMap;
  mapbox.PointAnnotationManager? pointAnnotationManager;
  bool _addMarkerMode = false;

  final mapbox.CameraOptions _camera = mapbox.CameraOptions(
    center: mapbox.Point(
      coordinates: mapbox.Position(-98.0, 39.5),
    ),
    zoom: 2,
    bearing: 0,
    pitch: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.light.background,
      appBar: AppBar(
        backgroundColor: AppColors.light.primaryBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.light.primaryText,
            size: 30,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Quomia',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: AppColors.light.info,
            fontSize: 28,
          ),
        ),
        centerTitle: false,
      ),
      body: mapbox.MapWidget(
        cameraOptions: _camera,
        styleUri: mapbox.MapboxStyles.MAPBOX_STREETS,
        onMapCreated: _onMapCreated,
        onTapListener: (mapbox.MapContentGestureContext context) {
          // Place only if is active
          if (!_addMarkerMode) {
            return;
          }
          // Get Lat and Lng
          final coords = context.point.coordinates;
          final userPoint = mapbox.Point(
            coordinates: mapbox.Position(coords.lat, coords.lng)
          );

          _addMarker(userPoint);

          setState(() {
            _addMarkerMode = false;
          });
        },

      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: _goToMyLocation,
                backgroundColor: AppColors.light.secondary,
                child: const Icon(Icons.my_location),
              ),
              const SizedBox(height: 12),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () => _openBuyBoxModal(context),
                backgroundColor: AppColors.light.secondary,
                child: const Icon(Icons.shopping_bag),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _onMapCreated(mapbox.MapboxMap map) async {
    mapboxMap = map;

    pointAnnotationManager = await mapboxMap?.annotations.createPointAnnotationManager();

    pointAnnotationManager?.tapEvents(onTap: (annotation) {
      debugPrint("Marker tappato: ${annotation.id}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ARViewScreen(
          ),
        ),
      );

      return true;
    });

    // // Add Marker on Map
    // map.addInteraction(
    //   mapbox.TapInteraction.onMap((mapbox.MapContentGestureContext context) async {
    //     final point = context.point;
    //     await _addMarker(point);
    //   })
    // );
  }

  Future<void> _goToMyLocation() async {
    final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    // Check for permission
    var permission = await geo.Geolocator.checkPermission();

    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) {
        return;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      return;
    }

    // Get current position
    final geo.Position pos = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );

    if (mapboxMap != null) {
      final userPoint = mapbox.Point(
        coordinates: mapbox.Position(pos.longitude, pos.latitude),
      );

      mapboxMap!.setCamera(
        mapbox.CameraOptions(center: userPoint, zoom: 14),
      );

      _addMarker(userPoint);
    }
  }

  void _openBuyBoxModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const BuyBoxModal();
      },
    );
  }

  Future<void> _addMarker(mapbox.Point point) async {
    if (pointAnnotationManager == null) {
      return;
    }

    final ByteData bytes = await rootBundle.load("assets/images/marker.png");
    final Uint8List imageBytes = bytes.buffer.asUint8List();

    pointAnnotationManager!.deleteAll();

    pointAnnotationManager!.create(
      mapbox.PointAnnotationOptions(
        geometry: point,
        iconSize: 2.0,
        image: imageBytes,
      ),
    );
  }

  void _addCustomMarker() {
    if (pointAnnotationManager == null) {
      return;
    }

    // esempio: piazza il marker a Roma
    final customPoint = mapbox.Point(
      coordinates: mapbox.Position(12.4964, 41.9028),
    );

    pointAnnotationManager!.create(
      mapbox.PointAnnotationOptions(
        geometry: customPoint,
        iconSize: 2.0,
        textField: "Marker personalizzato",
      ),
    );

    // opzionale: centra la mappa sul marker
    mapboxMap?.setCamera(
      mapbox.CameraOptions(center: customPoint, zoom: 10),
    );
  }

}
