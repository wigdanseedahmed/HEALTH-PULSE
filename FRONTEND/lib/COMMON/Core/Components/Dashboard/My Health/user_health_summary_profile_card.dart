///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class UserHealthSummaryProfileCard extends StatelessWidget {
  final UserModel userInfo;

  final String? name;
  final String? userPhotoName;
  final String? userPhotoURL;
  final String? userPhotoFile;
  final String? nationality;
  final String? age;
  final String? dob;
  final String? gender;
  final String? firstName;
  final String? lastName;
  final String? language;
  final double? userHealthScore;
  final double? bmi;
  final double? heightFeet;
  final double? heightInch;
  final double? weight;
  final String? email;
  final String? address;
  final String? phone;

  const UserHealthSummaryProfileCard(
      {Key? key,
      required this.userInfo,
        this.userPhotoURL,
        this.userPhotoFile,
        this.userPhotoName,
        this.nationality,
      this.age,
      this.dob,
      this.gender,
      this.firstName,
      this.lastName,
      this.language,
      this.userHealthScore,
      this.bmi,
      this.heightFeet,
      this.heightInch,
      this.weight,
      this.email,
      this.address,
      this.phone,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1.0, 0.0),
          end: const Alignment(1.0, 0.0),
          colors: linearGradientColourScheme,
        ),
      ),
      alignment: Alignment.center, // where to position the child
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildUserProfilePicture(),
                buildMyHealth(context),
                buildMyStats(context),
                buildMyCoverages(context),
                buildPreferences(context),
              ],
            ),
          ),
        ],
      ),
    );
  }


  ///------------------ USER PROFILE PICTURE ------------------///
   buildUserProfilePicture() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                        child: CircleAvatar(
                          radius: 70,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userPhotoFile!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/images/user.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }


  ///------------------ MY HEALTH ------------------///
   buildMyHealth(BuildContext context) {
    return Column(
      children: [
        healthSectionTitle(context, "MY HEALTH"),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              padding: const EdgeInsets.all(
                15.0,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xFFe9f0f3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 17.5,
                    ),
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      children: [
                        myHealthScoreNumber(
                            UserProfile.userHealthScore, context),
                        const Text(
                          "MY HEALTH SCORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: kShamrock,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      UserProfile.firstName != null
                          ? "Hey ${healthScoreCardTitleCase(
                          UserProfile.firstName!)} , you're looking healthy today!"
                          : "name not found",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: kShamrock, //Color(0xFF6f6f6f),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///------------------ MY STATS ------------------///
   buildMyStats(BuildContext context) {
    return Column(
      children: [
        healthSectionTitle(context, "My Stats"),
        Container(
          margin: const EdgeInsets.only(
            left: 20.0,
            right: 5.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      color: kBlueChill,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            age ?? "0",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        const Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      color: kDeepSapphire,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            bmi == null ? "$bmi" : "0",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        const Text(
                          "BMI",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      color: kMeteorite,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            heightFeet == null ? "$heightFeet" : "0",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        const Text(
                          "Height",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 15.0,
                      bottom: 15.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      color: kCannonPink,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: weight == null ? "$weight" : "0",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' lbs',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "Weight",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///------------------ MY COVERAGES ------------------///
   buildMyCoverages(BuildContext context) {
    return Column(
      children: [
        healthSectionTitle(context, "My Coverages"),
        Container(
          margin: const EdgeInsets.only(
            left: 20.0,
            right: 5.0,
          ),
          child: Wrap(children: <Widget>[
            myHealthCoverages("Medical", Icons.favorite_border),
            myHealthCoverages("Dental", Icons.tag_faces_rounded),
            myHealthCoverages("Vision", Icons.remove_red_eye),
          ]),
        ),
      ],
    );
  }

  ///------------------ PREFERENCES ------------------///
   buildPreferences(BuildContext context) {
    return Column(
      children: [
        healthSectionTitle(context, "Preferences"),
        myHealthPreferencesTextField(
            hintText: 'Language', initialValue: language ?? ""),
        myHealthPreferencesTextField(
            hintText: 'Email', initialValue: email ?? ""),
        myHealthPreferencesTextField(
            hintText: 'Phone', initialValue: phone ?? ""),
        myHealthPreferencesTextField(
            hintText: 'Address', initialValue: address ?? ""),
      ],
    );
  }
}
