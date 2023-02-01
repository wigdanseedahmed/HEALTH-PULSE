///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

class SettingsScreenMA extends StatefulWidget {
  static const String id = 'settings_screen';

  const SettingsScreenMA({Key? key}) : super(key: key);

  @override
  _SettingsScreenMAState createState() => _SettingsScreenMAState();
}

class _SettingsScreenMAState extends State<SettingsScreenMA> {

  /// Variable used to get RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  ///VARIABLES USED FOR RETRIEVING USER INFORMATION
  getUserInfo() async {
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.email}");

    //print(userInfo);
    setState(() {
      UserProfile.prefix = userInfo['data']['prefix'];
      UserProfile.username = userInfo['data']['username'];
      UserProfile.fullName = userInfo['data']['fullName'];
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.lastName = userInfo['data']['lastName'];
      UserProfile.userPhotoURL = userInfo['data']['userPhotoURL'];
      UserProfile.userPhotoName = userInfo['data']['userPhotoName'];
      UserProfile.userPhotoFile = userInfo['data']['userPhotoFile'];
      UserProfile.nationality = userInfo['data']['nationality'];
      UserProfile.occupation = userInfo['data']['occupation'];
      UserProfile.email = userInfo['data']['email'];
      UserProfile.password = userInfo['data']['password'];
      UserProfile.confirmedPassword = userInfo['data']['confirmedPassword'];
      UserProfile.userHealthScore = userInfo['data']['userHealthScore'] == null
          ? null
          : userInfo['data']['userHealthScore'].toDouble();
      UserProfile.userWeight = userInfo['data']['userWeight'] == null
          ? null
          : userInfo['data']['userWeight'].toDouble();
      UserProfile.userHeight = userInfo['data']['userHeight'] == null
          ? null
          : userInfo['data']['userHeight'].toDouble();
      UserProfile.userAge = userInfo['data']['userAge'];
      UserProfile.userAddress = userInfo['data']['userAddress'];
      UserProfile.userBmi = userInfo['data']['userBmi'] == null
          ? null
          : userInfo['data']['userBmi'].toDouble();
      UserProfile.userLanguage = userInfo['data']['userLanguage'];
      UserProfile.userPhoneNumber = userInfo['data']['userPhoneNumber'];
      UserProfile.optionalPhoneNumber = userInfo['data']['optionalPhoneNumber'];
      UserProfile.userGender = userInfo['data']['userGender'];
      UserProfile.userDateOfBirth = userInfo['data']['userDateOfBirth'];
      UserProfile.phoneNumber = userInfo['data']['phoneNumber'];
      UserProfile.emergencyContacts =
          userInfo['data']['emergencyContacts'] == null
              ? null
              : List<EmergencyContactModel>.from(userInfo['data']
                      ["emergencyContacts"]
                  .map((x) => EmergencyContactModel.fromJson(x)));
      UserProfile.chronicDiseaseList =
          userInfo['data']['chronicDiseaseList'] == null
              ? null
              : List<String>.from(
                  userInfo['data']['chronicDiseaseList'].map((x) => x));
      UserProfile.bookmarkedHealthPersonnelList = userInfo['data']
                  ['bookmarkedHealthPersonnelList'] ==
              null
          ? null
          : List<String>.from(
              userInfo['data']['bookmarkedHealthPersonnelList'].map((x) => x));
      UserProfile.bookmarkedHealthFacilitiesList = userInfo['data']
                  ['bookmarkedHealthFacilitiesList'] ==
              null
          ? null
          : List<String>.from(
              userInfo['data']['bookmarkedHealthFacilitiesList'].map((x) => x));
      UserProfile.vaccineCertificatesList =
          userInfo['data']['vaccineCertificatesList'] == null
              ? null
              : List<VaccineDigitizationModel>.from(userInfo['data']
                      ['vaccineCertificatesList']
                  .map((x) => VaccineDigitizationModel.fromJson(x)));
      UserProfile.dateUpdated = userInfo['data']['dateUpdated'] == null
          ? null
          : DateTime.parse(userInfo['data']['dateUpdated']);
      UserProfile.dateCreate = userInfo['data']['dateCreate'] == null
          ? null
          : DateTime.parse(userInfo['data']['dateCreate']);
      UserProfile.selectedTheme = userInfo['data']['username'];
    });
  }

  UserModel readUserJsonFileContent = UserModel();
  Future<UserModel>? futureUserInformation;

  Future<UserModel> readingUserJsonData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getUsers);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        //'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    // print('Response status: ${response.statusCode}');
    // print('Response Enter body: ${response.body}');

    if (response.statusCode == 200) {
      readUserJsonFileContent = userModelListFromJson(response.body)
          .where((element) => element.email == UserProfile.email)
          .toList()[0];
      //print("User Model Info : ${readUserJsonFileContent.firstName}");

      return readUserJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<UserModel> updateUserJsonData(
      UserModel selectedTaskInformation) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
    Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

    //print(selectedTaskInformation);

    //Login Logic start here
    Map<String, dynamic> data = {
      "prefix": selectedTaskInformation.prefix,
      "username": selectedTaskInformation.username,
      "fullName": selectedTaskInformation.fullName,
      "firstName": selectedTaskInformation.firstName,
      "lastName": selectedTaskInformation.lastName,
      // "userPhotoURL": selectedTaskInformation.userPhotoURL,
      // "userPhotoName": selectedTaskInformation.userPhotoName,
      // "userPhotoFile": selectedTaskInformation.userPhotoFile,
      "nationality": selectedTaskInformation.nationality,
      "occupation": selectedTaskInformation.occupation,
      "email": selectedTaskInformation.email,
      "password": selectedTaskInformation.password,
      "confirmedPassword": selectedTaskInformation.confirmedPassword,
      "userHealthScore": selectedTaskInformation.userHealthScore,
      "userWeight":selectedTaskInformation.userWeight,
      "userHeight": selectedTaskInformation.userHeight,
      "userAge": selectedTaskInformation.userAge,
      "userAddress": selectedTaskInformation.userAddress,
      "userBmi": selectedTaskInformation.userBmi,
      "userLanguage": selectedTaskInformation.userLanguage,
      "userPhoneNumber": selectedTaskInformation.userPhoneNumber,
      "userGender": selectedTaskInformation.userGender,
      "userDateOfBirth": selectedTaskInformation.userDateOfBirth,
      "phoneNumber": selectedTaskInformation.phoneNumber,
      "optionalPhoneNumber": selectedTaskInformation.optionalPhoneNumber,
      "chronicDiseaseList": selectedTaskInformation.chronicDiseaseList!,
      "dateUpdated": selectedTaskInformation.dateUpdated!.toIso8601String(),
      "emergencyContacts": selectedTaskInformation.emergencyContacts,
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
      body: jsonEncode(data),//json.encode(selectedTaskInformation.toJson()),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      readUserJsonFileContent = UserModel.fromJson(jsonDecode(response.body));
      //print(readUserJsonFileContent);

      return readUserJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///VARIABLES USED TO DETERMINE SCREEN SIZE
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    /// VARIABLES USED TO SCROLL THROUGH SCREEN
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    /// User Model information Variables
    getUserInfo();

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
      child: Scaffold(
        body: buildBody(screenSize),
        bottomNavigationBar: buildBottomNavigatorBar(screenSize),
      ),
    );
  }

  ///----------------------------- TOP BAR -----------------------------///
  buildProfilePicture(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 16, right: 6, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserProfile.userPhotoFile == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        height: 125,
                        width: 125,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(202, 202, 202, 1),
                          borderRadius: BorderRadius.all(Radius.circular(125)),
                        ),
                        child: Center(
                          child: Text(
                            "${UserProfile.firstName![0]}${UserProfile.lastName![0]}",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(76, 75, 75, 1),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        height: 125,
                        width: 125,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(202, 202, 202, 1),
                          borderRadius: BorderRadius.all(Radius.circular(125)),
                        ),
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(
                              base64Decode(UserProfile.userPhotoFile!)),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${UserProfile.firstName!} ${UserProfile.lastName!}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 21),
                  ),
                  /*Text(
                          readUserJsonFileContent.!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),*/
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).accentColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Upgrade to PRO',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///----------------------------- MIDDLE BAR -----------------------------///

  buildBody(Size screenSize) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildProfilePicture(screenSize),
            buildProfile(screenSize),
            // buildStats(screenSize),
            buildAppTheme(screenSize),
            buildAppLanguage(screenSize),
            buildForgotPassword(screenSize),
            buildNotifications(screenSize),
            buildHelpCenter(screenSize),
            settingTilesMA(
              context: context,
              title: "Log Out",
              subtitle: "Tap here to log out",
              icon: FontAwesomeIcons.signOutAlt,
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Authenticate(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  ///------------- USER PROFILE -------------///
   buildProfile(Size screenSize) {
    return settingTilesMA(
      context: context,
      title: "Profile",
      subtitle: "Change profile information",
      icon: FontAwesomeIcons.user,
      //EvaIcons.personOutline
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreenMA(),
          ),
        );
      },
    );
  }

  ///------------- USER STATS -------------///
  buildStats(Size screenSize) {
    return settingTilesMA(
      context: context,
      title: "Stats",
      subtitle: "Check Your Stats",
      icon: Icons.dashboard_outlined,
      //EvaIcons.personOutline
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StatsMA(),
          ),
        );
      },
    );
  }

  ///------------- APP THEME -------------///
  buildAppTheme(Size screenSize) {
    return InkWell(
      splashColor: primaryColour,
      onTap: changeBrightness,
      child: Container(
        margin: const EdgeInsets.only(
          top: 10.0,
          left: 15.0,
          right: 15.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
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
        child: ListTile(
          title: const Padding(
            padding: EdgeInsets.only(top: 6.0, left: 8.0),
            child: Text(
              "Application Theme",
              style: TextStyle(
                fontFamily: 'Fira Sans',
                fontWeight: FontWeight.bold,
                // fontFamily: 'Ninto',
              ),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 6.0, left: 8.0),
            child: Text(
              DynamicTheme.of(context)?.brightness == Brightness.light
                  ? "Light Mode"
                  : "Dark Mode",
              style: const TextStyle(
                fontFamily: 'Fira Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing: Icon(
            DynamicTheme.of(context)?.brightness == Brightness.light
                ? FontAwesomeIcons.solidSun
                : FontAwesomeIcons.solidMoon,
            color: primaryColour,
          ),
        ),
      ),
    );
  }

  void changeBrightness() {
    DynamicTheme.of(context)!.setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);

    readUserJsonFileContent.selectedTheme = DynamicTheme.of(context)!.brightness.name;

    readUserJsonFileContent.dateUpdated = DateTime.now();
    futureUserInformation =
        updateUserJsonData(readUserJsonFileContent);
  }

  ///------------- APP LANGUAGE -------------///
  buildAppLanguage(Size screenSize) {
    final settingsService = locator.get<SettingsService>();

    return Container(
            height: screenSize.height * 0.07,
            margin: const EdgeInsets.only(
              top: 10.0,
              left: 15.0,
              right: 15.0,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
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
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: Icon(
                  FontAwesomeIcons.language,
                  color: primaryColour,
                ),
              ),
              trailing: SizedBox(
                height: screenSize.height * 0.4,
                width: screenSize.width * 0.4,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter dropDownState) {
                      return DropdownSearch(
                        popupElevation: 0.0,
                        showClearButton: false,
                        //clearButtonProps: ,
                        dropdownSearchDecoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          helperStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          prefixStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          suffixStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          errorStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          hintStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          counterStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          floatingLabelStyle: const TextStyle(
                            fontFamily: 'Fira Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColour,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColour,
                              width: 0.5,
                            ),
                          ),
                        ),
                        //mode of dropdown
                        mode: Mode.MENU,
                        //to show search box
                        showSearchBox: true,
                        //list of dropdown items
                        items: languageLocalNames,
                        onChanged: (newValue) {
                          dropDownState(() {
                            print(newValue);
                            newValue == ""
                                ? readUserJsonFileContent.userLanguage = null
                                : readUserJsonFileContent.userLanguage = LocaleDelegate.getLanguageByLocalName(newValue!).localeKey;

                            newValue == ""
                                ? UserProfile.userLanguage = null
                                : UserProfile.userLanguage = LocaleDelegate.getLanguageByLocalName(newValue!).localeKey;

                            // check if same language was selected
                            if (newValue == UserProfile.userLanguage) return;

                            /// Get locale by localeKey
                            var newLocale = LocaleDelegate.getLanguageByLocalName(newValue!).locale;


                            /// Trigger the change language event
                             settingsService.setAppLocale(newLocale);


                            readUserJsonFileContent.dateUpdated = DateTime.now();
                            // futureUserInformation = updateUserJsonData(readUserJsonFileContent);
                          });
                        },
                        //show selected item
                        selectedItem: UserProfile.userLanguage == null
                            ? ""
                            : LocaleDelegate.getLanguageByLocaleKey(UserProfile.userLanguage!)!.localName,
                      );
                    }),
              ),
              /*Text(
                "${UserProfile.userLanguage}",
                style: const TextStyle(
                  fontFamily: 'Fira Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),*/
              title: const Text(
                "Application Language",
                style: TextStyle(
                  fontFamily: 'Fira Sans',
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Ninto',
                ),
              ),
            ),
          );
  }

  ///------------- USER FORGET PASSWORD -------------///
  buildForgotPassword(Size screenSize) {
    return settingTilesMA(
      context: context,
      title: "Forgot Password",
      subtitle: "Send recovery mail",
      icon: Icons.restore,
      onTap: () async {},
    );
  }

  ///------------- USER NOTIFICATION -------------///
  buildNotifications(Size screenSize) {
    return settingListTilesMA(
      title: "Notifications",
      context: context,
      subtitle: "On",
      onChanged: (val) {},
      value: true,
    );
  }

  ///------------- USER HELP CENTER -------------///
  buildHelpCenter(Size screenSize) {
    return settingTilesMA(
      context: context,
      title: "Help Center",
      subtitle: "Contact us",
      icon: Icons.question_mark_outlined,
      //Icons.contact_mail
      onTap: () {},
    );
  }

  ///------------- USER LOGOUT -------------///
  Future<InkWell> buildLogOut(Size screenSize) async {
    return settingTilesMA(
      context: context,
      title: "Log Out",
      subtitle: "Tap here to log out",
      icon: FontAwesomeIcons.signOutAlt,
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        prefs.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Authenticate(),
          ),
        );
      },
    );
  }

  ///----------------------------- BOTTOM BAR -----------------------------///
  buildBottomNavigatorBar(Size screenSize) {
    return const CustomBottomNavBarMA(
      selectedMenu: MenuState.SettingsScreen,
    );
  }

}
