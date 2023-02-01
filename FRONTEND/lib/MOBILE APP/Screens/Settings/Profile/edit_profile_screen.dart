///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class EditProfileScreenMA extends StatefulWidget {
  static const String id = 'edit profile_screen';

  const EditProfileScreenMA({Key? key}) : super(key: key);

  @override
  _EditProfileScreenMAState createState() => _EditProfileScreenMAState();
}

class _EditProfileScreenMAState extends State<EditProfileScreenMA> {
  /// Variables used to add more
  bool addNewLanguage = false;

  /// Variable used to get RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  /// User Model information Variables
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
      UserProfile.userHealthScore = userInfo['data']['userHealthScore'] == null ? null : userInfo['data']['userHealthScore'].toDouble();
      UserProfile.userWeight = userInfo['data']['userWeight'] == null ? null : userInfo['data']['userWeight'].toDouble();
      UserProfile.userHeight = userInfo['data']['userHeight'] == null ? null : userInfo['data']['userHeight'].toDouble();
      UserProfile.userAge = userInfo['data']['userAge'];
      UserProfile.userAddress = userInfo['data']['userAddress'];
      UserProfile.userBmi = userInfo['data']['userBmi'] == null ? null : userInfo['data']['userBmi'].toDouble();
      UserProfile.userLanguage = userInfo['data']['userLanguage'];
      UserProfile.userPhoneNumber = userInfo['data']['userPhoneNumber'];
      UserProfile.optionalPhoneNumber = userInfo['data']['optionalPhoneNumber'];
      UserProfile.userGender = userInfo['data']['userGender'];
      UserProfile.userDateOfBirth = userInfo['data']['userDateOfBirth'];
      UserProfile.phoneNumber = userInfo['data']['phoneNumber'];
      UserProfile.emergencyContacts = userInfo['data']['emergencyContacts']== null
          ? null
          : List<EmergencyContactModel>.from(userInfo['data']["emergencyContacts"]
          .map((x) => EmergencyContactModel.fromJson(x)));
      UserProfile.chronicDiseaseList = userInfo['data']['chronicDiseaseList']== null
          ? null
          : List<String>.from(userInfo['data']['chronicDiseaseList'].map((x) => x));
      UserProfile.bookmarkedHealthPersonnelList = userInfo['data']['bookmarkedHealthPersonnelList']== null
          ? null
          : List<String>.from(userInfo['data']['bookmarkedHealthPersonnelList'].map((x) => x));
      UserProfile.bookmarkedHealthFacilitiesList = userInfo['data']['bookmarkedHealthFacilitiesList']== null
          ? null
          : List<String>.from(userInfo['data']['bookmarkedHealthFacilitiesList'].map((x) => x));
      UserProfile.vaccineCertificatesList = userInfo['data']['vaccineCertificatesList']== null
          ? null
          : List<VaccineDigitizationModel>.from(
          userInfo['data']['vaccineCertificatesList']
              .map((x) => VaccineDigitizationModel.fromJson(x)));
      UserProfile.dateUpdated = userInfo['data']['dateUpdated']== null
          ? null
          : DateTime.parse(userInfo['data']['dateUpdated']);
      UserProfile.dateCreate = userInfo['data']['dateCreate']== null
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
    ///-------------------------- VARIABLES USED TO SCROLL THROUGH SCREEN --------------------------//
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    ///-------------------------- User Model information Variables --------------------------///
    getUserInfo();
    futureUserInformation = readingUserJsonData();


