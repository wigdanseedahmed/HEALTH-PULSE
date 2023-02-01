///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flushbar/flushbar.dart';

class RegistrationScreenMA extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreenMA({Key? key}) : super(key: key);

  @override
  State<RegistrationScreenMA> createState() => _RegistrationScreenMAState();
}

class _RegistrationScreenMAState extends State<RegistrationScreenMA> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  /// Variables used to store registration parameters
  final storage = const FlutterSecureStorage();

  late String email;
  late String password;
  late String confirmedPassword;
  late String username;
  late String fullName;
  late String phoneNumber;
  late String userID;

  late String errorText = "Error Text";
  late String msg = "";

  //bool validate = false;
  bool emailExists = false;
  bool _showPassword = true;
  bool _showConfirmPassword = true;
  bool showSpinner = false;

  //TODO: UserType selectedUserType = UserType.unknown;

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    //TODO: AuthProvider auth = Provider.of<AuthProvider>(context);

    showSnackbarWithFlushbar(BuildContext context, String message) {
      Flushbar(
        // There is also a messageText property for when you want to
        // use a Text widget and not just a simple String
        message: message,

        duration: const Duration(seconds: 3),

        // Show it with a cascading operator
      ).show(context);
    }

    checkUser() async {
      if (usernameController.text.isEmpty) {
        setState(() {
          // circular = false;
          errorText = "Username Can't be empty";
        });
      } else {
        var response = await networkHandler
            .get("${AppUrl.checkUsernameExists}${usernameController.text}");
        if (response['Status'] == true) {
          setState(() {
            // circular = false;
            errorText = "Username already taken";
            toast(errorText);
          });
        } else {
          setState(() {
            // circular = false;
          });
        }
      }
    }

    checkEmail() async {
      if (emailController.text.isEmpty) {
        setState(() {
          // circular = false;
          print("Username Can't be empty");
        });
      } else {
        var response = await networkHandler
            .get("${AppUrl.checkEmailExists}${emailController.text}");
        if (response['Status'] == true) {
          setState(() {
            errorText = "Email already taken";
            toast(errorText);
            showSpinner = false;
          });
        } else {
          setState(() {
            // showSpinner = false;
            emailExists = false;
            print('Success');
          });
        }
      }
    }

    SizedBox registrationButton = SizedBox(
      // ignore: deprecated_member_use
      child: InkWell(
        onTap: () async {
          setState(() {
            showSpinner = true;
          });
          await checkUser();
          await checkEmail();

          if (formKey.currentState!.validate()) {
            // we will send the data to rest server
            Map<String, String> regData = {
              "username": usernameController.text,
              "fullName": fullNameController.text,
              "phoneNumber": phoneNumberController.text,
              "email": emailController.text.toLowerCase(),
              "password": passwordController.text,
              "confirmedPassword": confirmedPasswordController.text,
            };
            // print(data);
            var responseRegister = await networkHandler.post(
                AppUrl.register, regData); //"/user/register", data);

            //Login Logic added here
            if (responseRegister.statusCode == 200 ||
                responseRegister.statusCode == 201) {

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
              var userInfo = await networkHandler
                  .get("${AppUrl.getUserUsingEmail}${emailController.text.toLowerCase()}");

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
                CheckSharedPreferences.saveNameSharedPreference(userInfo['data']['username']);
                CheckSharedPreferences.saveUserEmailSharedPreference(
                    emailController.text);

                setState(() {
                  showSpinner = false;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const RegistrationEmergencyContactsScreenMA();
                    },
                  ),
                );
              } else {
                toast("Network Error");
                //Scaffold.of(context).showSnackBar(const SnackBar(content: Text("Network Error")));
              }
            }

            //Login Logic end here

            setState(() {
              showSpinner = false;
            });
          } else {
            setState(() {
              showSpinner = false;
            });
          }
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
                        height: screenSize.height * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "SIGN UP",
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
                                      style: GoogleFonts.lato(
                                          color: primaryColour),
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.alternate_email,
                                        color: primaryColour,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) =>
                                            UsernameValidator.validate(value!),
                                        onChanged: (value) => username = value,
                                        controller: usernameController,
                                        decoration: const InputDecoration(
                                          hintText: "Username",
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.person,
                                        color: primaryColour,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) =>
                                            NameValidator.validate(value!),
                                        onChanged: (value) => fullName = value,
                                        controller: fullNameController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Full Name As Written In Passport",
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.phone,
                                        color: primaryColour,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) =>
                                            PhoneNumberValidator.validate(
                                                value!),
                                        onChanged: (value) =>
                                            phoneNumber = value,
                                        controller: phoneNumberController,
                                        decoration: const InputDecoration(
                                          hintText: "Phone Number",
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.alternate_email,
                                        color: primaryColour,
                                        size: 30,
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColour,
                                        size: 30,
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
                                      padding: const EdgeInsets.only(
                                          right: 14.0, top: 12.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: primaryColour,
                                        size: 30,
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
                                children: <Widget>[
                                  const SizedBox(
                                    // decoration: BoxDecoration(color: Colors.blue),
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  const SizedBox(
                                    // decoration: BoxDecoration(color: Colors.blue),
                                    width: 50,
                                    height: 50,
                                  ),
                                  const Spacer(),
                                  registrationButton,
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
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }
}
