///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

class SpecializationResultPage extends StatefulWidget {
  const SpecializationResultPage({Key? key, required this.speciality}) : super(key: key);

  final String speciality;

  @override
  _SpecializationResultPageState createState() => _SpecializationResultPageState();
}

class _SpecializationResultPageState extends State<SpecializationResultPage> {
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
      readPhysicianJsonFileContent = physicianModelFromJson(response.body).where((element) => element.specialty == widget.speciality).toList();
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
      backgroundColor: Colors.white,
      appBar: buildStandardAppBar(),
      body: buildBody(screenSize),
    );
  }

  ///------------------  APP BAR ------------------///
  buildStandardAppBar() => StandardAppBar(title: widget.speciality.toUpperCase());

  ///------------------  BODY ------------------///
  buildBody(Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
              bottom: 10.0,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-1.0, 0.0),
                end: const Alignment(1.0, 0.0),
                colors: linearGradientColourScheme, // whitish to gray
              ),
            ),
            alignment: Alignment.center,
          ),
          readPhysicianJsonFileContent != null ||
              readPhysicianJsonFileContent.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: readPhysicianJsonFileContent.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SpecialtiesCard(
                      physicianInfo: readPhysicianJsonFileContent[index],
                      screenSize: screenSize,
                      isBookmarkedPressed: UserProfile
                                  .bookmarkedHealthPersonnelList ==
                              null
                          ? false
                          : UserProfile.bookmarkedHealthPersonnelList!.contains(
                                  readPhysicianJsonFileContent[index]
                                      .fullName) ||
                              UserProfile.bookmarkedHealthPersonnelList!.contains(
                                  "${readPhysicianJsonFileContent[index].firstName} ${readPhysicianJsonFileContent[index].lastName}"),
                      onBookmarkPressed: () {
                        setState(
                          () {
                            UserProfile.bookmarkedHealthPersonnelList == null
                                ? UserProfile.bookmarkedHealthPersonnelList = []
                                : UserProfile.bookmarkedHealthPersonnelList!;

                            if (readPhysicianJsonFileContent[index].fullName ==
                                null) {
                              UserProfile.bookmarkedHealthPersonnelList!.contains(
                                          "${readPhysicianJsonFileContent[index].firstName} ${readPhysicianJsonFileContent[index].lastName}") ==
                                      false
                                  ? UserProfile.bookmarkedHealthPersonnelList!.add(
                                      "${readPhysicianJsonFileContent[index].firstName} ${readPhysicianJsonFileContent[index].lastName}")
                                  : UserProfile.bookmarkedHealthPersonnelList!
                                      .remove(
                                          "${readPhysicianJsonFileContent[index].firstName} ${readPhysicianJsonFileContent[index].lastName}");
                            } else {
                              UserProfile.bookmarkedHealthPersonnelList!
                                          .contains(
                                              readPhysicianJsonFileContent[
                                                      index]
                                                  .fullName) ==
                                      false
                                  ? UserProfile.bookmarkedHealthPersonnelList!
                                      .add(readPhysicianJsonFileContent[index]
                                          .fullName!)
                                  : UserProfile.bookmarkedHealthPersonnelList!
                                      .remove(
                                          readPhysicianJsonFileContent[index]
                                              .fullName);
                            }
                            updateUserJsonData(
                                UserProfile.bookmarkedHealthPersonnelList!);
                          },
                        );
                      },
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