    ///-------------------------- CHRONIC ILLNESS INIT --------------------------///
    isChronicDiseaseSelected =
        List<bool>.filled(listOfChronicDiseasesEN.length - 1, false);
    chronicDiseaseSelected = [];
    otherDiseaseName = '';

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
      child: FutureBuilder<UserModel>(
        future: futureUserInformation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              for (int j = 0; j < listOfChronicDiseasesEN.length - 1; j++) {
                if (readUserJsonFileContent.chronicDiseaseList!
                    .contains(listOfChronicDiseasesEN[j + 1])) {
                  isChronicDiseaseSelected[j] = true;
                } else {
                  isChronicDiseaseSelected[j] = false;
                }
              }

              for (int i = 0;
                  i < readUserJsonFileContent.chronicDiseaseList!.length;
                  i++) {
                if (listOfChronicDiseasesEN
                    .contains(readUserJsonFileContent.chronicDiseaseList![i])) {
                  if (!chronicDiseaseSelected.contains(
                      readUserJsonFileContent.chronicDiseaseList![i])) {
                    chronicDiseaseSelected
                        .add(readUserJsonFileContent.chronicDiseaseList![i]);
                  }
                } else {
                  otherDiseaseName =
                      readUserJsonFileContent.chronicDiseaseList![i];
                }
              }


              readUserJsonFileContent.emergencyContacts == null
                  ? emergencyContactsList = [
                EmergencyContactModel()..emergencyNumber = 1,
                EmergencyContactModel()..emergencyNumber = 2
              ]
                  : emergencyContactsList = readUserJsonFileContent.emergencyContacts!;

              return Scaffold(
                appBar: appBar(),
                body: buildBody(screenSize),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            validateInputs();
          },
          child: Icon(
            Icons.clear,
            size: 24,
            color: primaryColour,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              size: 24,
              color: primaryColour,
            ),
            onPressed: () {
              setState(() {
                readUserJsonFileContent.dateUpdated = DateTime.now();
                readUserJsonFileContent.emergencyContacts =
                    emergencyContactsList;
                futureUserInformation =
                    updateUserJsonData(readUserJsonFileContent);
              });
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ]);
  }

  validateInputs() {
    Navigator.pop(context);
    return;
  }

  buildBody(Size screenSize) {
    return Container(
      height: screenSize.height * 0.95,
      //width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          //physics: const BouncingScrollPhysics(),
          children: [
            ProfileAvatarWidget(
              email: UserProfile.email,
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                const ProfileItemCardMA(
                  title: "Personal Information",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileHeaderTextStyle,
                ),
                ProfileItemCardMA(
                  title:
                      "General information about yourself that is relevant to your job",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderDetailTextStyle,
                ),
                buildPersonalInformation(screenSize),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                const ProfileItemCardMA(
                  title: "Emergency Contacts",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileHeaderTextStyle,
                ),
                ProfileItemCardMA(
                  title: "This section contains your emergency contacts.",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderDetailTextStyle,
                ),
                buildEmergencyContacts(screenSize, 0),
                buildEmergencyContacts(screenSize, 1),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                const ProfileItemCardMA(
                  title: "Medical History",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileHeaderTextStyle,
                ),
                ProfileItemCardMA(
                  title:
                      "This section contains your medical history starting with the chronics illnesses you suffer from.",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderDetailTextStyle,
                ),
                buildMedicalHistory(screenSize),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ///------------------------------------- PERSONAL INFORMATION -------------------------------------///

  bool _expandedPersonalInformation = false;

  buildPersonalInformation(Size screenSize) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ProfileItemCardMA(
            title: "First name",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.firstName == null
                ? ''
                : readUserJsonFileContent.firstName!,
            onChanged: (firstName) {
              setState(() {
                firstName == ""
                    ? readUserJsonFileContent.firstName = null
                    : readUserJsonFileContent.firstName = firstName;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          const ProfileItemCardMA(
            title: "Last name",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.lastName == null
                ? ''
                : readUserJsonFileContent.lastName!,
            onChanged: (lastName) {
              setState(() {
                lastName == ""
                    ? readUserJsonFileContent.lastName = null
                    : readUserJsonFileContent.lastName = lastName;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          const ProfileItemCardMA(
            title: "Username",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.username == null
                ? ''
                : readUserJsonFileContent.username!,
            onChanged: (username) {
              setState(() {
                username == ""
                    ? readUserJsonFileContent.username = null
                    : readUserJsonFileContent.username = username;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          const ProfileItemCardMA(
            title: "Nationality",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.nationality == null
                ? ''
                : readUserJsonFileContent.nationality!,
            onChanged: (nationality) {
              setState(() {
                nationality == ""
                    ? readUserJsonFileContent.nationality = null
                    : readUserJsonFileContent.nationality = nationality;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          ProfileItemCardMA(
            title: "Date of birth",
            rightWidget: SizedBox(
              width: MediaQuery.of(context).size.width * 0.275,
              child: CupertinoDateTextBox(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: DynamicTheme.of(context)?.brightness == Brightness.light
                    ? Colors.grey[700]!
                    : Colors.grey[400]!,
                initialValue: readUserJsonFileContent.userDateOfBirth == null
                    ? DateTime.now()
                    : DateFormat("yyyy-MM-dd")
                        .parse(readUserJsonFileContent.userDateOfBirth!),
                onDateChange: (DateTime? newDate) {
                  //print(newDate);
                  setState(() {
                    newDate == DateTime.now()
                        ? readUserJsonFileContent.userDateOfBirth = null
                        : readUserJsonFileContent.userDateOfBirth =
                            newDate!.toIso8601String();
                  });
                },
                hintText: readUserJsonFileContent.userDateOfBirth == null
                    ? DateFormat().format(DateTime.now())
                    : readUserJsonFileContent.userDateOfBirth!,
              ),
            ),
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          ProfileItemCardMA(
            title: "Gender",
            rightWidget: SizedBox(
              width: 180,
              height: 60,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter dropDownState) {
                return DropdownSearch<String>(
                  popupElevation: 0.0,
                  showClearButton: true,
                  //clearButtonProps: ,
                  dropdownSearchDecoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3,
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
                  items: genderList,
                  onChanged: (String? newValue) {
                    dropDownState(() {
                      newValue == ""
                          ? readUserJsonFileContent.userGender = null
                          : readUserJsonFileContent.userGender = newValue;
                    });
                  },
                  //show selected item
                  selectedItem: readUserJsonFileContent.userGender == null
                      ? ""
                      : readUserJsonFileContent.userGender!,
                );
              }),
            ),
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          const ProfileItemCardMA(
            title: "Personal email",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.email == null
                ? ''
                : readUserJsonFileContent.email!,
            onChanged: (personalEmail) {
              setState(() {
                personalEmail == ""
                    ? readUserJsonFileContent.email = null
                    : readUserJsonFileContent.email = personalEmail;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          const ProfileItemCardMA(
            title: "Phone number",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.phoneNumber == null
                ? ''
                : readUserJsonFileContent.phoneNumber!,
            onChanged: (phoneNumber) {
              setState(() {
                phoneNumber == ""
                    ? readUserJsonFileContent.phoneNumber = null
                    : readUserJsonFileContent.phoneNumber = phoneNumber;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
          const ProfileItemCardMA(
            title: "Optional Phone number",
            rightWidget: null,
            callback: null,
            textStyle: kProfileSubHeaderTextStyle,
          ),
          EditProfileItemCardMA(
            text: readUserJsonFileContent.optionalPhoneNumber == null
                ? ''
                : readUserJsonFileContent.optionalPhoneNumber!,
            onChanged: (optionalPhoneNumber) {
              setState(() {
                optionalPhoneNumber == ""
                    ? readUserJsonFileContent.optionalPhoneNumber = null
                    : readUserJsonFileContent.optionalPhoneNumber =
                        optionalPhoneNumber;
              });
            },
            textStyle: kProfileBodyTextStyle,
            callback: () {},
            rightWidget: null,
          ),
        ],
      );

  ///------------------------------------- EMERGENCY CONTACTS -------------------------------------///

  bool _expandedEmergencyContacts = false;

  List<EmergencyContactModel>? emergencyContactsList =
      <EmergencyContactModel>[];

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
          text: emergencyContactsList![index].emergencyContactName == null
              ? ''
              : emergencyContactsList![index].emergencyContactName!,
          onChanged: (fullName) {
            setState(() {
              fullName == ""
                  ? emergencyContactsList![index].emergencyContactName = null
                  : emergencyContactsList![index].emergencyContactName =
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
          text:
              emergencyContactsList![index].emergencyContactRelationshipToYou ==
                      null
                  ? ''
                  : emergencyContactsList![index]
                      .emergencyContactRelationshipToYou!,
          onChanged: (fullName) {
            setState(() {
              fullName == ""
                  ? emergencyContactsList![index]
                      .emergencyContactRelationshipToYou = null
                  : emergencyContactsList![index]
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
          text: emergencyContactsList![index].emergencyContactCellPhoneNumber ==
                  null
              ? ''
              : emergencyContactsList![index].emergencyContactCellPhoneNumber!,
          onChanged: (phoneNumber) {
            setState(() {
              phoneNumber == ""
                  ? emergencyContactsList![index]
                      .emergencyContactCellPhoneNumber = null
                  : emergencyContactsList![index]
                      .emergencyContactCellPhoneNumber = phoneNumber.toString();
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
          text: emergencyContactsList![index].emergencyContactHomePhoneNumber ==
                  null
              ? ''
              : emergencyContactsList![index].emergencyContactHomePhoneNumber!,
          onChanged: (optionalPhoneNumber) {
            setState(() {
              optionalPhoneNumber == ""
                  ? emergencyContactsList![index]
                      .emergencyContactHomePhoneNumber = null
                  : emergencyContactsList![index]
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
          text: emergencyContactsList![index].emergencyContactWorkPhoneNumber ==
                  null
              ? ''
              : emergencyContactsList![index].emergencyContactWorkPhoneNumber!,
          onChanged: (optionalPhoneNumber) {
            setState(() {
              optionalPhoneNumber == ""
                  ? emergencyContactsList![index]
                      .emergencyContactWorkPhoneNumber = null
                  : emergencyContactsList![index]
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

  ///------------------------------------- MEDICAL HISTORY -------------------------------------///
  bool _expandedMedicalHistory = false;

  late String otherDiseaseName = '';

  final otherDiseaseNameController = TextEditingController();

  buildMedicalHistory(Size screenSize) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: isChronicDiseaseSelected.last == false
                ? screenSize.height * 0.4
                : screenSize.height * 0.45,
            padding: const EdgeInsets.only(left: 24, right: 8, bottom: 18),
            color: DynamicTheme.of(context)?.brightness == Brightness.light
                ? Colors.white
                : Colors.black12,
            child: buildChronicIllnessCheckList(context),
          ),
          isChronicDiseaseSelected.last == false
              ? Container()
              : TextFormField(
                  onChanged: (newDiseaseName) {
                    setState(() {
                      otherDiseaseName = newDiseaseName;
                      readUserJsonFileContent.chronicDiseaseList!
                          .add(newDiseaseName);
                    });
                  },
                  onFieldSubmitted: (newDiseaseName) {
                    setState(() {
                      otherDiseaseName = newDiseaseName;
                      readUserJsonFileContent.chronicDiseaseList!
                        ..add(newDiseaseName);
                    });
                  },
                  controller: otherDiseaseNameController,
                  decoration: const InputDecoration(
                    hintText: "Enter the name of your disease",
                  ),
                ),
        ],
      );

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
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
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
                              ? chronicDiseaseSelected.contains(
                                      listOfChronicDiseasesEN[index + 1])
                                  ? chronicDiseaseSelected
                                  : chronicDiseaseSelected
                                      .add(listOfChronicDiseasesEN[index + 1])
                              : chronicDiseaseSelected.contains(
                                      listOfChronicDiseasesEN[index + 1])
                                  ? chronicDiseaseSelected.remove(
                                      listOfChronicDiseasesEN[index + 1])
                                  : chronicDiseaseSelected;

                          print(chronicDiseaseSelected);
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
}
