///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

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
      UserProfile.emergencyContacts = userInfo['data']["emergencyContacts"] ==
              null
          ? []
          : userInfo['data']["emergencyContacts"].cast<EmergencyContactModel>();
      // print( UserProfile.bookmarkedHealthPersonnelList);
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
  List<PhysicianModel> bookmarkedHealthPersonnelData = <PhysicianModel>[];

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

  ///------------------ VARIABLES USED TO DETERMINE SCREEN SIZE ------------------///
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  ///------------------  INIT STATE ------------------///
  @override
  void initState() {
    super.initState();

    getUserInfo();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
              return buildScaffold(screenSize);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  ///------------------  SCAFFOLD ------------------///
  buildScaffold(Size screenSize) {
    return Scaffold(
      appBar: buildStandardAppBar(),
      body: buildBody(screenSize),
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.DashboardScreen,
      ),
    );
  }

  ///------------------  APP BAR ------------------///
  buildStandardAppBar() => StandardAppBar(title: "Emergency".toUpperCase());

  ///------------------  BODY ------------------///
  buildBody(Size screenSize) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 0.75,
        margin: const EdgeInsets.only(
          top: 40.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: DynamicTheme.of(context)?.brightness == Brightness.light
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildEmergencyGrid(screenSize),
            buildEmergencyContacts(screenSize, 1),
            const SizedBox(height: 5),
            buildEmergencyContacts(screenSize, 2),
          ],
        ),
      ),
    );
  }

  ///------------------ EMERGENCY GRID ------------------///
  buildEmergencyGrid(Size screenSize) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 50,
      addAutomaticKeepAlives: false,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isEmergencyContactListEN.length,
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit(ResponsiveWidget.isLargeScreen(context) ? 3 : 2),
      itemBuilder: (context, index) {
        return EmergencyCard(
          emergencyType: isEmergencyContactListEN[index],
          screenSize: screenSize,
          onTapped: () => _callNumber(isEmergencyContactListEN[index])
          /*{
              /// Indirect Phone Calls
              // _makingPhoneCall(isEmergencyContactListEN[index]);

              /// Direct Phone Calls
              _callNumber(isEmergencyContactListEN[index]);
            }*/
          ,
        );
      },
    );
  }

  ///------------------ EMERGENCY CONTACTS ------------------///
  buildEmergencyContacts(Size screenSize, int index) {
    return GestureDetector(
      onTap: () async {
        bool? res = await FlutterPhoneDirectCaller.callNumber(UserProfile
            .emergencyContacts![index].emergencyContactCellPhoneNumber!);

        if (res == true) {
          await FlutterPhoneDirectCaller.callNumber(UserProfile
              .emergencyContacts![index].emergencyContactCellPhoneNumber!);
        } else {
          throw 'Could not call $UserProfile.emergencyContacts![index].emergencyContactCellPhoneNumber!';
        }
      },
      child: Container(
        width: screenSize.width * 0.65,
        decoration: BoxDecoration(
          color: const Color(0xFFCE2029),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.people_alt_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  "Emergency Contact $index",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///------------------ MAKE PHONE CALLS ------------------///
  _makingPhoneCall(String emergencyType) async {
    var url = Uri.parse(emergencyType == "Police"
        ? "tel:999"
        : emergencyType == "Fire"
            ? "tel:999"
            : emergencyType == "Ambulance"
                ? "tel:333"
                : "tel:777777");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _callNumber(String emergencyType) async {
    String number = emergencyType == "Police"
        ? "999"
        : emergencyType == "Fire"
            ? "999"
            : emergencyType == "Ambulance"
                ? "333"
                : emergencyType == "Ambulance"
                    ? "333"
                    : "777777";
    //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);

    if (res == true) {
      await FlutterPhoneDirectCaller.callNumber(number);
    } else {
      throw 'Could not call $number';
    }
  }
}
