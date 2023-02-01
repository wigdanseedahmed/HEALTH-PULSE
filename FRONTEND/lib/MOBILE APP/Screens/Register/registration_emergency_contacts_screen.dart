///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flushbar/flushbar.dart';

import 'package:http/http.dart' as http;

class RegistrationEmergencyContactsScreenMA extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationEmergencyContactsScreenMA({Key? key}) : super(key: key);

  @override
  State<RegistrationEmergencyContactsScreenMA> createState() =>
      _RegistrationEmergencyContactsScreenMAState();
}

class _RegistrationEmergencyContactsScreenMAState
    extends State<RegistrationEmergencyContactsScreenMA> {
  ///------------------------------------------------- VARIABLES -------------------------------------------------///

  ///-------------------------- GLOBAL KEY --------------------------///

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///-------------------------- VARIABLES USED TO DETERMINE SCREEN SIZE --------------------------///
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  ///-------------------------- NETWORK HANDLER --------------------------///
  NetworkHandler networkHandler = NetworkHandler();

  ///-------------------------- STORE REGISTRATION PARAMETERS --------------------------///
  final storage = const FlutterSecureStorage();

  bool showSpinner = false;

  ///------------------------------------------------- RAED AND UPDATE USER INFO -------------------------------------------------///
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
      UserProfile.email = userInfo['data']['email'];
      UserProfile.password = userInfo['data']['password'];
    });
  }

  UserModel readUserJsonFileContent = UserModel();
  Future<UserModel>? futureUserInformation;

  List<EmergencyContactModel> emergencyContactsList = <EmergencyContactModel>[];

  Future<UserModel> updateUserJsonData(
      UserModel selectedTaskInformation) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
        Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

    //print(selectedTaskInformation);

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
      body: json.encode(selectedTaskInformation.toJson()),
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

  ///------------------------------------------------- INIT STATE -------------------------------------------------///
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    getUserInfo();

    emergencyContactsList.isEmpty
        ? emergencyContactsList = [
            EmergencyContactModel(),
            EmergencyContactModel()
          ]
        : emergencyContactsList;

    super.initState();
  }

  ///------------------------------------------------- WIDGET BUILDER -------------------------------------------------///

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    SizedBox registrationButton = SizedBox(
      // ignore: deprecated_member_use
      child: InkWell(
        onTap: () async {
          setState(() {
            showSpinner = true;
          });

          if (formKey.currentState!.validate()) {
            // we will send the data to rest server
            Map<String, List<EmergencyContactModel>> data = {
              "emergencyContacts": emergencyContactsList,
            };
            // print(data);

            /// String to URI, using the same url used in the nodejs code
            var uri = Uri.parse(
                "${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

            //print(selectedTaskInformation);

            var responseRegister = await http.put(
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
            ); //"/user/register", data);

            //Login Logic added here
            if (responseRegister.statusCode == 200 ||
                responseRegister.statusCode == 201) {
              Map<String, String> data = {
                "email": UserProfile.email!,
                "password": UserProfile.password!,
              };
              var response = await networkHandler.post(AppUrl.login, data);

              if (response.statusCode == 200 || response.statusCode == 201) {
                Map<String, dynamic> output = json.decode(response.body);
                print(output["token"]);
                await storage.write(key: "token", value: output["token"]);
                setState(() {
                  showSpinner = false;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationMedicalHistoryScreenMA(),
                    ),
                    (route) => false);
              } else {
                toast("Network Error");
                //Scaffold.of(context).showSnackBar(const SnackBar(content: Text("Network Error")));
              }
            }

            //Login Logic end here

            setState(() {
              showSpinner = false;
            });
          } else {
            setState(() {
              showSpinner = false;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColour,
          ),
          child: const Icon(
            Icons.arrow_forward_ios_sharp,
          ),
        ),
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildAppLogo(screenSize),
                    buildBody(screenSize, registrationButton, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///------------------------------------------------- APP LOGO -------------------------------------------------///

  buildAppLogo(Size screenSize) {
    return Flexible(
      flex: 3,
      fit: FlexFit.loose,
      child: Container(
        height: screenSize.height * 0.4,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pulse.png"),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  ///------------------------------------------------- BODY -------------------------------------------------///

  buildBody(
      Size screenSize, SizedBox registrationButton, BuildContext context) {
    return Flexible(
      flex: 3,
      fit: FlexFit.loose,
      child: SizedBox(
        height: screenSize.height * 0.63,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "CONTINUE SIGN UP",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Column(
                  children: [
                    buildEmergencyContacts(screenSize, 0),
                    buildEmergencyContacts(screenSize, 1),
                  ],
                ),
              ),
              const Spacer(),
              buildBottomBar(screenSize, registrationButton, context),
            ],
          ),
        ),
      ),
    );
  }

  ///------------------------------------- EMERGENCY CONTACTS -------------------------------------///

  bool _expandedEmergencyContacts = false;

  buildEmergencyContacts(Size screenSize, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ProfileItemCardMA(
          title: "EMERGENCY CONTACT ${index + 1}",
          rightWidget: null,
          callback: null,
          textStyle: kProfileMidSubHeaderTextStyle,
        ),
        const ProfileItemCardMA(
          title: "Full name",
          rightWidget: null,
          callback: null,
          textStyle: kProfileSubHeaderTextStyle,
        ),
        EditProfileItemCardMA(
          text: readUserJsonFileContent
                      .emergencyContacts![index].emergencyContactName ==
                  null
              ? ''
              : emergencyContactsList[index].emergencyContactName!,
          onChanged: (fullName) {
            setState(() {
              fullName == ""
                  ? readUserJsonFileContent
                      .emergencyContacts![index].emergencyContactName = null
                  : emergencyContactsList[index].emergencyContactName =
                      fullName;
            });
          },
          textStyle: kProfileBodyTextStyle,
          callback: () {},
          rightWidget: null,
        ),
        const ProfileItemCardMA(
          title: "Relation to You",
          rightWidget: null,
          callback: null,
          textStyle: kProfileSubHeaderTextStyle,
        ),
        EditProfileItemCardMA(
          text: emergencyContactsList[index]
                      .emergencyContactRelationshipToYou ==
                  null
              ? ''
              : emergencyContactsList[index].emergencyContactRelationshipToYou!,
          onChanged: (fullName) {
            setState(() {
              fullName == ""
                  ? emergencyContactsList[index]
                      .emergencyContactRelationshipToYou = null
                  : emergencyContactsList[index]
                      .emergencyContactRelationshipToYou = fullName;
            });
          },
          textStyle: kProfileBodyTextStyle,
          callback: () {},
          rightWidget: null,
        ),
        const ProfileItemCardMA(
          title: "Cell Phone number",
          rightWidget: null,
          callback: null,
          textStyle: kProfileSubHeaderTextStyle,
        ),
        EditProfileItemCardMA(
          text: emergencyContactsList[index].emergencyContactCellPhoneNumber ==
                  null
              ? ''
              : emergencyContactsList[index].emergencyContactCellPhoneNumber!,
          onChanged: (phoneNumber) {
            setState(() {
              phoneNumber == ""
                  ? emergencyContactsList[index]
                      .emergencyContactCellPhoneNumber = null
                  : emergencyContactsList[index]
                      .emergencyContactCellPhoneNumber = phoneNumber;
            });
          },
          textStyle: kProfileBodyTextStyle,
          callback: () {},
          rightWidget: null,
        ),
        const ProfileItemCardMA(
          title: "Home Phone number",
          rightWidget: null,
          callback: null,
          textStyle: kProfileSubHeaderTextStyle,
        ),
        EditProfileItemCardMA(
          text: emergencyContactsList[index].emergencyContactHomePhoneNumber ==
                  null
              ? ''
              : emergencyContactsList[index].emergencyContactHomePhoneNumber!,
          onChanged: (optionalPhoneNumber) {
            setState(() {
              optionalPhoneNumber == ""
                  ? emergencyContactsList[index]
                      .emergencyContactHomePhoneNumber = null
                  : emergencyContactsList[index]
                      .emergencyContactHomePhoneNumber = optionalPhoneNumber;
            });
          },
          textStyle: kProfileBodyTextStyle,
          callback: () {},
          rightWidget: null,
        ),
        const ProfileItemCardMA(
          title: "Work Phone number",
          rightWidget: null,
          callback: null,
          textStyle: kProfileSubHeaderTextStyle,
        ),
        EditProfileItemCardMA(
          text: emergencyContactsList[index].emergencyContactWorkPhoneNumber ==
                  null
              ? ''
              : emergencyContactsList[index].emergencyContactWorkPhoneNumber!,
          onChanged: (optionalPhoneNumber) {
            setState(() {
              optionalPhoneNumber == ""
                  ? emergencyContactsList[index]
                      .emergencyContactWorkPhoneNumber = null
                  : emergencyContactsList[index]
                      .emergencyContactWorkPhoneNumber = optionalPhoneNumber;
            });
          },
          textStyle: kProfileBodyTextStyle,
          callback: () {},
          rightWidget: null,
        ),
      ],
    );
  }

  ///-------------------------------- BOTTOM BAR --------------------------------///

  buildBottomBar(
      Size screenSize, SizedBox registrationButton, BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          // decoration: BoxDecoration(color: Colors.blue),
          width: 60,
          height: 60,
          /*child: FadeInImage(
                                  image: NetworkImage(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  ),
                                  placeholder: AssetImage(
                                      'assets/logo/google_logo.png'),
                                ),*/
        ),
        SizedBox(width: screenSize.width * 0.02),
        const SizedBox(
          // decoration: BoxDecoration(color: Colors.blue),
          width: 50,
          height: 50,
          /*child: FadeInImage(
                                  image: NetworkImage(
                                    'http://flutter-pro.com/images/fb.png',
                                  ),
                                  placeholder:
                                      AssetImage('assets/logo/fb.png'),
                                ),*/
        ),
        const Spacer(),
        registrationButton,
      ],
    );
  }
}
