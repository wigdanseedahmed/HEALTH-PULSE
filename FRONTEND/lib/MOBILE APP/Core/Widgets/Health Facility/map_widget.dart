///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,

    ///--------- VARIABLES FOR MAP ---------///
    required this.latitude,
    required this.longitude,
    required this.currentLocationLatitude,
    required this.currentLocationLongitude,
    required this.mapController,

    ///--------- VARIABLES FOR SEARCH AND/OR FILTERED FACILITIES ---------///
    required this.filteredSearchHealthFacilitiesDatabaseContent,
    required this.readHealthFacilitiesDatabaseContent,
    required this.healthFacilityType,
    required this.sectorType,
    required this.insuranceProvided,
    required this.insuranceSectorType,
    required this.isEmergencyProvided,
    required this.specialization,
    required this.workingHours,
  });

  ///--------- VARIABLES FOR MAP ---------///

  final double latitude;
  final double longitude;
  final MapController mapController;
  final double currentLocationLatitude;
  final double currentLocationLongitude;

  ///--------- VARIABLES FOR SEARCH AND/OR FILTERED FACILITIES ---------///
  final List<HealthFacilityInformationModel>
      filteredSearchHealthFacilitiesDatabaseContent;

  final List<HealthFacilityInformationModel>
      readHealthFacilitiesDatabaseContent;

  final List<String> healthFacilityType;
  final List<String> sectorType;
  final List<String> insuranceProvided;
  final List<String> insuranceSectorType;
  final List<String> isEmergencyProvided;
  final List<String> specialization;
  final List<String> workingHours;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  ///------------------  READ USER DATA FROM BACKEND ------------------///
  // late List<MapModel> _data;
  /// VARIABLES USED TO GET RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  UserModel readUserJsonFileContent = UserModel();
  Future<UserModel>? futureUserInformation;

  getUserInfo() async {
    UserProfile.email =
    await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.email =
    await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.email}");

    //print(userInfo);
    setState(() {
      UserProfile.username = userInfo['data']['username'];
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.lastName = userInfo['data']['lastName'];
      UserProfile.userPhotoName = userInfo['data']['userPhotoName'];
      UserProfile.userPhotoURL = userInfo['data']['userPhotoURL'];
      UserProfile.userPhotoFile = userInfo['data']["userPhotoFile"];
      UserProfile.selectedTheme = userInfo['data']["selectedTheme"];
      UserProfile.bookmarkedHealthPersonnelList = userInfo['data']
      ["bookmarkedHealthPersonnelList"] ==
          null
          ? []
          : userInfo['data']["bookmarkedHealthPersonnelList"].cast<String>();
      UserProfile.bookmarkedHealthFacilitiesList = userInfo['data']
      ["bookmarkedHealthFacilitiesList"] ==
          null
          ? []
          : userInfo['data']["bookmarkedHealthFacilitiesList"].cast<String>();
      // print( UserProfile.bookmarkedHealthPersonnelList);
    });
  }

  Future<UserModel> updateUserJsonData(
      List<String> bookmarkedHealthFacilitiesList) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
    Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

    Map<String, List<String>> data = {
      //"username": usernameController.text,
      "bookmarkedHealthFacilitiesList": bookmarkedHealthFacilitiesList,
    };

    /// Create Request to get data and response to read data
    final response = await http.put(
      uri,
      headers: {
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Origin, Accept",
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
      body: json.encode(data),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      readUserJsonFileContent = UserModel.fromJson(jsonDecode(response.body));
      // readUserJsonFileContent = userModelListFromJson(response.body).where((element) => element.email == UserProfile.email).toList()[0];
      //print(readUserJsonFileContent);

      return readUserJsonFileContent;
    } else {
      throw Exception(
          'Unable to fetch products from the REST API: ${response.statusCode} ${response.headers}');
    }
  }

  ///--------- VARIABLES FOR MARKER ---------///
  List<MarkerData> customMarkers = [];
  HealthFacilityInformationModel selectedHealthFacility =
      HealthFacilityInformationModel();

  ///--------- VARIABLES FOR NAVIGATION ---------///
  late bool navigationMode = false;
  late int pointerCount = 0;
  late CenterOnLocationUpdate _centerOnLocationUpdate =
      CenterOnLocationUpdate.never;
  late TurnOnHeadingUpdate _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
  late StreamController<double?> _centerCurrentLocationStreamController =
      StreamController<double?>();
  late StreamController<void> _turnHeadingUpStreamController =
      StreamController<void>();


  final _snackBar = const SnackBar(
      content: Text('COMING SOON')
  );

  @override
  void initState() {
    super.initState();

    getUserInfo();

    ///--------- VARIABLES FOR MARKER ---------///
    customMarkers = [];

    ///--------- VARIABLES FOR NAVIGATION ---------///
    navigationMode = false;
    pointerCount = 0;
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
    _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    _centerCurrentLocationStreamController = StreamController<double?>();
    _turnHeadingUpStreamController = StreamController<void>();

    ///--------- VARIABLES FOR POPUP ---------///
    fabHeight = initFabHeight;
  }



  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchingPoint = LatLng(
      widget.latitude,
      widget.longitude,
    );
    panelHeightOpen = MediaQuery.of(context).size.height * .80;

    // Dummy Start and Destination Points
    double startLat = widget.currentLocationLatitude;
    double startLng = widget.currentLocationLongitude;
    double endLat = widget.latitude;
    double endLng = widget.longitude;

    var pointsGradient = <LatLng>[
      LatLng(startLat, startLng),
      LatLng(endLat, endLng),
    ];

    return infoWindowVisibleAllHF == true || infoWindowVisibleFilteredFH == true
        ? StatefulBuilder(builder: (context, setStateD) {
            return SlidingUpPanel(
              backdropEnabled: true,
              backdropTapClosesPanel: true,
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              body: buildFlutterMap(searchingPoint, pointsGradient),
              panelBuilder: (sc) => CustomPopup(
                healthFacilityInfo: selectedHealthFacility,
                sc: sc,
                directionOnTap: () {
                  setStateD(
                    () {
                      navigationMode = !navigationMode;
                      _centerOnLocationUpdate = navigationMode
                          ? CenterOnLocationUpdate.always
                          : CenterOnLocationUpdate.never;
                      _turnOnHeadingUpdate = navigationMode
                          ? TurnOnHeadingUpdate.always
                          : TurnOnHeadingUpdate.never;
                    },
                  );
                  if (navigationMode) {
                    _centerCurrentLocationStreamController.add(18);
                    _turnHeadingUpStreamController.add(null);
                  }
                },
                callOnTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                },
                startOnTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);},
                saveOnTap: () {
                  setStateD(
                        () {
                      UserProfile.bookmarkedHealthFacilitiesList == null
                          ? UserProfile.bookmarkedHealthFacilitiesList = []
                          : UserProfile.bookmarkedHealthFacilitiesList!;

                      if(selectedHealthFacility.medical_facility_name_en != null)   {
                        UserProfile.bookmarkedHealthFacilitiesList!.contains(
                                    selectedHealthFacility
                                        .medical_facility_name_en) ==
                                false
                            ? UserProfile.bookmarkedHealthFacilitiesList!.add(
                                selectedHealthFacility
                                    .medical_facility_name_en!)
                            : UserProfile.bookmarkedHealthFacilitiesList!
                                .remove(selectedHealthFacility
                                    .medical_facility_name_en!);
                      }

                      if(selectedHealthFacility.medical_facility_name_en == null && selectedHealthFacility.medical_facility_name_ar != null)   {
                        UserProfile.bookmarkedHealthFacilitiesList!.contains(
                            selectedHealthFacility
                                .medical_facility_name_ar) ==
                            false
                            ? UserProfile.bookmarkedHealthFacilitiesList!.add(
                            selectedHealthFacility
                                .medical_facility_name_ar!)
                            : UserProfile.bookmarkedHealthFacilitiesList!
                            .remove(selectedHealthFacility
                            .medical_facility_name_ar!);
                      }

                      if(selectedHealthFacility.medical_facility_name_en == null && selectedHealthFacility.medical_facility_name_ar == null && selectedHealthFacility.doctor_name != null) {
                        UserProfile.bookmarkedHealthFacilitiesList!.contains(
                                    selectedHealthFacility.doctor_name) ==
                                false
                            ? UserProfile.bookmarkedHealthFacilitiesList!
                                .add(selectedHealthFacility.doctor_name!)
                            : UserProfile.bookmarkedHealthFacilitiesList!
                                .remove(selectedHealthFacility.doctor_name!);
                      }

                      updateUserJsonData(
                          UserProfile.bookmarkedHealthFacilitiesList!);

                    },
                  );
                },
                shareOnTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                },
                websiteOnTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);},
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
              onPanelSlide: (double pos) => setStateD(() {
                fabHeight = pos * (panelHeightOpen - panelHeightClosed) +
                    initFabHeight +
                    260;
              }),
              header: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    infoWindowVisibleFilteredFH = false;
                    infoWindowVisibleAllHF = false;
                    selectedHealthFacility = HealthFacilityInformationModel();
                  });
                  setStateD(() {
                    infoWindowVisibleFilteredFH = false;
                    infoWindowVisibleAllHF = false;
                    selectedHealthFacility = HealthFacilityInformationModel();
                  });
                },
              ),
            );
          })
        : buildFlutterMap(searchingPoint, pointsGradient);
  }

  buildFlutterMap(LatLng searchingPoint, List<LatLng> pointsGradient) {
    return StatefulBuilder(builder: (context, setStateD) {
      return FlutterMap(
        mapController: widget.mapController,
        options: MapOptions(
          center: searchingPoint,
          zoom: 15.0,
          maxZoom: 28.0,
          interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
        ),
        nonRotatedChildren: [
          navigationMode == false ? Container() : Positioned(
            left: 20,
            bottom: fabHeight,
            child: FloatingActionButton(
              backgroundColor: navigationMode ? Colors.blue : Colors.grey,
              foregroundColor: Colors.white,
              onPressed: () {
                setStateD(
                  () {
                    navigationMode = !navigationMode;
                    _centerOnLocationUpdate = navigationMode
                        ? CenterOnLocationUpdate.always
                        : CenterOnLocationUpdate.never;
                    _turnOnHeadingUpdate = navigationMode
                        ? TurnOnHeadingUpdate.always
                        : TurnOnHeadingUpdate.never;
                  },
                );
                if (navigationMode) {
                  _centerCurrentLocationStreamController.add(18);
                  _turnHeadingUpStreamController.add(null);
                }
              },
              child: const Icon(
                Icons.navigation_outlined,
              ),
            ),
          ),
          FlutterMapZoomButtons(
            ///--- ZOOM PARAM ---///
            minZoom: 4,
            maxZoom: 19,
            mini: true,
            padding: 10,
            alignment: Alignment.bottomRight,

            ///--- FILTER AND SEARCH PARAM ---///
            healthFacilitiesDatabaseContent:
                widget.filteredSearchHealthFacilitiesDatabaseContent,
            healthFacilityType: widget.healthFacilityType,
            sectorType: widget.sectorType,
            insuranceSectorType: widget.insuranceSectorType,
            insuranceProvided: widget.insuranceProvided,
            isEmergencyProvided: widget.isEmergencyProvided,
            specialization: widget.specialization,
            workingHours: widget.workingHours,
          ),
        ],
        children: [
          ///--- MAP ---///
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            overrideTilesWhenUrlChanges: false,
            subdomains: const ['a', 'b', 'c'],
            additionalOptions: const {},
          ),

          ///--- NAVIGATOR ---///
          navigationMode == true
              ? PolylineLayer(
                  polylineCulling: true,
                  polylines: [
                    Polyline(
                      points: pointsGradient,
                      color: Colors.blue,
                    ),
                  ],
                )
              : Container(),

          ///--- ALL HEALTH FACILITY MARKERS ---///
          MarkerLayer(
            markers: _buildMarkersOnMap(
              latLng: searchingPoint,
              infoWindowVisible: infoWindowVisibleAllHF,
            ),
          ),

          ///--- FILTERED MARKERS ---///
          MarkerLayer(
            markers: _buildFilteredMarkersOnMap(
              latLng: searchingPoint,
            ),
          ),

          ///--- SEARCH MARKER ---///
          MarkerLayer(
            markers: [
              _searchingPointMarker(latLng: searchingPoint),
            ],
          ),

          ///--- CURRENT LOCATION MARKERS ---///

          navigationMode == true
              ? CurrentLocationLayer(
                  centerCurrentLocationStream:
                      _centerCurrentLocationStreamController.stream,
                  turnHeadingUpLocationStream:
                      _turnHeadingUpStreamController.stream,
                  centerOnLocationUpdate: _centerOnLocationUpdate,
                  turnOnHeadingUpdate: _turnOnHeadingUpdate,
                  style: const LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    markerSize: Size(30, 30),
                    markerDirection: MarkerDirection.heading,
                  ),
                )
              : Container(),
        ],
      );
    });
  }

  ///--------------------------------- BUILD SEARCH MARKER ---------------------------------///

  ///------------------------- SEARCH MARKER -------------------------///
  Marker _searchingPointMarker({required LatLng latLng}) {
    return Marker(
      point: latLng,
      builder: (BuildContext context) {
        return searchIcon;
      },
    );
  }

  ///------------------------- FILTERED MARKER -------------------------///
  Marker _filteredHealthFacilityLocationMarker(
      {required HealthFacilityInformationModel element}) {
    return Marker(
      point: LatLng(element.lat!, element.long!),
      width: 279.0,
      height: 256.0,
      builder: (context) => _buildCustomFilteredMarker(element),
    );
  }

  ///------------------------- MARKER -------------------------///
  Marker _healthFacilityLocationMarker(
      {required HealthFacilityInformationModel element}) {
    return Marker(
      point: LatLng(element.lat!, element.long!),
      width: 279.0,
      height: 256.0,
      builder: (context) => _buildCustomMarker(element),
    );
  }

  ///--------------------------------- ALL FILTERED HEALTH FACILITY MARKER ---------------------------------///
  var infoWindowVisibleFilteredFH = false;

  _buildFilteredMarkersOnMap({required LatLng latLng}) {
    List<Marker> markers = <Marker>[];
    for (var element in widget.filteredSearchHealthFacilitiesDatabaseContent) {
      if (element.lat != null || element.long != null) {
        markers.add(_filteredHealthFacilityLocationMarker(element: element));
      }
    }
    return markers;
  }

  ///------------------------- MARKER + DETAILS -------------------------///
  _buildCustomFilteredMarker(
      HealthFacilityInformationModel healthFacilityInfo) {
    return Stack(
      children: <Widget>[
        // _popup(healthFacilityInfo),
        _filteredMarker(healthFacilityInfo)
      ],
    );
  }

  ///---------------- MARKER ICON ----------------///
  _filteredMarker(HealthFacilityInformationModel healthFacilityInfo) {
    return Opacity(
      opacity: 1.0,
      // opacity: infoWindowVisibleFilteredFH ? 0.0 : 1.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          child: customFilterMarker(
              setCustomColourImageMapPin(healthFacilityInfo.facility_type),
              healthFacilityInfo.facility_type),
          onTap: () {
            setState(() {
              infoWindowVisibleAllHF = false;
              infoWindowVisibleFilteredFH = true;
              selectedHealthFacility = healthFacilityInfo;
              // print(selectedHealthFacility);
            });
          },
        ),
      ),
    );
  }

  ///--------------------------------- ALL HEALTH FACILITY MARKER ---------------------------------///
  var infoWindowVisibleAllHF = false;

  _buildMarkersOnMap(
      {required LatLng latLng, required bool infoWindowVisible}) {
    List<Marker> markers = <Marker>[];

    for (var element in widget.readHealthFacilitiesDatabaseContent) {
      if (element.lat != null || element.long != null) {
        markers.add(_healthFacilityLocationMarker(element: element));
      }
    }
    return markers;
  }

  ///------------------------- MARKER + DETAILS -------------------------///
  _buildCustomMarker(HealthFacilityInformationModel healthFacilityInfo) {
    return Stack(
      children: <Widget>[
        // _popup(healthFacilityInfo),
        _marker(healthFacilityInfo)
      ],
    );
  }

  ///---------------- MARKER ICON ----------------///
  _marker(HealthFacilityInformationModel healthFacilityInfo) {
    return Opacity(
      opacity: 1.0,
      // opacity: infoWindowVisibleAllHF ? 0.0 : 1.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            setState(() {
              infoWindowVisibleAllHF = true;
              infoWindowVisibleFilteredFH = false;
              selectedHealthFacility = healthFacilityInfo;

              //TODO: Add searchpoint equal to this
              // print(selectedHealthFacility);
            });
          },
          child: Image.asset(
            setCustomImageMapPin(healthFacilityInfo.facility_type),
            width: 19,
            height: 25,
          ),
        ),
      ),
    );
  }

  ///------------------ VARIABLES USED TO DETERMINE SLIDING PANEL ------------------///
  final double initFabHeight = 20.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 195.0;

  ///------------------------- POINTER FOR DIRECTION -------------------------///
  // Disable center and turn temporarily when user is manipulating the map.
  void _onPointerDown(e, l) {
    pointerCount++;
    setState(() {
      _centerOnLocationUpdate = CenterOnLocationUpdate.never;
      _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    });
  }

  // Enable center and turn again when user end manipulation.
  void _onPointerUp(e, l) {
    if (--pointerCount == 0 && navigationMode) {
      setState(() {
        _centerOnLocationUpdate = CenterOnLocationUpdate.always;
        _turnOnHeadingUpdate = TurnOnHeadingUpdate.always;
      });
      _centerCurrentLocationStreamController.add(18);
      _turnHeadingUpStreamController.add(null);
    }
  }

  // this will hold the generated polylines
  Set<Polyline> _polylines = {};

  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
}

//Create a new class to hold the Co-ordinates we've received from the response data

class LineString {
  LineString(this.lineString);

  List<dynamic> lineString;
}
