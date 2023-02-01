///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class HomeScreenMA extends StatefulWidget {
  const HomeScreenMA({Key? key}) : super(key: key);

  @override
  State<HomeScreenMA> createState() => _HomeScreenMAState();
}

class _HomeScreenMAState extends State<HomeScreenMA> {
  bool isLoading = false;

  /// VARIABLES USED TO FILTER SPECIALITIES
  late String? medicalSpecialityInitial = 'Physician';
  late String? medicalTopSpecialistInitial = 'Physician';

  /// VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

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
    });
  }

  Future<UserModel> updateUserJsonData(
      List<String> bookmarkedHealthPersonnelList) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
        Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

    Map<String, List<String>> data = {
      //"username": usernameController.text,
      "bookmarkedHealthPersonnelList": bookmarkedHealthPersonnelList,
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

  ///------------------  READ PHYSICIAN DATA FROM BACKEND ------------------///

  List<PhysicianModel> readPhysicianJsonFileContent = <PhysicianModel>[];

  Future<List<PhysicianModel>> readingPhysicianJsonData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getPhysicians);

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
      readPhysicianJsonFileContent = physicianModelFromJson(response.body);
      //print("Read Physician Json File Content: $readPhysicianJsonFileContent");

      return readPhysicianJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  @override
  void initState() {
    readingPhysicianJsonData();
    getUserInfo();
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

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<List<PhysicianModel>?>(
        future: readingPhysicianJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return buildScaffold(screenSize, context);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  ///------------------ SCAFFOLD ------------------///
  buildScaffold(Size screenSize, BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(screenSize),
      // drawer: const HealthPulseDrawer(),
      body: buildBody(context, screenSize),
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.DashboardScreen,
      ),
    );
  }

  ///------------------ APP BAR ------------------///
  buildAppBar(Size screenSize) {
    return AppBar(
      toolbarHeight: screenSize.height * 0.08,
      iconTheme: IconThemeData(
        color: Colors.transparent,
        size: screenSize.width * 0.08,
      ),
      actions: <Widget>[
        UserProfile.userPhotoFile == null
            ? Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.01),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    color: Color(Random().nextInt(0xffffffff)),
                    child: Center(
                      child: Text(
                        UserProfile.fullName == null
                            ? ''
                            : "${UserProfile.fullName![0]}}",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(76, 75, 75, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.01),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: UserProfile.userPhotoFile != null
                      ? CachedMemoryImage(
                          fit: BoxFit.cover,
                          width: screenSize.width * 0.17,
                          height: screenSize.height * 0.2,
                          bytes: const Base64Decoder()
                              .convert(UserProfile.userPhotoFile!),
                          uniqueKey: UserProfile.userPhotoName!,
                          placeholder: const CircularProgressIndicator(),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  ///------------------ BODY ------------------///
  buildBody(BuildContext context, Size screenSize) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          alignment: Alignment.center,
          child: Column(
            children: [
              //loadUserInfo(),
              Container(
                margin: const EdgeInsets.only(
                  top: 40.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color:
                      DynamicTheme.of(context)?.brightness == Brightness.light
                          ? Colors.white
                          : Colors.black38,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTopScreenMenu(context),
                    buildAppointment(),
                    buildSpecialties(screenSize, context),
                    buildTopSuggestions(screenSize, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///------------------  TOP SCREEN MENU ------------------///
  buildTopScreenMenu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmergencyPage()),
                ),
                color: kDeepSapphire,
                highlightColor: kBlueChill,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.emergency,
                  size: 35,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Text(
                  'Emergency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF6f6f6f),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConsultationPage()),
                ),
                color: kDeepSapphire,
                highlightColor: kBlueChill,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.phone_outlined,
                  size: 35,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Text(
                  'Consultation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF6f6f6f),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpecialistLookupPage()),
                  );
                },
                color: kDeepSapphire,
                highlightColor: kBlueChill,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.groups_outlined,
                  size: 35,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Text(
                  'Specialist Lookup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF6f6f6f),
                  ),
                ),
              ),
            ],
          ),
          /*Column(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHealthScreen(UserProfile.email!),
                    ),
                  );
                },
                color: kDeepSapphire,
                highlightColor: kBlueChill,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.monitor_heart_outlined,
                  size: 35,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: const Text(
                  'My Health',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF6f6f6f),
                  ),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }

  ///------------------  APPOINTMENTS ------------------///
  buildAppointment() {
    return Column(
      children: [
        const AppointmentNotificationCard(),
        Padding(
          padding: const EdgeInsets.only(right: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SectionTitle(title: "Your Next Appointment"),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kBlueChill,
                ),
              ),
            ],
          ),
        ),
        const UserAppointmentCard(),
      ],
    );
  }

  ///------------------  SPECIALITIES ------------------///
  buildSpecialties(Size screenSize, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(title: "$medicalSpecialityInitial Specialties"),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list_sharp,
                  size: screenSize.width * 0.08,
                  color: kCannonPink,
                ),
                onPressed: () {
                  _asyncSpecialityFilterDialog(context);
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              buildHealthPersonnelSpecialities(
                screenSize,
                medicalSpecialityInitial != "Physician"
                    ? medicalSpecialityInitial != "Dentist"
                        ? medicalSpecialityInitial != "Nurse"
                            ? medicalSpecialityInitial != "Pharmacist"
                                ? medicalSpecialityInitial != "Lab Technician"
                                    ? []
                                    : labTechnicianList
                                : pharmacyList
                            : nurseList
                        : dentistList
                    : physicianList,
                medicalSpecialityInitial != "Physician"
                    ? medicalSpecialityInitial != "Dentist"
                        ? medicalSpecialityInitial != "Nurse"
                            ? medicalSpecialityInitial != "Pharmacist"
                                ? medicalSpecialityInitial != "Lab Technician"
                                    ? []
                                    : labTechnicianImageList
                                : pharmacyImageList
                            : nurseImageList
                        : dentistImageList
                    : physicianImageList,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildHealthPersonnelSpecialities(Size screenSize, List<String> specialitiesList, List<String> specialitiesImageList) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: specialitiesList.length,
        itemBuilder: (context, index) {
          return MedicalFieldSpecialties(
            screenSize: screenSize,
            specialtyName: specialitiesList[index],
            specialtyImage: specialitiesImageList[index],
            specialtyDoctorCount: readPhysicianJsonFileContent
                    .where((element) =>
                        element.specialty == specialitiesList[index])
                    .isEmpty
                ? 0
                : readPhysicianJsonFileContent
                    .where((element) =>
                        element.specialty == specialitiesList[index])
                    .length,
          );
        },
      ),
    );
  }

  Future _asyncSpecialityFilterDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Specialities'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: medicalSpecialityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !medicalSpecialityBoolList[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                medicalSpecialityBoolList = List<bool>.filled(
                                    medicalSpecialityInitial!.length, false);
                                medicalSpecialityBoolList[index] = true;
                                medicalSpecialityInitial =
                                    medicalSpecialityList[index];
                                // print(medicalSpecialityInitial);
                              });
                            });
                          },
                        ),
                        title: Text(medicalSpecialityList[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CLEAR);
                medicalSpecialityBoolList =
                    List<bool>.filled(medicalSpecialityInitial!.length, false);
                medicalSpecialityInitial = 'Physician';
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  ///------------------  TOP SUGGESTIONS ------------------///
  buildTopSuggestions(Size screenSize, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(title: "Our Top $medicalTopSpecialistInitial"),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list_sharp,
                  size: screenSize.width * 0.08,
                  color: kMeteorite,
                ),
                onPressed: () {
                  _asyncTopSpecialistFilterDialog(context);
                },
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: Column(
            children: <Widget>[
              buildTopHealthPersonnelList(
                screenSize,
                readPhysicianJsonFileContent
                    .where((element) =>
                        element.medicalFieldSpeciality ==
                        medicalTopSpecialistInitial)
                    .toList(),
              ),
              isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(5),
                      color: Colors.yellowAccent,
                      child: const Text(
                        'Loading',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: kMeteorite,
              padding: const EdgeInsets.all(15),
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'View More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              //paginateDoctors();
            },
          ),
        ),
      ],
    );
  }

  buildTopHealthPersonnelList(Size screenSize, List<PhysicianModel> personnelList) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: personnelList.length,
      itemBuilder: (context, index) {
        return SpecialtiesCard(
          physicianInfo: personnelList[index],
          screenSize: screenSize,
          isBookmarkedPressed: UserProfile.bookmarkedHealthPersonnelList == null
              ? false
              : UserProfile.bookmarkedHealthPersonnelList!.contains(
                  "${personnelList[index].firstName} ${personnelList[index].lastName}"),
          onBookmarkPressed: () {
            setState(() {
              UserProfile.bookmarkedHealthPersonnelList == null
                  ? UserProfile.bookmarkedHealthPersonnelList = []
                  : UserProfile.bookmarkedHealthPersonnelList!;

              UserProfile.bookmarkedHealthPersonnelList!.contains(
                          "${personnelList[index].firstName} ${personnelList[index].lastName}") ==
                      false
                  ? UserProfile.bookmarkedHealthPersonnelList!.add(
                      "${personnelList[index].firstName} ${personnelList[index].lastName}")
                  : UserProfile.bookmarkedHealthPersonnelList!.remove(
                      "${personnelList[index].firstName} ${personnelList[index].lastName}");

              updateUserJsonData(UserProfile.bookmarkedHealthPersonnelList!);
            });
          },
        );
      },
    );
  }

  Future _asyncTopSpecialistFilterDialog(BuildContext context) async {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Specialities'),
              _getCloseButton(context),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: screenSize.width / 2,
              height: screenSize.height / 2,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return ListView.builder(
                    itemCount: medicalTopSpecialistList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: IconButton(
                          icon: !medicalTopSpecialistBoolList[index]
                              ? const Icon(Icons.check_box_outline_blank)
                              : const Icon(Icons.check_box_outlined),
                          onPressed: () {
                            dropDownState(() {
                              setState(() {
                                medicalTopSpecialistBoolList =
                                    List<bool>.filled(
                                        medicalTopSpecialistInitial!.length,
                                        false);
                                medicalTopSpecialistBoolList[index] = true;
                                medicalTopSpecialistInitial =
                                    medicalTopSpecialistList[index];
                                // print(medicalTopSpecialistInitial);
                              });
                            });
                          },
                        ),
                        title: Text(medicalTopSpecialistList[index]),
                      );
                    });
              }),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CLEAR'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop(ConfirmAction.CLEAR);
                  medicalTopSpecialistBoolList = List<bool>.filled(
                      medicalTopSpecialistInitial!.length, false);
                  medicalTopSpecialistInitial = 'Physician';
                });
              },
            ),
            TextButton(
              child: const Text('FILTER'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.FILTER);
              },
            )
          ],
        );
      },
    );
  }

  ///------------------ CLOSED BUTTON  ------------------///
  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: Icon(Icons.clear, color: primaryColour),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

}
