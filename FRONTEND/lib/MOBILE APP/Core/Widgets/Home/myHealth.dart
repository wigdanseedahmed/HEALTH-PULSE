///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

class MyHealthScreen extends StatefulWidget {
  final String email;

  const MyHealthScreen(this.email, {Key? key}) : super(key: key);

  @override
  _MyHealthScreenState createState() => _MyHealthScreenState();
}

class _MyHealthScreenState extends State<MyHealthScreen> {
  DateTime selectedDate = DateTime.now();
  DatabaseMethods databaseMethods = DatabaseMethods();
  late UserModel userProfileSnapshot = UserModel();

  /// VARIABLES USED TO GET RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  getUserInfo() async {
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    UserProfile.email =
        await CheckSharedPreferences.getUserEmailSharedPreference();
    var userInfo = await networkHandler
        .get("${AppUrl.getUserUsingEmail}${UserProfile.email}");

    //print(userInfo);
    setState(() {
      userProfileSnapshot = userInfo;
      UserProfile.username = userInfo['data']['username'];
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.lastName = userInfo['data']['lastName'];
      UserProfile.nationality = userInfo['data']['nationality'];
      UserProfile.userPhotoName = userInfo['data']["userPhotoName"];
      UserProfile.userPhotoURL = userInfo['data']["userPhotoURL"];
      UserProfile.userPhotoFile = userInfo['data']["userPhotoFile"];
      UserProfile.userAge = userInfo['data']["userAge"];
      UserProfile.userDateOfBirth = userInfo['data']["userDateOfBirth"];
      UserProfile.userGender = userInfo['data']["userGender"];
      UserProfile.userLanguage = userInfo['data']["userLanguage"];
      UserProfile.userBmi = userInfo['data']["userBmi"];
      UserProfile.userHealthScore = userInfo['data']["userHealthScore"];
      UserProfile.userHeight = userInfo['data']["userHeight"];
      UserProfile.userWeight = userInfo['data']["userWeight"];
      UserProfile.userAddress = userInfo['data']["userAddress"];
      UserProfile.userPhoneNumber = userInfo['data']["userPhoneNumber"];
    });
  }

  getProfile(email) async {
    // print(email);
    networkHandler.get("${AppUrl.getUserUsingEmail}$email").then((val) {
      // print(val.toString());
      setState(() {
        userProfileSnapshot = val;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    UserProfile.userHealthScore = 0;

    Future.delayed(const Duration(milliseconds: 250), () {
      // print('here');
      setState(() {
        UserProfile.userHealthScore =
            userProfileSnapshot.userHealthScore!.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: linearGradientColourScheme)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: const StandardAppBar(title: "MY HEALTH"),
        body: SingleChildScrollView(
          child: UserProfile != null
              ? SafeArea(
                  child: UserHealthSummaryProfileCard(
                    name: UserProfile.username,
                    nationality: UserProfile.nationality,
                    userPhotoName: UserProfile.userPhotoName,
                    userPhotoURL: UserProfile.userPhotoURL,
                    userPhotoFile: UserProfile.userPhotoFile,
                    age: UserProfile.userAge,
                    dob: UserProfile.userDateOfBirth,
                    firstName: UserProfile.firstName,
                    lastName: UserProfile.lastName,
                    gender: UserProfile.userGender,
                    language: UserProfile.userLanguage,
                    bmi: UserProfile.userBmi,
                    userHealthScore: UserProfile.userHealthScore,
                    heightFeet: UserProfile.userHeight,
                    heightInch: UserProfile.userHeight,
                    weight: UserProfile.userWeight,
                    email: UserProfile.email,
                    address: UserProfile.userAddress,
                    phone: UserProfile.userPhoneNumber,
                    userInfo: userProfileSnapshot,
                  ),
                )
              : SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
