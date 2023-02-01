///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

class MapViewMA extends StatefulWidget {
  const MapViewMA({
    Key? key,
    required this.currentLocationLatitude,
    required this.currentLocationLongitude,
    required this.healthFacilitiesDatabaseContent,
    required this.healthFacilityType,
    required this.sectorType,
    required this.insuranceProvided,
    required this.insuranceSectorType,
    required this.isEmergencyProvided,
    required this.specialization,
    required this.workingHours,
  }) : super(key: key);

  final double currentLocationLatitude;
  final double currentLocationLongitude;

  final List<HealthFacilityInformationModel> healthFacilitiesDatabaseContent;

  final List<String> healthFacilityType;
  final List<String> sectorType;
  final List<String> insuranceProvided;
  final List<String> insuranceSectorType;
  final List<String> isEmergencyProvided;
  final List<String> specialization;
  final List<String> workingHours;

  @override
  State<MapViewMA> createState() => _MapViewMAState();
}

class _MapViewMAState extends State<MapViewMA> with TickerProviderStateMixin {
  DatabaseMethods databaseMethods = DatabaseMethods();

  ///------------------  READ GEOGRAPHIC DATA FROM BACKEND ------------------///
  List<HealthFacilityInformationModel> readHealthFacilitiesDatabaseContent =
      <HealthFacilityInformationModel>[];

  List<HealthFacilityInformationModel>
      filteredSearchHealthFacilitiesDatabaseContent =
      <HealthFacilityInformationModel>[];

  Future<List<HealthFacilityInformationModel>>
      readingHealthFacilitiesDatabase() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getHealthFacilities);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      readHealthFacilitiesDatabaseContent =
          healthFacilityInformationFromJson(response.body);
      // print("Geo: $readHealthFacilitiesDatabaseContent");
      return readHealthFacilitiesDatabaseContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///------------------ VARIABLES USED TO DETERMINE SCREEN SIZE ------------------///
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  ///------------------ INIT STATE ------------------///
  @override
  void initState() {
    ///VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return FutureBuilder(
      future: readingHealthFacilitiesDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return buildScaffold(screenSize);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  buildScaffold(Size screenSize) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (widget.healthFacilitiesDatabaseContent.isEmpty) {
        filteredSearchHealthFacilitiesDatabaseContent =
            []; //readHealthFacilitiesDatabaseContent
      } else {
        filteredSearchHealthFacilitiesDatabaseContent =
            widget.healthFacilitiesDatabaseContent;
      }

      return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: buildAppBar(),
        body: buildBody(screenSize, state),
        floatingActionButton: LocationInput(
          onSelected: (location) {
            if (location.isBlank == false) {
              context.read<MapBloc>().add(
                    ShowLocation(
                      latitude: location.lat!,
                      longitude: location.long!,
                    ),
                  );
            } else {
              // print("Null");
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        bottomNavigationBar: const CustomBottomNavBarMA(
          selectedMenu: MenuState.GeographicMapScreen,
        ),
      );
    });
  }

  ///------------------ APP BAR ------------------///
  buildAppBar() {
    return AppBar(
      toolbarHeight: 10.0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-1.0, 0.0),
            end: const Alignment(1.0, 0.0),
            colors: linearGradientColourScheme,
          ),
        ),
      ),
      // title: Text('Title'),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  ///------------------ BODY ------------------///
  buildBody(Size screenSize, MapState state) {
    return Stack(children: [
      SizedBox(
        height: screenSize.height,
        child: buildGeographicMap(state, screenSize),
      ),
    ]);
  }

  ///---------  GEOGRAPHIC MAP ---------///
  MapController mapController = MapController();

  buildGeographicMap(MapState state, Size screenSize) {
    return MapWidget(
      ///--- COORDINATES ---///
      key: Key('map${state.latitude}${state.longitude}'),
      latitude: state.latitude,
      longitude: state.longitude,
      currentLocationLatitude: widget.currentLocationLatitude,
      currentLocationLongitude: widget.currentLocationLongitude,

      ///--- MAP CONTROLLER ---///
      mapController: mapController,

      ///--- FILTER AND SEARCH PARAM ---///
      readHealthFacilitiesDatabaseContent: readHealthFacilitiesDatabaseContent,
      filteredSearchHealthFacilitiesDatabaseContent:
          filteredSearchHealthFacilitiesDatabaseContent,
      healthFacilityType: widget.healthFacilityType,
      sectorType: widget.sectorType,
      insuranceSectorType: widget.insuranceSectorType,
      insuranceProvided: widget.insuranceProvided,
      isEmergencyProvided: widget.isEmergencyProvided,
      specialization: widget.specialization,
      workingHours: widget.workingHours,
    );
  }
}
