///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

import '../../../../main.dart';

class LanguageScreenMA extends StatefulWidget {
  const LanguageScreenMA({Key? key}) : super(key: key);

  @override
  State<LanguageScreenMA> createState() => _LanguageScreenMAState();
}

class _LanguageScreenMAState extends State<LanguageScreenMA> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<RadioModel> _langList = <RadioModel>[];

  int _index = 0;

  void changeBrightness() {
    DynamicTheme.of(context)!.setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

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

    /// USER MODEL INFORMATION VARIABLES
    getUserInfo();

    /// USER MODEL APP LANGUAGE VARIABLES
    _initLanguage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < MediaQuery.of(context).size.height * 0.40
        ? _scrollPosition / (MediaQuery.of(context).size.height * 0.40)
        : 1;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: Scaffold(
        appBar: appBar(),
        body: buildBody(screenSize),
      ),
    );
  }

  ///------------------------------------- APP BAR -------------------------------------///
  appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreenMA(),
            ),
          );
        },
        child: const Icon(
          Icons.clear,
          size: 24,
          color: kCannonPink,
        ),
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
            _buildLanguageWidget(screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageWidget(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: _langList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                _langList.forEach((element) => element.isSelected = false);
                _langList[index].isSelected = true;
                _index = index;
                _handleRadioValueChanged();
              });
            },
            child: RadioItem(_langList[index]),
          );
        },
      ),
    );
  }

  List<RadioModel> _getLangList() {
    if (_index == 0) {
      _langList.add(RadioModel(true, 'English'));
      _langList.add(RadioModel(false, 'Arabic'));
    } else if (_index == 1) {
      _langList.add(RadioModel(false, 'English'));
      _langList.add(RadioModel(true, 'Arabic'));
    }

    return _langList;
  }

  Future<String?> _getLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('languageCode') == null) {
      return null;
    }
    print('_fetchLocale():${prefs.getString('languageCode')!}');
    return prefs.getString('languageCode');
  }

  void _initLanguage() async {
    Future<String?> status = _getLanguageCode();
    status.then((result) {
      if (result != null && result.compareTo('en') == 0) {
        setState(() {
          _index = 0;
        });
      }
      if (result != null && result.compareTo('ar') == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 0;
        });
      }
      print("INDEX: $_index");

      _setupLangList();
    });
  }

  void _setupLangList() {
    setState(() {
      _langList.add(RadioModel(_index == 0 ? true : false, 'English'));
      _langList.add(RadioModel(_index == 0 ? false : true, 'Arabic'));
    });
  }

  void _updateLocale(String lang, String country) async {
    print('$lang:$country');

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    HealthPulse.setLocale(context, Locale(lang, country));
  }

  void _handleRadioValueChanged() {
    print("SELCET_VALUE: $_index");
    setState(() {
      switch (_index) {
        case 0:
          print("English");
          _updateLocale('en', '');
          break;
        case 1:
          print("Arabic");
          _updateLocale('ar', '');
          break;
      }
    });
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  const RadioItem(this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: _item.isSelected
                        ? Colors.redAccent
                        : Colors.transparent,
                    border: Border.all(
                        width: 1.0,
                        color: _item.isSelected
                            ? Colors.redAccent
                            : Colors.transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _item.title,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.redAccent : Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
