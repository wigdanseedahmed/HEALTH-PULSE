import 'package:flutter/cupertino.dart';

///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class ProfileScreenMA extends StatefulWidget {
  static const String id = 'profile_screen';

  const ProfileScreenMA({Key? key}) : super(key: key);

  @override
  _ProfileScreenMAState createState() => _ProfileScreenMAState();
}

class _ProfileScreenMAState extends State<ProfileScreenMA>
    with SingleTickerProviderStateMixin {
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
    _opacity = _scrollPosition < MediaQuery.of(context).size.height * 0.40
        ? _scrollPosition / (MediaQuery.of(context).size.height * 0.40)
        : 1;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: Scaffold(
        appBar: appBar(),
        body: buildBody(),
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
      actions: [
        IconButton(
          icon: const Icon(
            Icons.edit,
            size: 24,
            color: kCannonPink,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileScreenMA(),
              ),
            );
          },
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  ///------------------------------------- BODY -------------------------------------///
  buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          UserProfile.userPhotoFile == null
              ? ClipOval(
                  child: Material(
                    color: Colors.grey,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Text(
                          "${UserProfile.fullName![0]}}",
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
              : ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: MemoryImage(
                          base64Decode(UserProfile.userPhotoFile!)),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
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
                    "General information about yourself that is relevant to your medical treatments",
                rightWidget: null,
                callback: null,
                textStyle: kProfileSubHeaderDetailTextStyle,
              ),
              buildPersonalInformation(),
            ],
          ),
          const SizedBox(height: 24),
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
              buildEmergencyContacts(0),
              buildEmergencyContacts(1),
            ],
          ),
          const SizedBox(height: 24),
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
              buildMedicalHistory(),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  ///------------------------------------- NAME -------------------------------------///
  buildName() => Column(
        children: [
          Text(
            "${UserProfile.firstName} ${UserProfile.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          /*Text(
            UserProfile.jobTitle!,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),*/
        ],
      );

  ///------------------------------------- PERSONAL INFORMATION -------------------------------------///
  bool _expandedPersonalInformation = false;

  buildPersonalInformation() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserProfile.firstName == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "First name",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.firstName == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.firstName,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.lastName == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Last name",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.lastName == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.lastName,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.username == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Username",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.username == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.username,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.nationality == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Nationality",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.nationality == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.nationality,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.userDateOfBirth == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Date of birth",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.userDateOfBirth == null
              ? Container()
              : ProfileItemCardMA(
                  title: DateFormat("EEE, MMM d, yyyy").format(
                      DateTime.parse(UserProfile.userDateOfBirth!)),
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Date of birth');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.userGender == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Gender",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.userGender == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.userGender,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap gender');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.email == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Personal email",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.email == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.email,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Email');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.phoneNumber == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Phone number",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.phoneNumber == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.phoneNumber,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
          UserProfile.optionalPhoneNumber == null
              ? Container()
              : const ProfileItemCardMA(
                  title: "Optional Phone number",
                  rightWidget: null,
                  callback: null,
                  textStyle: kProfileSubHeaderTextStyle,
                ),
          UserProfile.optionalPhoneNumber == null
              ? Container()
              : ProfileItemCardMA(
                  title: UserProfile.optionalPhoneNumber,
                  rightWidget: null,
                  callback: () {
                    if (kDebugMode) {
                      print('Tap Settings Item 01');
                    }
                  },
                  textStyle: kProfileBodyTextStyle,
                ),
        ],
      );

  ///------------------------------------- PERSONAL INFORMATION -------------------------------------///
  bool _expandedEmergencyContacts = false;

  buildEmergencyContacts(int index) =>
      UserProfile.emergencyContacts == null
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserProfile
                            .emergencyContacts![index].emergencyContactName ==
                        null
                    ? Container()
                    : const ProfileItemCardMA(
                        title: "Full Name",
                        rightWidget: null,
                        callback: null,
                        textStyle: kProfileSubHeaderTextStyle,
                      ),
                UserProfile
                            .emergencyContacts![index].emergencyContactName ==
                        null
                    ? Container()
                    : ProfileItemCardMA(
                        title: UserProfile
                            .emergencyContacts![index].emergencyContactName,
                        rightWidget: null,
                        callback: () {
                          if (kDebugMode) {
                            print('Tap Settings Item 01');
                          }
                        },
                        textStyle: kProfileBodyTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactRelationshipToYou ==
                        null
                    ? Container()
                    : const ProfileItemCardMA(
                        title: "Relation to you",
                        rightWidget: null,
                        callback: null,
                        textStyle: kProfileSubHeaderTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactRelationshipToYou ==
                        null
                    ? Container()
                    : ProfileItemCardMA(
                        title: UserProfile.emergencyContacts![index]
                            .emergencyContactRelationshipToYou,
                        rightWidget: null,
                        callback: () {
                          if (kDebugMode) {
                            print('Tap Settings Item 01');
                          }
                        },
                        textStyle: kProfileBodyTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactCellPhoneNumber ==
                        null
                    ? Container()
                    : const ProfileItemCardMA(
                        title: "Phone number",
                        rightWidget: null,
                        callback: null,
                        textStyle: kProfileSubHeaderTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactCellPhoneNumber ==
                        null
                    ? Container()
                    : ProfileItemCardMA(
                        title: UserProfile.emergencyContacts![index]
                            .emergencyContactCellPhoneNumber,
                        rightWidget: null,
                        callback: () {
                          if (kDebugMode) {
                            print('Tap Settings Item 01');
                          }
                        },
                        textStyle: kProfileBodyTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactHomePhoneNumber ==
                        null
                    ? Container()
                    : const ProfileItemCardMA(
                        title: "Optional Phone number",
                        rightWidget: null,
                        callback: null,
                        textStyle: kProfileSubHeaderTextStyle,
                      ),
                UserProfile.emergencyContacts![index]
                            .emergencyContactHomePhoneNumber ==
                        null
                    ? Container()
                    : ProfileItemCardMA(
                        title: UserProfile.emergencyContacts![index]
                            .emergencyContactHomePhoneNumber,
                        rightWidget: null,
                        callback: () {
                          if (kDebugMode) {
                            print('Tap Settings Item 01');
                          }
                        },
                        textStyle: kProfileBodyTextStyle,
                      ),
              ],
            );

  ///------------------------------------- MEDICAL HISTORY -------------------------------------///
  bool _expandedMedicalHistory = false;

  buildMedicalHistory() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserProfile.chronicDiseaseList == null
              ? Container()
              : Column(
                  children: [
                    ProfileItemCardMA(
                      title: "Chronic Diseases",
                      rightWidget: null,
                      callback: () {
                        if (kDebugMode) {
                          print('Tap Settings Item 01');
                        }
                      },
                      textStyle: GoogleFonts.dmSerifDisplay(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDeepSapphire)),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            UserProfile.chronicDiseaseList!.length,
                        itemBuilder: (context, index) {
                          return ProfileItemCardMA(
                            title: UserProfile
                                .chronicDiseaseList![index],
                            rightWidget: null,
                            callback: () {
                              if (kDebugMode) {
                                print('Tap Settings Item 01');
                              }
                            },
                            textStyle: kProfileBodyTextStyle,
                          );
                        }),
                  ],
                ),
        ],
      );
}

kOpenPageBottom(BuildContext context, Widget page) {
  Navigator.of(context).push(
    CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      builder: (BuildContext context) => page,
    ),
  );
}

kOpenPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}
