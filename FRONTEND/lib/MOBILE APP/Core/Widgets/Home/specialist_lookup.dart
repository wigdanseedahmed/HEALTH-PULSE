///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

class SpecialistLookupPage extends StatefulWidget {
  const SpecialistLookupPage({Key? key}) : super(key: key);

  @override
  _SpecialistLookupPageState createState() => _SpecialistLookupPageState();
}

class _SpecialistLookupPageState extends State<SpecialistLookupPage> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

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
      UserProfile.bookmarkedHealthPersonnelList =
          userInfo['data']["bookmarkedHealthPersonnelList"];
      UserProfile.bookmarkedHealthFacilitiesList =
          userInfo['data']["bookmarkedHealthFacilitiesList"];
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

  ///------------------  READ PHYSICIAN DATA FROM BACKEND ------------------///
  List<PhysicianModel> readPhysicianJsonFileContent = <PhysicianModel>[];

  // List<PhysicianModel> searchData = <PhysicianModel>[];

  Future<List<PhysicianModel>> readingPhysicianJsonData() async {
    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getPhysicians);

    /// Create Request to get data and response to read data
    final response = await http.get(
      uri,
      headers: {
        //"Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        //"Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Content-Type, Access-Control-Allow-Origin, Accept",
        "Access-Control-Allow-Methods": "POST, DELETE, GET, PUT"
      },
    );
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      readPhysicianJsonFileContent = physicianModelFromJson(response.body);
      //print("Read Physician Json File Content: $readPhysicianJsonFileContent");

      return readPhysicianJsonFileContent;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///------------------ VARIABLES USED TO DETERMINE SCREEN SIZE ------------------///
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  ///------------------  INIT STATE ------------------///
  @override
  void initState() {
    super.initState();

    readingPhysicianJsonData();
    // getSearch();
    getUserInfo();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return buildScaffold(screenSize);
  }

  ///------------------  SCAFFOLD ------------------///
  buildScaffold(Size screenSize) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildStandardAppBar(),
      body: buildBody(screenSize),
    );
  }

  ///------------------  APP BAR ------------------///
  buildStandardAppBar() => const StandardAppBar(title: "SPECIALIST LOOKUP");

  ///------------------  BODY ------------------///
  buildBody(Size screenSize) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 10.0,
        ),
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            StatefulBuilder(
              builder: (context1, setStateD) {
                return Autocomplete<PhysicianModel>(
                  displayStringForOption: (option) => option.address!,
                  optionsBuilder: (textEditingValue) async {
                    final options =
                        await getSearchResult(textEditingValue.text);
                    return options;
                  },
                  fieldViewBuilder: _textField,
                  onSelected: (physician) {},
                  optionsViewBuilder: _optionsViewBuilder,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///------------------------- SEARCH BAR -------------------------///
  Widget _textField(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    void Function() onFieldSubmitted,
  ) {

    return StatefulBuilder(builder: (context1, setStateD) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Listener(
          onPointerUp: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onPointerDown: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onPointerCancel: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.55),
              contentPadding: const EdgeInsets.all(10),
              prefixIcon: const IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    textEditingController.clear();
                  });
                  setStateD(() {
                    textEditingController.clear();
                  });
                },
              ),
              hintText: "Search...",
              hintStyle: Theme.of(context).textTheme.headline5,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      );
    });
  }


  ///------------------  SEARCH ------------------///

  getSearchResult(String textEditingValue) async {
    return readPhysicianJsonFileContent.where((data) =>
    data.firstName
        .toString()
        .toLowerCase()
        .contains(textEditingValue.toLowerCase()
        .toString()) ||
        data.lastName.toString().toLowerCase().contains(
            textEditingValue
                .toLowerCase()
                .toString()) ||
        data.specialty
            .toString()
            .toLowerCase()
            .contains(textEditingValue
            .toLowerCase()
            .toString()));

  }

  ///------------------------- SEARCH RESULTS -------------------------///
  Widget _optionsViewBuilder(
    BuildContext context,
    void Function(PhysicianModel) onSelected,
    Iterable<PhysicianModel> options,
  ) {
    var screenSize = MediaQuery.of(context).size;

    return StatefulBuilder(
      builder: (context1, setStateD) {
        return options != null || options.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SpecialtiesCard(
                      physicianInfo: options.toList()[index],
                      screenSize: screenSize,
                      isBookmarkedPressed: UserProfile
                                  .bookmarkedHealthPersonnelList ==
                              null
                          ? false
                          : UserProfile.bookmarkedHealthPersonnelList!.contains(
                                  "${options.toList()[index].firstName} ${options.toList()[index].lastName}") ||
                              UserProfile.bookmarkedHealthPersonnelList!
                                  .contains(
                                      "${options.toList()[index].fullName}"),
                      onBookmarkPressed: () {
                        setState(() {
                          UserProfile.bookmarkedHealthPersonnelList == null
                              ? UserProfile.bookmarkedHealthPersonnelList = []
                              : UserProfile.bookmarkedHealthPersonnelList!;

                          UserProfile.bookmarkedHealthPersonnelList!.contains(
                                      "${options.toList()[index].firstName} ${options.toList()[index].lastName}") ==
                                  false
                              ? UserProfile.bookmarkedHealthPersonnelList!.add(
                                  "${options.toList()[index].firstName} ${options.toList()[index].lastName}")
                              : UserProfile.bookmarkedHealthPersonnelList!.remove(
                                  "${options.toList()[index].firstName} ${options.toList()[index].lastName}");

                          updateUserJsonData(
                              UserProfile.bookmarkedHealthPersonnelList!);
                        });
                      });
                })
            : Container();
      },
    );
  }

}
