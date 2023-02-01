///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///
import 'package:http/http.dart' as http;

class CustomPopup extends StatefulWidget {
  const CustomPopup(
      {Key? key,
      required this.healthFacilityInfo,
      required this.sc,
      required this.directionOnTap,
      required this.callOnTap,
      required this.startOnTap,
      required this.saveOnTap,
      required this.shareOnTap,
      required this.websiteOnTap})
      : super(key: key);

  final HealthFacilityInformationModel healthFacilityInfo;
  final ScrollController sc;

  final Function() directionOnTap;
  final Function() callOnTap;
  final Function() startOnTap;
  final Function() saveOnTap;
  final Function() shareOnTap;
  final Function() websiteOnTap;

  @override
  State<StatefulWidget> createState() {
    return CustomPopupState();
  }
}

class CustomPopupState extends State<CustomPopup> {
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

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
    getUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return _panel(widget.sc, widget.healthFacilityInfo);

    //_buildDialogContent();
  }

  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  Widget _panel(ScrollController sc,
      HealthFacilityInformationModel selectedHealthFacility) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  selectedHealthFacility.medical_facility_name_en == null
                      ? selectedHealthFacility.medical_facility_name_ar == null
                          ? selectedHealthFacility.doctor_name == null
                              ? ""
                              : selectedHealthFacility.doctor_name!
                          : selectedHealthFacility.medical_facility_name_ar!
                      : selectedHealthFacility.medical_facility_name_en!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            widget.healthFacilityInfo.address == null ? Container() : const SizedBox(height: 26.0),
            widget.healthFacilityInfo.address == null ? Container() : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on,
                    color: Colors.blueAccent.shade700, size: 32),
                const SizedBox(width: 6.0),
                Text(
                  selectedHealthFacility.address!,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            selectedHealthFacility.contact_number == null
                ? Container()
                : const SizedBox(height: 12.0),
            selectedHealthFacility.contact_number == null
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.phone,
                          color: Colors.blueAccent.shade700, size: 32),
                      const SizedBox(width: 6.0),
                      Text(
                        selectedHealthFacility.contact_number!,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 26.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _button("Directions", 120, Icons.directions,
                      widget.directionOnTap),
                  const SizedBox(width: 6),
                  _button(
                      "Start", 90, Icons.navigation_rounded, widget.startOnTap),
                  const SizedBox(width: 6),
                  _button("Call", 90, Icons.phone, widget.callOnTap),
                  const SizedBox(width: 6),
                  _button("Save", 90, Icons.bookmark_border_outlined,
                      widget.saveOnTap),
                  const SizedBox(width: 6),
                  _button("Share", 90, Icons.share, widget.shareOnTap),
                  const SizedBox(width: 6),
                  _button("Website", 110, Icons.public, widget.websiteOnTap),
                ],
              ),
            ),
            const SizedBox(height: 36.0),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Images",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 12.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl:
                              "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                          height: 120.0,
                          width:
                              (MediaQuery.of(context).size.width - 58) / 2 - 2,
                          fit: BoxFit.cover,
                        ),
                        CachedNetworkImage(
                          imageUrl:
                              "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                          width:
                              (MediaQuery.of(context).size.width - 58) / 2 - 2,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            /*Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "About",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                    """,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _button(String label, double width, IconData icon, Function() onTap) {

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6.0),
            width: width,
            height: 40,
            decoration: BoxDecoration(
              color: label == "Directions" ||
                     ( label == "Save" && UserProfile.bookmarkedHealthFacilitiesList!.contains(
                          widget
                                  .healthFacilityInfo.medical_facility_name_en ?? (widget.healthFacilityInfo
                                      .medical_facility_name_ar ?? widget.healthFacilityInfo.doctor_name)))
                  ? Colors.lightBlueAccent
                  : Colors.transparent,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.lightBlueAccent, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: label == "Directions" ||
                          (label == "Save" && UserProfile.bookmarkedHealthFacilitiesList!
                              .contains(widget
                              .healthFacilityInfo.medical_facility_name_en ?? (widget.healthFacilityInfo
                              .medical_facility_name_ar ?? widget.healthFacilityInfo.doctor_name)))
                      ? Colors.white
                      : Colors.lightBlueAccent,
                ),
                const SizedBox(width: 2.0),
                Text(label),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
