import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/maps/buy_box_modal.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;

  PointAnnotationManager? pointAnnotationManager;

  // Opzioni iniziali per la telecamera della mappa
  final CameraOptions _camera = CameraOptions(
    center: Point(coordinates: Position(-98.0, 39.5)),
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
        actions: const [],
        centerTitle: false,
      ),
      body: MapWidget(
        cameraOptions: _camera,
        styleUri: MapboxStyles.MAPBOX_STREETS,
        onMapCreated: (MapboxMap controller) {
          mapboxMap = controller;

          controller.annotations.createPointAnnotationManager().then((value) {
            pointAnnotationManager = value;
          });
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FloatingActionButton(
            onPressed: () => _openBuyBoxModal(context),
            backgroundColor: AppColors.light.secondary,
            child: FaIcon(
              Icons.time_to_leave,
              color: AppColors.light.primaryText,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
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

  void _addMarker(Point point) {
    if (pointAnnotationManager == null) {
      return;
    }

    pointAnnotationManager!.deleteAll();

    pointAnnotationManager!.create(
      PointAnnotationOptions(
        geometry: point,
        iconSize: 1.5,
        textField: "Posizione Selezionata",
      ),
    );
  }
}
