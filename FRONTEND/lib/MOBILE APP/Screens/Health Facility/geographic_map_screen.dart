///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:latlong2/latlong.dart';

class GeographicLocationMapScreenMA extends StatefulWidget {
  const GeographicLocationMapScreenMA({
    super.key,
    required this.healthFacilitiesDatabaseContent,
    required this.healthFacilityType,
    required this.sectorType,
    required this.insuranceProvided,
    required this.insuranceSectorType,
    required this.isEmergencyProvided,
    required this.specialization,
    required this.workingHours,
  });

  final List<HealthFacilityInformationModel> healthFacilitiesDatabaseContent;

  final List<String> healthFacilityType;
  final List<String> sectorType;
  final List<String> insuranceProvided;
  final List<String> insuranceSectorType;
  final List<String> isEmergencyProvided;
  final List<String> specialization;
  final List<String> workingHours;

  @override
  State<GeographicLocationMapScreenMA> createState() =>
      _GeographicLocationMapScreenMAState();
}

class _GeographicLocationMapScreenMAState
    extends State<GeographicLocationMapScreenMA> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCurrentPosition().then((value) {
        setState(() {
          currentPosition = value;
        });
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? Container()
        : BlocProvider(
            create: (context) =>
                MapBloc(currentPosition!.latitude, currentPosition!.longitude),
            child: MapViewMA(
              healthFacilitiesDatabaseContent:
                  widget.healthFacilitiesDatabaseContent,
              healthFacilityType: widget.healthFacilityType,
              sectorType: widget.sectorType,
              insuranceProvided: widget.insuranceProvided,
              insuranceSectorType: widget.insuranceSectorType,
              isEmergencyProvided: widget.isEmergencyProvided,
              specialization: widget.specialization,
              currentLocationLatitude: currentPosition!.latitude,
              currentLocationLongitude: currentPosition!.longitude,
              workingHours: widget.workingHours,
            ),
          );
  }

  ///------------------ CURRENT LOCATION ------------------///

  ///--------- VARIABLES ---------///
  LatLng? currentPosition;

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  ///--------- GET CURRENT POSITION ---------///
  Future<LatLng> getCurrentPosition() async {
    final hasPermission = await handlePermissionCurrentLocation();

    if (!hasPermission) {
      return LatLng(15.5007, 32.5599);
    } else {
      final position = await _geoLocatorPlatform.getCurrentPosition(
          locationSettings:
              const LocationSettings(accuracy: LocationAccuracy.high));

      updatePositionList(
        _PositionItemType.position,
        position.toString(),
      );

      return LatLng(position.latitude, position.longitude);
    }
  }

  ///--------- HANDLE PERMISSION ---------///
  Future<bool> handlePermissionCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geoLocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      updatePositionList(
        _PositionItemType.log,
        'Location services are disabled.',
      );

      return false;
    }

    permission = await _geoLocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        updatePositionList(
          _PositionItemType.log,
          'Permission denied.',
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      updatePositionList(
        _PositionItemType.log,
        'Permission denied forever.',
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    updatePositionList(
      _PositionItemType.log,
      'Permission granted.',
    );
    return true;
  }

  ///--------- UPDATE POSITION LIST ---------///
  void updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
