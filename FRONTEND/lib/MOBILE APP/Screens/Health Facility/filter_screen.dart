///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

class FilterScreenMA extends StatefulWidget {
  const FilterScreenMA({
    Key? key,
    required this.healthFacilitiesDatabaseContent,
    required this.healthFacilityType,
    required this.sectorType,
    required this.insuranceProvided,
    required this.insuranceSectorType,
    required this.isEmergencyProvided,
    required this.specialization,
    required this.workingHours,
  }) : super(key: key);

  final List<HealthFacilityInformationModel> healthFacilitiesDatabaseContent;
  final List<String> healthFacilityType;
  final List<String> sectorType;
  final List<String> insuranceProvided;
  final List<String> insuranceSectorType;
  final List<String> isEmergencyProvided;
  final List<String> specialization;
  final List<String> workingHours;

  @override
  State<FilterScreenMA> createState() => _FilterScreenMAState();
}

class _FilterScreenMAState extends State<FilterScreenMA> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  ///------------------  READ GEOGRAPHIC DATA FROM BACKEND ------------------///
  List<HealthFacilityInformationModel> readHealthFacilitiesDatabaseContent =
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

  ///------------------ VARIABLES USED TO FILTER ------------------///
  List<HealthFacilityInformationModel> filteredHealthFacilitiesDatabaseContent =
      <HealthFacilityInformationModel>[];

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

    healthFacilityTypeSelected = widget.healthFacilityType;
    sectorTypeSelected = widget.sectorType;
    insuranceSectorTypeSelected = widget.insuranceSectorType;
    insuranceSelected = widget.insuranceProvided;
    emergencySelected = widget.isEmergencyProvided;
    specializationSelected = widget.specialization;

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
            for (int i = 0;
                i < readHealthFacilitiesDatabaseContent.length;
                i++) {
              ///-------------------------- HEALTH FACILITY LIST --------------------------///
              /*readHealthFacilitiesDatabaseContent[i].facility_type != null
                  ? healthFacilityTypeList.contains(
                          readHealthFacilitiesDatabaseContent[i].facility_type)
                      ? healthFacilityTypeList
                      : healthFacilityTypeList.add(
                          readHealthFacilitiesDatabaseContent[i].facility_type!)
                  : healthFacilityTypeList;*/

              ///-------------------------- SPECIALITY LIST --------------------------///
              readHealthFacilitiesDatabaseContent[i].speciality == null
                  ? specializationListEN
                  : {
                      for (int j = 0;
                          j <
                              readHealthFacilitiesDatabaseContent[i]
                                  .speciality!
                                  .length;
                          j++)
                        {
                          readHealthFacilitiesDatabaseContent[i].speciality !=
                                  null
                              ? specializationListEN.contains(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .speciality![j])
                                  ? specializationListEN
                                  : specializationListEN.add(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .speciality![j])
                              : specializationListEN
                        }
                    };

              ///-------------------------- INSURANCE LIST --------------------------///
              /*readHealthFacilitiesDatabaseContent[i].insurance_provided == null
                  ? insuranceCompaniesListEN
                  : {
                      for (int j = 0;
                          j <
                              readHealthFacilitiesDatabaseContent[i]
                                  .insurance_provided!
                                  .length;
                          j++)
                        {
                          readHealthFacilitiesDatabaseContent[i]
                                      .insurance_provided !=
                                  null
                              ? insuranceCompaniesListEN.contains(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .insurance_provided![j])
                                  ? insuranceCompaniesListEN
                                  : insuranceCompaniesListEN.add(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .insurance_provided![j])
                              : insuranceCompaniesListEN
                        }
                    };*/

              ///-------------------------- SECTOR LIST --------------------------///

              /*readHealthFacilitiesDatabaseContent[i].sector_type != null
                  ? sectorTypeList.contains(
                          readHealthFacilitiesDatabaseContent[i].sector_type)
                      ? sectorTypeList
                      : sectorTypeList.add(
                          readHealthFacilitiesDatabaseContent[i].sector_type!)
                  : sectorTypeList;*/

              ///-------------------------- EMERGENCE LIST --------------------------///

              /* readHealthFacilitiesDatabaseContent[i].emergency != null
                  ? isEmergencyProvidedList.contains(
                          readHealthFacilitiesDatabaseContent[i].emergency)
                      ? isEmergencyProvidedList
                      : isEmergencyProvidedList.add(
                          readHealthFacilitiesDatabaseContent[i].emergency!)
                  : isEmergencyProvidedList;*/

              ///-------------------------- WORKING HOURS LIST --------------------------///

              readHealthFacilitiesDatabaseContent[i].opening_hours == null
                  ? workingHoursListEN
                  : {
                      for (int j = 0;
                          j <
                              readHealthFacilitiesDatabaseContent[i]
                                  .opening_hours!
                                  .length;
                          j++)
                        {
                          readHealthFacilitiesDatabaseContent[i]
                                      .opening_hours !=
                                  null
                              ? workingHoursListEN.contains(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .opening_hours![j])
                                  ? workingHoursListEN
                                  : workingHoursListEN.add(
                                      readHealthFacilitiesDatabaseContent[i]
                                          .opening_hours![j])
                              : workingHoursListEN
                        }
                    };
            }

            ///----------------------------------------------------- SELECTED LIST -----------------------------------------------------///

            ///--------------------------- IS HEALTH FACILITY SELECTED ---------------------------///
            isHealthFacilityTypeSelected =
                List<bool>.filled(healthFacilityTypeListEN.length, false);

            for (int j = 0; j < healthFacilityTypeListEN.length; j++) {
              widget.healthFacilityType == null ||
                      widget.healthFacilityType.isEmpty
                  ? isHealthFacilityTypeSelected
                  : {
                      if (widget.healthFacilityType
                          .contains(healthFacilityTypeListEN[j]))
                        {isHealthFacilityTypeSelected[j] = true}
                      else
                        {isHealthFacilityTypeSelected[j] = false}
                    };
            }

            ///--------------------------- IS SPECIALIZATION SELECTED ---------------------------///
            isSpecializationSelected =
                List<bool>.filled(specializationListEN.length, false);

            widget.specialization == null || widget.specialization.isEmpty
                ? isSpecializationSelected
                : {
                    for (int j = 0; j < specializationListEN.length; j++)
                      {
                        if (widget.specialization
                            .contains(specializationListEN[j]))
                          {isSpecializationSelected[j] = true}
                        else
                          {isSpecializationSelected[j] = false}
                      }
                  };

            ///--------------------------- IS INSURANCE SELECTED ---------------------------///

            isInsuranceSelected =
                List<bool>.filled(insuranceCompaniesListEN.length, false);

            widget.insuranceProvided == null || widget.insuranceProvided.isEmpty
                ? isInsuranceSelected
                : {
                    for (int j = 0; j < insuranceCompaniesListEN.length; j++)
                      {
                        if (widget.insuranceProvided
                            .contains(insuranceCompaniesListEN[j]))
                          {isInsuranceSelected[j] = true}
                        else
                          {isInsuranceSelected[j] = false}
                      }
                  };

            ///--------------------------- IS SECTOR TYPE SELECTED ---------------------------///

            isSectorTypeSelected =
                List<bool>.filled(sectorTypeListEN.length, false);

            widget.sectorType == null || widget.sectorType.isEmpty
                ? isSectorTypeSelected
                : {
                    for (int j = 0; j < sectorTypeListEN.length; j++)
                      {
                        if (widget.sectorType.contains(sectorTypeListEN[j]))
                          {isSectorTypeSelected[j] = true}
                        else
                          {isSectorTypeSelected[j] = false}
                      }
                  };

            ///--------------------------- IS EMERGENCY SELECTED ---------------------------///

            isEmergencySelected =
                List<bool>.filled(isEmergencyProvidedListEN.length, false);

            widget.isEmergencyProvided == null ||
                    widget.isEmergencyProvided.isEmpty
                ? isEmergencySelected
                : {
                    for (int j = 0; j < isEmergencyProvidedListEN.length; j++)
                      {
                        if (widget.isEmergencyProvided
                            .contains(isEmergencyProvidedListEN[j]))
                          {isEmergencySelected[j] = true}
                        else
                          {isEmergencySelected[j] = false}
                      }
                  };

            ///--------------------------- IS HEALTH FACILITY SELECTED ---------------------------///
            isWorkingHoursSelected =
                List<bool>.filled(workingHoursListEN.length, false);

            for (int j = 0; j < workingHoursListEN.length; j++) {
              widget.workingHours == null || widget.workingHours.isEmpty
                  ? isWorkingHoursSelected
                  : {
                      if (widget.workingHours.contains(workingHoursListEN[j]))
                        {isWorkingHoursSelected[j] = true}
                      else
                        {isWorkingHoursSelected[j] = false}
                    };
            }

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
    return Scaffold(
      // backgroundColor: kAlabaster2,
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: buildBody(screenSize),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDiscardButton(),
            buildFilterButton(),
          ],
        ),
      ),
    );
  }

  buildDiscardButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GeographicLocationMapScreenMA(
              healthFacilitiesDatabaseContent: [],
              healthFacilityType: [],
              sectorType: [],
              insuranceProvided: [],
              insuranceSectorType: [],
              isEmergencyProvided: [],
              specialization: [],
              workingHours: [],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? Colors.white
              : Colors.white54,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: DynamicTheme.of(context)?.brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Colors.grey.shade800,
              spreadRadius: 10,
              blurRadius: 12,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Discard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  buildFilterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeographicLocationMapScreenMA(
              healthFacilitiesDatabaseContent: mapFilterFunction(
                healthFacilitiesDatabaseContent:
                    readHealthFacilitiesDatabaseContent,
                // widget.healthFacilitiesDatabaseContent,
                healthFacilityType: healthFacilityTypeSelected,
                sectorType: sectorTypeSelected,
                insuranceSectorType: insuranceSectorTypeSelected,
                insuranceProvided: insuranceSelected,
                isEmergencyProvided: emergencySelected,
                specialization: specializationSelected,
                workingHours: workingHoursSelected,
              ),
              healthFacilityType: healthFacilityTypeSelected,
              sectorType: sectorTypeSelected,
              insuranceSectorType: insuranceSectorTypeSelected,
              insuranceProvided: insuranceSelected,
              isEmergencyProvided: emergencySelected,
              specialization: specializationSelected,
              workingHours: workingHoursSelected,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: kBlueChill,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: DynamicTheme.of(context)?.brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Colors.grey.shade800,
              spreadRadius: 10,
              blurRadius: 12,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Filter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  ///------------------------------------ APP BAR ------------------------------------///
  buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 100.0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 28.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeographicLocationMapScreenMA(
                healthFacilitiesDatabaseContent: mapFilterFunction(
                  healthFacilitiesDatabaseContent:
                      widget.healthFacilitiesDatabaseContent,
                  healthFacilityType: healthFacilityTypeSelected,
                  sectorType: sectorTypeSelected,
                  insuranceSectorType: insuranceSectorTypeSelected,
                  insuranceProvided: insuranceSelected,
                  isEmergencyProvided: emergencySelected,
                  specialization: specializationSelected,
                  workingHours: workingHoursSelected,
                ),
                healthFacilityType: healthFacilityTypeSelected,
                sectorType: sectorTypeSelected,
                insuranceSectorType: insuranceSectorTypeSelected,
                insuranceProvided: insuranceSelected,
                isEmergencyProvided: emergencySelected,
                specialization: specializationSelected,
                workingHours: workingHoursSelected,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 40,
          color: kCannonPink,
        ),
      ),
      title: const Text(
        'FILTERS',
        style: TextStyle(
          fontSize: 32,
          color: kCannonPink,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
    );
  }

  ///------------------------------------ BODY ------------------------------------///
  buildBody(Size screenSize) {
    return StatefulBuilder(builder: (context1, setStateD) {
      return SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildHealthFacilityType(setStateD),
              buildSectorType(setStateD),
              buildSpecialization(setStateD),
              buildEmergency(setStateD),
              buildInsurance(setStateD),
              buildWorkingHours(setStateD),
            ],
          ),
        ),
      );
    });
  }

  ///------------------ HEALTH FACILITY TYPE CHECKLIST ------------------///

  List<bool> isHealthFacilityTypeSelected = <bool>[];
  List<String> healthFacilityTypeSelected = <String>[];

  buildHealthFacilityType(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Health Facility Type',
          onPressedClearAll: () {
            setStateD(() {
              healthFacilityTypeSelected = [];

              isHealthFacilityTypeSelected =
                  List<bool>.filled(healthFacilityTypeListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterCheckListWidget(
          onSelected: (int index) {
            setStateD(() {
              isHealthFacilityTypeSelected[index] == false
                  ? isHealthFacilityTypeSelected[index] = true
                  : isHealthFacilityTypeSelected[index] = false;

              // print(isSelected[index]);

              isHealthFacilityTypeSelected[index] == true
                  ? healthFacilityTypeSelected
                          .contains(healthFacilityTypeListEN[index])
                      ? healthFacilityTypeSelected
                      : healthFacilityTypeSelected = [
                          ...healthFacilityTypeSelected,
                          healthFacilityTypeListEN[index]
                        ] //selectedList.add(list[index])
                  : healthFacilityTypeSelected
                          .contains(healthFacilityTypeListEN[index])
                      ? healthFacilityTypeSelected
                          .remove(healthFacilityTypeListEN[index])
                      : healthFacilityTypeSelected;

              // print('selectedList: $healthFacilityTypeSelected');
            });
          },
          list: healthFacilityTypeListEN,
          isSelected: isHealthFacilityTypeSelected,
          selectedList: healthFacilityTypeSelected,
          height: 0.06,
        ),
      ],
    );
  }

  ///------------------ SPECIALIZATION CHECKLIST ------------------///

  List<bool> isSpecializationSelected = <bool>[];
  List<String> specializationSelected = <String>[];

  buildSpecialization(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Specialization',
          onPressedClearAll: () {
            setStateD(() {
              specializationSelected = [];

              isSpecializationSelected =
                  List<bool>.filled(specializationListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterCheckListWidget(
          onSelected: (int index) {
            setStateD(() {
              isSpecializationSelected[index] == false
                  ? isSpecializationSelected[index] = true
                  : isSpecializationSelected[index] = false;

              // print(isSelected[index]);

              isSpecializationSelected[index] == true
                  ? specializationSelected.contains(specializationListEN[index])
                      ? specializationSelected
                      : specializationSelected = [
                          ...specializationSelected,
                          specializationListEN[index]
                        ] //selectedList.add(list[index])
                  : specializationSelected.contains(specializationListEN[index])
                      ? specializationSelected
                          .remove(specializationListEN[index])
                      : specializationSelected;

              // print('selectedList: $specializationSelected');
            });
          },
          list: specializationListEN,
          isSelected: isSpecializationSelected,
          selectedList: specializationSelected,
          height: 0.058,
        ),
      ],
    );
  }

  ///------------------ INSURANCE CHECKLIST ------------------///

  List<bool> isInsuranceSectorTypeSelected = <bool>[];
  List<String> insuranceSectorTypeSelected = <String>[];

  ///------------------ INSURANCE CHECKLIST ------------------///
  ///
  List<bool> isInsuranceSelected = <bool>[];
  List<String> insuranceSelected = <String>[];

  buildInsurance(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Insurance',
          onPressedClearAll: () {
            setStateD(() {
              insuranceSelected = [];

              isInsuranceSelected =
                  List<bool>.filled(insuranceCompaniesListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterCheckListWidget(
          onSelected: (int index) {
            setStateD(() {
              isInsuranceSelected[index] == false
                  ? isInsuranceSelected[index] = true
                  : isInsuranceSelected[index] = false;

              // print(isSelected[index]);

              isInsuranceSelected[index] == true
                  ? insuranceSelected.contains(insuranceCompaniesListEN[index])
                      ? insuranceSelected
                      : insuranceSelected = [
                          ...insuranceSelected,
                          insuranceCompaniesListEN[index]
                        ] //selectedList.add(list[index])
                  : insuranceSelected.contains(insuranceCompaniesListEN[index])
                      ? insuranceSelected
                          .remove(insuranceCompaniesListEN[index])
                      : insuranceSelected;

              // print('selectedList: $insuranceSelected');
            });
          },
          list: insuranceCompaniesListEN,
          isSelected: isInsuranceSelected,
          selectedList: insuranceSelected,
          height: 0.058,
        ),
      ],
    );
  }

  ///------------------ SECTOR TYPE CHECKLIST ------------------///

  // List<String> sectorTypeList = [];
  List<bool> isSectorTypeSelected = <bool>[];
  List<String> sectorTypeSelected = <String>[];

  buildSectorType(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Sector Type',
          onPressedClearAll: () {
            setStateD(() {
              sectorTypeSelected = [];

              isSectorTypeSelected =
                  List<bool>.filled(sectorTypeListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterChipListWidget(
          onSelected: (index, value) {
            setStateD(() {
              // sectorType[index]['isSelected'] = !sectorType[index]['isSelected'];
              isSectorTypeSelected[index] == false
                  ? isSectorTypeSelected[index] = true
                  : isSectorTypeSelected[index] = false;

              // print(isChronicDiseaseSelected);

              isSectorTypeSelected[index] == true
                  ? sectorTypeSelected.contains(sectorTypeListEN[index])
                      ? sectorTypeSelected
                      : sectorTypeSelected = [
                          ...sectorTypeSelected,
                          sectorTypeListEN[index]
                        ] //.add(sectorTypeList[index])
                  : sectorTypeSelected.contains(sectorTypeListEN[index])
                      ? sectorTypeSelected.remove(sectorTypeListEN[index])
                      : sectorTypeSelected;
            });
          },
          list: sectorTypeListEN,
          isSelected: isSectorTypeSelected,
        ),
      ],
    );
  }

  ///------------------ EMERGENCE CHECKLIST ------------------///

  // List<String> isEmergencyProvidedList = [];
  List<bool> isEmergencySelected = <bool>[];
  List<String> emergencySelected = <String>[];

  buildEmergency(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Emergency',
          onPressedClearAll: () {
            setStateD(() {
              emergencySelected = [];

              isEmergencySelected =
                  List<bool>.filled(isEmergencyProvidedListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterChipListWidget(
          onSelected: (index, value) {
            setStateD(() {
              // emergencyList[index]['isSelected'] = !emergencyList[index]['isSelected'];
              isEmergencySelected[index] == false
                  ? isEmergencySelected[index] = true
                  : isEmergencySelected[index] = false;

              // print(isChronicDiseaseSelected);

              isEmergencySelected[index] == true
                  ? emergencySelected.contains(isEmergencyProvidedListEN[index])
                      ? emergencySelected
                      : emergencySelected.add(isEmergencyProvidedListEN[index])
                  : emergencySelected.contains(isEmergencyProvidedListEN[index])
                      ? emergencySelected
                          .remove(isEmergencyProvidedListEN[index])
                      : emergencySelected;
            });
          },
          list: isEmergencyProvidedListEN,
          isSelected: isEmergencySelected,
        ),
      ],
    );
  }

  ///------------------ WORKING HOURS ------------------///
  ///
  List<bool> isWorkingHoursSelected = <bool>[];
  List<String> workingHoursSelected = <String>[];

  buildWorkingHours(StateSetter setStateD) {
    return Column(
      children: [
        FilterTopTitleWidget(
          titleText: 'Working Hours',
          onPressedClearAll: () {
            setStateD(() {
              workingHoursSelected = [];

              isWorkingHoursSelected =
                  List<bool>.filled(workingHoursListEN.length, false);
            });
          },
          text: 'Clear All',
          textColor: kGreyColor,
        ),
        FilterCheckListWidget(
          onSelected: (int index) {
            setStateD(() {
              isWorkingHoursSelected[index] == false
                  ? isWorkingHoursSelected[index] = true
                  : isWorkingHoursSelected[index] = false;

              // print(isSelected[index]);

              isWorkingHoursSelected[index] == true
                  ? workingHoursSelected.contains(workingHoursListEN[index])
                      ? workingHoursSelected
                      : workingHoursSelected = [
                          ...workingHoursSelected,
                          workingHoursListEN[index]
                        ] //selectedList.add(list[index])
                  : workingHoursSelected.contains(workingHoursListEN[index])
                      ? workingHoursSelected.remove(workingHoursListEN[index])
                      : workingHoursSelected;

              // print('selectedList: $insuranceSelected');
            });
          },
          list: workingHoursListEN,
          isSelected: isWorkingHoursSelected,
          selectedList: workingHoursSelected,
          height: 0.058,
        ),
      ],
    );
  }
}
