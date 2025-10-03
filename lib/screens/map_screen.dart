import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:quomia/designSystem/gap.dart';
import 'package:quomia/http/box_http.dart';
import 'package:quomia/http/mapbox_http.dart';
import 'package:quomia/screens/ar_screen.dart';
import 'package:quomia/screens/web_view_screen.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/common/custom_loader.dart';
import 'package:quomia/widgets/maps/buy_box_modal.dart';
import 'package:quomia/widgets/maps/search_modal.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  mapbox.MapboxMap? mapboxMap;
  mapbox.PointAnnotationManager? pointAnnotationManager;
  bool _addMarkerMode = false;
  bool _isLoadingLocation = false;
  bool _isSearching = false;

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
    return Stack(
      children: [
        Scaffold(
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
                  coordinates: mapbox.Position(coords.lat, coords.lng));

              _addMarker(userPoint, "assets/images/marker.png");

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
                  const Gap(height: 10),
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () => _openSearchModal(context),
                    backgroundColor: AppColors.light.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    tooltip: 'Cerca la località preferita',
                    child: Icon(
                      Icons.search,
                      color: AppColors.light.primaryText,
                    ),
                  ),
                  const Gap(height: 10),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: _goToMyLocation,
                    backgroundColor: AppColors.light.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    tooltip: 'La mia posizione',
                    child: Icon(
                      Icons.my_location,
                      color: AppColors.light.primaryText,
                    ),
                  ),
                  const Gap(height: 10),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () => _openBuyBoxModal(context),
                    backgroundColor: AppColors.light.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    tooltip: 'Crea un box temporale',
                    child: FaIcon(
                      FontAwesomeIcons.hourglass,
                      color: AppColors.light.primaryText,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
        if (_isLoadingLocation) const CustomLoader()
      ],
    );
  }

  Future<void> _loadBoxesAndAddMarkers() async {
    HttpBoxService httpBoxService = HttpBoxService();
    final boxes = await httpBoxService.fetchBoxes();

    await pointAnnotationManager?.deleteAll();

    final ByteData bytes = await rootBundle.load("assets/images/marker.png");
    final Uint8List imageBytes = bytes.buffer.asUint8List();

    for (final box in boxes) {
      final point = mapbox.Point(
        coordinates:
            mapbox.Position(box.location.longitude, box.location.latitude),
      );

      pointAnnotationManager?.create(
        mapbox.PointAnnotationOptions(
          geometry: point,
          iconSize: 2.0,
          image: imageBytes,
          textField: box.info.title,
          textSize: 14.0,
          textOffset: [5.0, 0.0],
        ),
      );
    }
  }

  Future<void> _searchAddress(String query) async {
    if (query.isEmpty) {
      return;
    }

    setState(() => _isSearching = true);

    try {
      HttpMapboxService httpMapboxService = HttpMapboxService();
      final coords = await httpMapboxService.getCoordinates(query);

      if (coords != null && mapboxMap != null) {
        final lat = coords['lat']!;
        final lng = coords['lng']!;

        final point = mapbox.Point(
          coordinates: mapbox.Position(lng, lat),
        );

        await mapboxMap!.setCamera(
          mapbox.CameraOptions(center: point, zoom: 14),
        );

        await _addMarker(point, "assets/images/location_pin.png");

        debugPrint("Indirizzo trovato: $lat, $lng");
      } else {
        debugPrint("Nessun risultato trovato per '$query'");
      }
    } catch (e) {
      debugPrint("Errore ricerca: $e");
    } finally {
      setState(() => _isSearching = false);
    }
  }

  void _onMapCreated(mapbox.MapboxMap map) async {
    mapboxMap = map;

    pointAnnotationManager =
        await mapboxMap?.annotations.createPointAnnotationManager();

    await _goToMyLocation();

    await _loadBoxesAndAddMarkers();

    pointAnnotationManager?.tapEvents(onTap: (annotation) {
      debugPrint("Marker tappato: ${annotation.id}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(),
        ),
      );

      return true;
    });
  }

  Future<void> _goToMyLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
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

        _addMarker(userPoint, "assets/images/location_pin.png");
      }
    } catch (e) {
      debugPrint("Errore geolocalizzazione: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
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

  void _openSearchModal(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.light.primaryBackground,
      builder: (context) => const AddressBottomSheet(),
    );

    if (result != null) {
      debugPrint("Indirizzo inserito: $result");
      await _searchAddress(result);
    }
  }

  Future<void> _addMarker(mapbox.Point point, String asset) async {
    if (pointAnnotationManager == null) {
      return;
    }

    final ByteData bytes = await rootBundle.load(asset);
    final Uint8List imageBytes = bytes.buffer.asUint8List();

    pointAnnotationManager!.create(
      mapbox.PointAnnotationOptions(
        geometry: point,
        iconSize: asset == "assets/images/location_pin.png" ? 0.3 : 2.0,
        image: imageBytes,
      ),
    );
  }
}
