///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class UserProfile {
  static int? sn;
  static String? prefix;
  static String? username;
  static String? fullName;
  static String? firstName;
  static String? lastName;
  static String? userPhotoURL;
  static String? userPhotoName;
  static String? userPhotoFile;
  static String? nationality;
  static String? occupation;
  static String? address;
  static String? email;
  static String? password;
  static String? confirmedPassword;
  static double? userHealthScore;
  static double? userWeight;
  static double? userHeight;
  static String? userAge;
  static String? userAddress;
  static double? userBmi;
  static String? userLanguage;
  static String? userPhoneNumber;
  static String? optionalPhoneNumber;
  static String? userGender;
  static String? userDateOfBirth;
  static String? phoneNumber;
  static List<EmergencyContactModel>? emergencyContacts;
  static List<String>? chronicDiseaseList;
  static List<String>? bookmarkedHealthPersonnelList;
  static List<String>? bookmarkedHealthFacilitiesList;
  static List<VaccineDigitizationModel>? vaccineCertificatesList;
  static DateTime? dateUpdated;
  static DateTime? dateCreate;
  static String? selectedTheme;
}

/*

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
*/
