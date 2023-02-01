///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

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

  bool _showPassword = true;
  bool _showConfirmPassword = true;
  bool showSpinner = false;

  late String uid;
  late String email;
  late String password;
  late String confirmedPassword;

  /// Variables used to store password parameters
  final storage = const FlutterSecureStorage();

  /// Variables used to control password parameters
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    SizedBox updatePasswordButton = SizedBox(
      // ignore: deprecated_member_use
      child: InkWell(
        onTap: () async {
          Map<String, String> data = {"password": passwordController.text};
          if (kDebugMode) {
            print(
                "${AppUrl.forgotPasswordUpdateWithEmail}${emailController.text}");
          }
          var response = await networkHandler.patch(
              "${AppUrl.forgotPasswordUpdateWithEmail}${emailController.text}",
              data); //"/users/update/${_usernameController.text}"

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (kDebugMode) {
              print(
                  "${AppUrl.forgotPasswordUpdateWithEmail}${emailController.text}");
            }
            SharedPreferences prefs = await SharedPreferences.getInstance();

            //Save string data
            prefs.setString('email', emailController.text);
            prefs.setString('password', passwordController.text);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreenMA()),
                //TODO: WelcomePage()
                (route) => false);
          }

          // login logic End here
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
                    Flexible(
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
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: SizedBox(
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
                                    "UPDATE",
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
                                            return const LoginScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "SIGN IN",
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
                                      padding: EdgeInsets.only(right: 16),
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
                                      padding: EdgeInsets.only(right: 16),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColour,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: _showConfirmPassword,
                                        validator: (value) =>
                                            PasswordValidator.validate(value!),
                                        onChanged: (value) =>
                                            confirmedPassword = value,
                                        controller: confirmedPasswordController,
                                        decoration: InputDecoration(
                                          hintText: "Confirm Password",
                                          suffixIcon: GestureDetector(
                                            onTap:
                                                _toggleConfirmPasswordVisibility,
                                            child: _showConfirmPassword
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
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  updatePasswordButton,
                                ],
                              ),
                            ],
                          ),
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
    );
  }

  void _togglePasswordVisibility() {
    setState(
      () {
        _showPassword = !_showPassword;
      },
    );
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }
}
