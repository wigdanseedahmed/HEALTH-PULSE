///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flushbar/flushbar.dart';

import 'package:http/http.dart' as http;

class RegistrationMedicalHistoryScreenMA extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationMedicalHistoryScreenMA({Key? key}) : super(key: key);

  @override
  State<RegistrationMedicalHistoryScreenMA> createState() =>
      _RegistrationMedicalHistoryScreenMAState();
}

class _RegistrationMedicalHistoryScreenMAState
    extends State<RegistrationMedicalHistoryScreenMA> {
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

  ///-------------------------- OTHER DISEASES PARAMETERS --------------------------///
  late String otherDiseaseName;

  final otherDiseaseNameController = TextEditingController();

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

    ///-------------------------- CHRONIC ILLNESS INIT --------------------------///
    isChronicDiseaseSelected =
        List<bool>.filled(listOfChronicDiseasesEN.length - 1, false);
    // print(isChronicDiseaseSelected);

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
            Map<String, List<String>> data = {
              "chronicDiseaseList": chronicDiseaseSelected,
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
                      builder: (context) => const HomeScreenMA(),
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
        height: isChronicDiseaseSelected.last == false
            ? screenSize.height * 0.58
            : screenSize.height * 0.63,
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
                child: buildChronicIllnessQuestion(context),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: isChronicDiseaseSelected.last == false
                        ? screenSize.height * 0.3
                        : screenSize.height * 0.35,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: buildChronicIllnessCheckList(context),
                  ),
                  isChronicDiseaseSelected.last == false
                      ? Container()
                      : TextFormField(
                        onChanged: (newDiseaseName) {
                          setState(() {
                            otherDiseaseName = newDiseaseName;
                            chronicDiseaseSelected.add(newDiseaseName);
                          });
                        },
                    onFieldSubmitted: (newDiseaseName) {
                      setState(() {
                        otherDiseaseName = newDiseaseName;
                        chronicDiseaseSelected.add(newDiseaseName);
                      });
                    },
                        controller: otherDiseaseNameController,
                        decoration: const InputDecoration(
                          hintText: "Enter the name of your disease",
                        ),
                      ),
                ],
              ),
              const Spacer(),
              buildBottomBar(screenSize, registrationButton, context),
            ],
          ),
        ),
      ),
    );
  }

  ///-------------------------------- CHRONIC ILLNESS QUESTION --------------------------------///

  buildChronicIllnessQuestion(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            Icons.medical_information_outlined, //Icons.circle_outlined,
            color: kBlueChill,
            size: 35,
          ),
        ),
        Expanded(
          child: Text(
            "Are you suffering from any chronic illnesses?",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kBlueChill, // const Color(0xFF8A8A8A),
            ),
          ),
        ),
      ],
    );
  }

  ///-------------------------------- CHRONIC ILLNESS CHECKLIST --------------------------------///

  List<bool> isChronicDiseaseSelected = <bool>[];
  List<String> chronicDiseaseSelected = <String>[];

  buildChronicIllnessCheckList(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOfChronicDiseasesEN.length - 1,
      itemBuilder: (BuildContext context1, int index) {
        return StatefulBuilder(builder: (context1, setStateD) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listOfChronicDiseasesEN[index + 1],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setStateD(() {
                          isChronicDiseaseSelected[index] == false
                              ? isChronicDiseaseSelected[index] = true
                              : isChronicDiseaseSelected[index] = false;

                          // print(isChronicDiseaseSelected);

                          isChronicDiseaseSelected[index] == true
                              ? chronicDiseaseSelected
                                      .contains(listOfChronicDiseasesEN[index + 1])
                                  ? chronicDiseaseSelected
                                  : chronicDiseaseSelected
                                      .add(listOfChronicDiseasesEN[index + 1])
                              : chronicDiseaseSelected
                                      .contains(listOfChronicDiseasesEN[index + 1])
                                  ? chronicDiseaseSelected
                                      .remove(listOfChronicDiseasesEN[index + 1])
                                  : chronicDiseaseSelected;

                          // print(chronicDiseaseSelected);
                        });
                      },
                      icon: isChronicDiseaseSelected[index] == true
                          ? const Padding(
                              padding: EdgeInsets.only(right: 16, bottom: 10),
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(right: 16, bottom: 16),
                              child: Icon(
                                Icons.check_box_outline_blank_sharp,
                                color: Colors.red,
                              ),
                            ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
      },
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
