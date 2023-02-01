///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

import 'package:flutter/cupertino.dart';

import 'dart:math' show max;
import 'package:qrscan/qrscan.dart' as qrScanner;
import 'package:http/http.dart' as http;

class VaccineCertificateScreenMA extends StatefulWidget {
  const VaccineCertificateScreenMA({super.key});

  @override
  State<VaccineCertificateScreenMA> createState() =>
      _VaccineCertificateScreenMAState();
}

class _VaccineCertificateScreenMAState
    extends State<VaccineCertificateScreenMA> {
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

    setState(() {
      UserProfile.firstName = userInfo['data']['firstName'];
      UserProfile.userPhotoName = userInfo['data']["userPhotoName"];
      UserProfile.userPhotoURL = userInfo['data']["userPhotoURL"];
      UserProfile.userPhotoFile = userInfo['data']["userPhotoFile"];
    });
  }

  Future<UserModel> readUserJsonData() async {
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
      List<VaccineDigitizationModel> vaccineCertificatesList) async {
    /// String to URI, using the same url used in the nodejs code
    var uri =
        Uri.parse("${AppUrl.updateUserInformationByEmail}${UserProfile.email}");

    Map<String, List<VaccineDigitizationModel>> data = {
      //"username": usernameController.text,
      "vaccineCertificatesList": vaccineCertificatesList,
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

  List<VaccineDigitizationModel> vaccineDigitizationList =
      <VaccineDigitizationModel>[];

  @override
  void initState() {
    super.initState();

    ///-------------------------- User Model information Variables --------------------------///
    getUserInfo();
    selectedVaccineCertificateTypes = vaccineCertificateTypesEN[0];
    futureUserInformation = readUserJsonData();

    ///-------------------------- CHRONIC ILLNESS INIT --------------------------///

    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<UserModel>(
        future: futureUserInformation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              vaccineDigitizationList =
                  readUserJsonFileContent.vaccineCertificatesList!;

              ///-------------------------- CHRONIC ILLNESS INIT --------------------------///
              isLoading =
                  List<bool>.filled(vaccineDigitizationList.length, false);

              webViewHeight =
                  List<double>.filled(vaccineDigitizationList.length, 1);

              progressPercentage =
                  List<double>.filled(vaccineDigitizationList.length, 0);

              return buildScaffold(context, screenSize);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
    //Bottom Navigation Bar Ends
  }

  ///-------------------------------- SCAFFOLD --------------------------------///
  buildScaffold(BuildContext context, Size screenSize) {
    return Scaffold(
      body: buildBody(context, screenSize),
      floatingActionButton: buildFloatingActionButton(),
      //Bottom Navigation Bar Starts
      bottomNavigationBar: const CustomBottomNavBarMA(
        selectedMenu: MenuState.VaccineDigitalizationScreen,
      ),
    );
  }

  ///------------------------------- BODY -------------------------------///
  buildBody(BuildContext context, Size screenSize) {
    return SafeArea(
      child: Container(
        width: screenSize.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 428,
                    height: 790,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: -10,
                          left: 0,
                          child: SizedBox(
                            width: 428,
                            height: 936,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 428,
                                    height: 352,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(
                                          217, 217, 217, 0.10000000149011612),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 145,
                                  left: 0,
                                  child: Container(
                                    width: 428,
                                    height: 660,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              0, 0, 0, 0.30000001192092896),
                                          offset: Offset(0, 4),
                                          blurRadius: 25,
                                        ),
                                      ],
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 31,
                          left: 100,
                          child: buildProfilePicture(context, screenSize),
                        ),
                        Positioned(
                          top: 260,
                          left: 0,
                          child: vaccineDigitizationList == null ||
                                  vaccineDigitizationList.isEmpty
                              ? Container()
                              : SizedBox(
                                  width: screenSize.width,
                                  height: 500,
                                  // transform: Matrix4.translationValues( 0.0, -80.0, 0.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: vaccineDigitizationList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: buildGeneratedCertificate(
                                            context,
                                            screenSize,
                                            index,
                                            vaccineDigitizationList[index]),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///------------------ TOP SCREEN MENU ------------------///
  buildProfilePicture(BuildContext context, Size screenSize) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      // transform: Matrix4.translationValues(0.0, -90.0, 0.0),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: UserProfile.userPhotoFile != null
                ? CachedMemoryImage(
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                    bytes: const Base64Decoder()
                        .convert(UserProfile.userPhotoFile!),
                    uniqueKey: UserProfile.userPhotoName!,
                    placeholder: const CircularProgressIndicator(),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  ///------------------ SAVED SCANNED CERTIFICATE ------------------///
  List<bool> isLoading = [];
  List<double> progressPercentage = [];
  List<double> webViewHeight = [];

  buildGeneratedCertificate(BuildContext context, Size screenSize, int index,
      VaccineDigitizationModel newVaccineCertificate) {
    WebViewController? webViewController;

    return StatefulBuilder(builder: (context1, setStateD) {
      return Container(
        color: Colors.transparent,
        width: screenSize.width * 0.8,
        height: max(200, webViewHeight[index] + 150),
        // height: _webViewHeight + 120,
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Card(
          elevation: 8.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? Colors.white
              : Colors.white30,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.width * 0.03),
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: max(75, webViewHeight[index]),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        WebView(
                          // initialUrl: newVaccineCertificate.barCodeResultString,
                          javascriptMode: JavascriptMode.unrestricted,
                          javascriptChannels: {
                            JavascriptChannel(
                              name: 'extents',
                              onMessageReceived: (JavascriptMessage message) {
                                // print('[webView/javascriptChannels] ${message.message}');
                                setStateD(() {
                                  webViewHeight[index] =
                                      double.parse(message.message);
                                });
                              },
                            )
                          },
                          onWebViewCreated: (controller) {
                            webViewController = controller;

                            webViewController!.loadUrl(newVaccineCertificate
                                .barCodeResultString!
                                .trim());
                          },
                          onPageFinished: (String url) async {
                            // print('[webView/onPageFinished] finished loading "$url"');
                            ///------------- Add some delay before evaluate
                            await Future.delayed(
                                const Duration(milliseconds: 1500));

                            String heightStr = await webViewController!
                                .runJavascriptReturningResult(
                                    "document.documentElement.scrollHeight");

                            setStateD(() {
                              webViewHeight[index] = double.parse(heightStr);
                              isLoading[index] = true;
                            });

                            setState(() {
                              webViewHeight[index] = double.parse(heightStr);
                              isLoading[index] = true;
                            });

                            // print(height);
                          },
                          onProgress: (int progress) {
                            setState(() {
                              progressPercentage[index] = progress.toDouble();
                              // print('WebView is loading (progress : $progressPercentage%)');
                            });
                            setStateD(() {
                              progressPercentage[index] = progress.toDouble();
                              // print('WebView is loading (progress : $progressPercentage%)');
                            });
                          },
                        ),
                        if (!isLoading[index])
                          SizedBox(
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Center(
                                child: CircularPercentIndicator(
                                  percent: progressPercentage[index] / 100,
                                  radius: 30,
                                  lineWidth: 5.0,
                                  center: Text(
                                    "${progressPercentage[index]}%",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF535355),
                                    ),
                                  ),
                                  linearGradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: <Color>[
                                      Color(0xFF1AB600),
                                      Color(0xFF6DD400)
                                    ],
                                  ),
                                  rotateLinearGradient: true,
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                              ),
                            ),
                          )
                        /*if (progressPercentage<100)
                            const InfiniteProgressIndicator(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                            )*/
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          newVaccineCertificate.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: kDeepCove,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "${DateFormat('E, dd MMMM yyyy').format(DateTime.parse(newVaccineCertificate.addedOn!))} at ${DateFormat('kk:mm:ss').format(DateTime.parse(newVaccineCertificate.addedOn!))}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: kShamrock,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        newVaccineCertificate.barCodeResultString == null
                            ? Container()
                            : GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(newVaccineCertificate
                                      .barCodeResultString!)) {
                                    await launch(newVaccineCertificate
                                        .barCodeResultString!);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text('Could not launch certificate'),
                                    ));
                                  }
                                },
                                child: Text(
                                  newVaccineCertificate.barCodeResultString!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  ///------------------ POPUP ALERT ------------------///

  late String? selectedVaccineCertificateTypes;

  Uint8List? bytes = Uint8List(0);

  String barcode = "";

  // String barCodeResultString = "Not Yet Scanned";
  // String qrScanResult = "Not Yet Scanned";
  late ScanResult? barCodeResult;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  File? selectedImage;

  Future getImage() async {
    // Parse to code string with uint8list
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    selectedImage = await File(image!.path);
    bytes = selectedImage!.readAsBytesSync();
    barcode = await qrScanner.scanBytes(bytes!);

    setState(() {
      selectedImage = File(image.path); // won't have any error now
    });
  }

  openAlertBox() {
    VaccineDigitizationModel newVaccineCertificate = VaccineDigitizationModel();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 20.0),
          content: StatefulBuilder(builder: (context, setStateD) {
            return SizedBox(
              width: 320.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      "New Vaccine Certificate".toUpperCase(),
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 8.0,
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (nickname) {
                            newVaccineCertificate.name = nickname;
                          },
                          onSubmitted: (nickname) {
                            newVaccineCertificate.name = nickname;
                          },
                          decoration: InputDecoration(
                            hintText: "Vaccine Nickname",
                            hintStyle: TextStyle(
                                fontSize: 16.0, color: Colors.grey.shade600),
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                        DropdownButton<String>(
                          key: newVaccineCertificate.type == null
                              ? Key(vaccineCertificateTypesEN[0])
                              : Key(newVaccineCertificate.type!),
                          //Key(selectedVaccineCertificateTypes!),
                          hint: const Text("Vaccine Type"),
                          value: newVaccineCertificate.type == null
                              ? vaccineCertificateTypesEN[0]
                              : newVaccineCertificate.type!,
                          //selectedVaccineCertificateTypes,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade600),
                          items: vaccineCertificateTypesEN.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? nickname) {
                            setStateD(() {
                              selectedVaccineCertificateTypes = nickname;
                              newVaccineCertificate.type = nickname;
                            });

                            setState(() {
                              selectedVaccineCertificateTypes = nickname;
                              newVaccineCertificate.type = nickname;
                            });
                          },
                        ),
                        newVaccineCertificate.barCodeResultString == null
                            ? Container()
                            : Text(
                                newVaccineCertificate.barCodeResultString!,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  overflow: TextOverflow.fade,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 0.0)),
                          onPressed: () async {
                            ScanResult barCodeScanner =
                                await BarcodeScanner.scan(); //barcode scanner
                            // String? qrScanScanner = await qrScanner.scan();

                            setStateD(() {
                              barCodeResult = barCodeScanner;
                              // barCodeResultString = barCodeScanner.rawContent;

                              newVaccineCertificate.barCodeResultString =
                                  barCodeScanner.rawContent;
                              // qrScanResult = qrScanScanner!;

                              // print(barCodeResult);
                            });

                            setState(() {
                              barCodeResult = barCodeScanner;
                              // barCodeResultString = barCodeScanner.rawContent;

                              newVaccineCertificate.barCodeResultString =
                                  barCodeScanner.rawContent;
                              // qrScanResult = qrScanScanner!;

                              // print(barCodeResult);
                            });

                            // try{
                            //   BarcodeScanner.scan()    this method is used to scan the QR code
                            // }catch (e){
                            //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                            //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                            // }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.qr_code_scanner,
                                color: kBlueChill,
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "Scan",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newVaccineCertificate.addedOn =
                            DateTime.now().toIso8601String();
                        vaccineDigitizationList.add(newVaccineCertificate);
                        // UserProfile.vaccineCertificatesList =  vaccineDigitizationList;
                        updateUserJsonData(vaccineDigitizationList);
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: const BoxDecoration(
                        color: kBlueChill,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  ///------------------ SCAN CODE ------------------///
  late TextEditingController _inputController = TextEditingController();
  late TextEditingController _outputController = TextEditingController();

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await qrScanner.scan();
    if (barcode == null) {
      if (kDebugMode) {
        print('nothing return.');
      }
    } else {
      _outputController.text = barcode;
    }
  }

  Future _scanPhoto() async {
    await Permission.storage.request();
    String barcode = await qrScanner.scanPhoto();
    _outputController.text = barcode;
  }

  Future _scanPath(String path) async {
    await Permission.storage.request();
    String barcode = await qrScanner.scanPath(path);
    _outputController.text = barcode;
  }

  Future _scanBytes() async {
    File? file =
        await ImagePicker().getImage(source: ImageSource.camera).then((picked) {
      if (picked == null) return null;
      return File(picked.path);
    });
    if (file == null) return;
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await qrScanner.scanBytes(bytes);
    _outputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await qrScanner.generateBarCode(inputCode);
    setState(() => bytes = result);
  }

  ///------------------------------- FLOATING ACTION BUTTON -------------------------------///
  buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white70,
      elevation: 0.0,
      heroTag: 0,
      onPressed: () {
        selectedVaccineCertificateTypes = vaccineCertificateTypesEN[0];
        openAlertBox();
      },
      child: const Icon(
        Icons.add,
        color: kBlueChill,
        size: 40,
      ),
    );
  }
}

class VaccineCertificatePage2Widget extends StatelessWidget {
  const VaccineCertificatePage2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator VaccineCertificatePage2Widget - FRAME
    return Container(
      width: 428,
      height: 926,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -10,
            left: 0,
            child: SizedBox(
              width: 428,
              height: 936,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 428,
                      height: 352,
                      decoration: const BoxDecoration(
                        color:
                            Color.fromRGBO(217, 217, 217, 0.10000000149011612),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    child: Container(
                      width: 428,
                      height: 756,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.30000001192092896),
                              offset: Offset(0, 4),
                              blurRadius: 25)
                        ],
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 31,
            left: 75,
            child: Container(
              width: 278,
              height: 278,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Profileicon.png'),
                    fit: BoxFit.fitWidth),
                borderRadius: BorderRadius.all(Radius.elliptical(278, 278)),
              ),
            ),
          ),
          Positioned(
            top: 342,
            left: 24,
            child: SizedBox(
              width: 365,
              height: 424,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 365,
                      height: 424,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(112, 112, 112, 1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 365,
                      height: 234.8307647705078,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        border: Border.all(
                          color: const Color.fromRGBO(112, 112, 112, 1),
                          width: 1,
                        ),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/Toaheftiba740379unsplash.png'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 257.6615295410156,
                    left: 20.604839324951172,
                    child: Text(
                      'Just a simple tabletop scene for you to insert your design, art',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(9, 19, 60, 1),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                  const Positioned(
                    top: 350.6153869628906,
                    left: 78.00403594970703,
                    child: Text(
                      'Sheena Niru',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(9, 19, 60, 1),
                          fontFamily: 'Inter',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                  const Positioned(
                    top: 379.96923828125,
                    left: 78.00403594970703,
                    child: Text(
                      '15 Jun 2018',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(195, 200, 223, 1),
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                  Positioned(
                    top: 353.8769226074219,
                    left: 19.13306427001953,
                    child: Container(
                      width: 44.15322494506836,
                      height: 48.92307662963867,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(112, 112, 112, 1),
                          width: 1,
                        ),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/Averiewoodard319832unsplash.png'),
                            fit: BoxFit.fitWidth),
                        borderRadius: const BorderRadius.all(Radius.elliptical(
                            44.15322494506836, 48.92307662963867)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 366.9230651855469,
                    left: 256.0887145996094,
                    child: SizedBox(
                      width: 20.604839324951172,
                      height: 26.092308044433594,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(
                              width: 20.604839324951172,
                              height: 26.092308044433594,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: SvgPicture.asset(
                                          'assets/images/path146.svg',
                                          semanticsLabel: 'path146')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 366.9230651855469,
                    left: 306.1290283203125,
                    child: SizedBox(
                      width: 24.699735641479492,
                      height: 25.274782180786133,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(
                              width: 24.699735641479492,
                              height: 25.274782180786133,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 3.841705620288849e-9,
                                      child: SvgPicture.asset(
                                          'assets/images/path110.svg',
                                          semanticsLabel: 'path110')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
