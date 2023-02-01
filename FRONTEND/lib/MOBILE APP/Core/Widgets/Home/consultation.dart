///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

class ConsultationPage extends StatefulWidget {
  const ConsultationPage({Key? key}) : super(key: key);

  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
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
              if (UserProfile.bookmarkedHealthPersonnelList != null ||
                  UserProfile.bookmarkedHealthPersonnelList!.isNotEmpty) {
                for (int i = 0;
                    i < UserProfile.bookmarkedHealthPersonnelList!.length;
                    i++) {
                  readPhysicianJsonFileContent
                          .where((element) =>
                              "${element.firstName} ${element.lastName}" ==
                                  UserProfile
                                      .bookmarkedHealthPersonnelList![i] ||
                              element.fullName ==
                                  UserProfile.bookmarkedHealthPersonnelList![i])
                          .isEmpty
                      ? bookmarkedHealthPersonnelData
                      : bookmarkedHealthPersonnelData.add(
                          readPhysicianJsonFileContent
                              .where((element) =>
                                  "${element.firstName} ${element.lastName}" ==
                                      UserProfile
                                          .bookmarkedHealthPersonnelList![i] ||
                                  element.fullName ==
                                      UserProfile
                                          .bookmarkedHealthPersonnelList![i])
                              .toList()[0]);
                }
                // print(bookmarkedHealthPersonnelData);
              }
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
  buildStandardAppBar() => StandardAppBar(title: "Consultation".toUpperCase());

  ///------------------  BODY ------------------///
  buildBody(Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
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
          UserProfile.bookmarkedHealthPersonnelList != null ||
                  UserProfile.bookmarkedHealthPersonnelList!.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: UserProfile.bookmarkedHealthPersonnelList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SpecialtiesCard(
                      physicianInfo: bookmarkedHealthPersonnelData[index],
                      screenSize: screenSize,
                      isBookmarkedPressed: UserProfile
                                  .bookmarkedHealthPersonnelList ==
                              null
                          ? false
                          : UserProfile.bookmarkedHealthPersonnelList!.contains(
                                  bookmarkedHealthPersonnelData[index]
                                      .fullName) ||
                              UserProfile.bookmarkedHealthPersonnelList!.contains(
                                  "${bookmarkedHealthPersonnelData[index].firstName} ${bookmarkedHealthPersonnelData[index].lastName}"),
                      onBookmarkPressed: () {
                        setState(
                          () {
                            UserProfile.bookmarkedHealthPersonnelList == null
                                ? UserProfile.bookmarkedHealthPersonnelList = []
                                : UserProfile.bookmarkedHealthPersonnelList!;

                            if (bookmarkedHealthPersonnelData[index].fullName ==
                                null) {
                              UserProfile.bookmarkedHealthPersonnelList!.contains(
                                          "${bookmarkedHealthPersonnelData[index].firstName} ${bookmarkedHealthPersonnelData[index].lastName}") ==
                                      false
                                  ? UserProfile.bookmarkedHealthPersonnelList!.add(
                                      "${bookmarkedHealthPersonnelData[index].firstName} ${bookmarkedHealthPersonnelData[index].lastName}")
                                  : UserProfile.bookmarkedHealthPersonnelList!
                                      .remove(
                                          "${bookmarkedHealthPersonnelData[index].firstName} ${bookmarkedHealthPersonnelData[index].lastName}");
                            } else {
                              UserProfile.bookmarkedHealthPersonnelList!
                                          .contains(
                                              bookmarkedHealthPersonnelData[
                                                      index]
                                                  .fullName) ==
                                      false
                                  ? UserProfile.bookmarkedHealthPersonnelList!
                                      .add(bookmarkedHealthPersonnelData[index]
                                          .fullName!)
                                  : UserProfile.bookmarkedHealthPersonnelList!
                                      .remove(
                                          bookmarkedHealthPersonnelData[index]
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
