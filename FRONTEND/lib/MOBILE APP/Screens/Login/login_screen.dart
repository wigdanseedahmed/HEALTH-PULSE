///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  /// Variable used to get RESTful-API
  NetworkHandler networkHandler = NetworkHandler();

  late String uid;
  late String email;
  late String password;

  bool _showPassword = true;
  bool showSpinner = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Variables used to store login parameters
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    SizedBox logInButton = SizedBox(
      width: 50,
      // ignore: deprecated_member_use
      child: InkWell(
        onTap: () async {
          setState(() {
            showSpinner = true;
          });

          //Login Logic start here
          Map<String, String> data = {
            //"username": usernameController.text,
            "email": emailController.text,
            "password": passwordController.text,
          };

          var response = await networkHandler.post(AppUrl.login, data);
          var userInfo = await networkHandler.get("${AppUrl.getUserUsingEmail}${emailController.text.toLowerCase()}");
          //print(userInfo);

          try {
            if (response.statusCode == 200 || response.statusCode == 201) {
              Map<String, dynamic> output = json.decode(response.body);
              var data = UserModel.fromJson(output);
              //print(output["token"]);

              await storage.write(key: "token", value: output["token"]);
              setState(() {
                showSpinner = false;
              });

              /// Store and save string data Using SharedPreference
              CheckSharedPreferences.saveUserLoggedInSharedPreference(true);
              CheckSharedPreferences.saveNameSharedPreference(
                  userInfo['data']['username']);
              CheckSharedPreferences.saveUserEmailSharedPreference(
                  emailController.text);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreenMA(),
                  ),
                  (route) => false);
            } else {
              //String output = json.decode(response.body);
              setState(() {
                showSpinner = false;
              });
              toast('Incorrect email or password');
            }
          } on SocketException {
            response.printError();
            showSpinner = false;
          } // login logic End here
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

    //headline:TextStyle(color: Colors.white, fontWeight: FontWeight.normal),

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (onNotification) {
            onNotification.disallowGlow();
            return false;
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: SizedBox(
                  height: screenSize.height,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: screenSize.height * 0.4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/pulse.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "SIGN IN",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const RegistrationScreenMA();
                                            // return const RegistrationScreenMA();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "SIGN UP",
                                      style: GoogleFonts.lato(color: primaryColour),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.alternate_email,
                                        color: primaryColour,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) =>
                                            EmailValidator.validate(value!)
                                                ? null
                                                : "Please enter a valid email",
                                        onChanged: (value) => email = value,
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          hintText: "Email Address",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColour,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: _showPassword,
                                        validator: (value) =>
                                            PasswordValidator.validate(value!),
                                        onChanged: (value) => password = value,
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          suffixIcon: GestureDetector(
                                            onTap: _togglePasswordVisibility,
                                            child: _showPassword
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Row(
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
                                  /*  child: FadeInImage(
                                      image: NetworkImage(
                                        'http://flutter-pro.com/images/fb.png',
                                      ),
                                      placeholder:
                                          AssetImage('assets/logo/fb.png'),
                                    ),*/
                                  ),
                                  const Spacer(),
                                  logInButton,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(
      () {
        _showPassword = !_showPassword;
      },
    );
  }
}
