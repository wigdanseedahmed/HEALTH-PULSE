import 'package:flutter_map/plugin_api.dart';
///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';


class FlutterMapZoomButtons extends StatelessWidget {

  ///--- ZOOM PARAM ---///
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;

  final FitBoundsOptions options =
  const FitBoundsOptions(padding: EdgeInsets.all(12));

  ///--- FILTER AND SEARCH PARAM ---///
  final List<HealthFacilityInformationModel> healthFacilitiesDatabaseContent;

  final List<String> healthFacilityType;
  final List<String> sectorType;
  final List<String> insuranceProvided;
  final List<String> insuranceSectorType;
  final List<String> isEmergencyProvided;
  final List<String> specialization;
  final List<String> workingHours;

  const FlutterMapZoomButtons({
    super.key,
    ///--- ZOOM PARAM ---///
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
    ///--- FILTER AND SEARCH PARAM ---///
    required this.healthFacilitiesDatabaseContent,
    required this.healthFacilityType,
    required this.sectorType,
    required this.insuranceProvided,
    required this.insuranceSectorType,
    required this.isEmergencyProvided,
    required this.specialization,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    final map = FlutterMapState.maybeOf(context)!;
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ///--- FILTER AND SEARCH ---///
          Padding(
            padding:
            EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'filter',
              mini: mini,
              backgroundColor: zoomInColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterScreenMA(
                      healthFacilitiesDatabaseContent: healthFacilitiesDatabaseContent,
                      healthFacilityType: healthFacilityType,
                      sectorType: sectorType,
                      insuranceSectorType: insuranceSectorType,
                      insuranceProvided: insuranceProvided,
                      isEmergencyProvided: isEmergencyProvided,
                      specialization: specialization,
                        workingHours: workingHours,
                    ),
                  ),
                );
              },
              child: Icon(Icons.filter_list_alt,
                  color: zoomInColorIcon ?? IconTheme.of(context).color),
            ),
          ),
          ///--- ZOOM ---///
          Padding(
            padding:
            EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: zoomInColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                final bounds = map.bounds;
                final centerZoom = map.getBoundsCenterZoom(bounds, options);
                var zoom = centerZoom.zoom + 1;
                if (zoom > maxZoom) {
                  zoom = maxZoom;
                }
                map.move(centerZoom.center, zoom,
                    source: MapEventSource.custom);
              },
              child: Icon(zoomInIcon,
                  color: zoomInColorIcon ?? IconTheme.of(context).color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: zoomOutColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                final bounds = map.bounds;
                final centerZoom = map.getBoundsCenterZoom(bounds, options);
                var zoom = centerZoom.zoom - 1;
                if (zoom < minZoom) {
                  zoom = minZoom;
                }
                map.move(centerZoom.center, zoom,
                    source: MapEventSource.custom);
              },
              child: Icon(zoomOutIcon,
                  color: zoomOutColorIcon ?? IconTheme.of(context).color),
            ),
          ),
        ],
      ),
    );
  }
}