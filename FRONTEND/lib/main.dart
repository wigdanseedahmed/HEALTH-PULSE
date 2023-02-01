import 'package:flutter_localizations/flutter_localizations.dart';

///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

void main() async {
  var ensureInitialized = WidgetsFlutterBinding.ensureInitialized();

  ///--------- KEEP THE SCREEN ON(for dev/test) ---------///
  // await Utils.setScreenAwake(keepOn: true);

  ///--------- SET APP DEBUG MODE ---------///
  Utils.appDebugMode = true;

  ///--------- SET SCREEN ORIENTATION LOCK ---------///
  Utils.setScreenOrientationPortrait();

  ///--------- PREFERENCES SERVICES (USE SHARE_PREFERENCES) ---------///
  // await PrefService.init(prefix: 'pref_');

  ///--------- DEBUG: TO CLEAR PREFERENCES ---------///
  // PrefService.clear();

  var packageInfo = await PackageInfo.fromPlatform();
  var versionString =
      '${Constants.appName} v${packageInfo.version} - ${Constants.appEdition}';

  ///--------- DETECT FIRST TIME APP LAUNCH ---------///
  /*if (PrefService.getString('app_name') == null) {
    // set defaults if any
    PrefService.setDefaultValues({'app_name': packageInfo.appName});

    // set default MQTT parameters
    PrefService.setDefaultValues({
      SettingsHelper.mqtt_broker: Constants.defaultMqttBroker,
    });
    PrefService.setDefaultValues({
      SettingsHelper.mqtt_port: Constants.defaultMqttPort,
    });
  }
  PrefService.setString('app_version_string', versionString);*/

  ///--------- HANDLE CALLS FROM debugPrint ---------///
  ///---- RELEASE MODE: suppress messages with empty callback ----///
  ///---- DEBUG MODE: timestamp and app info to messages ----///
  var logMessageAppInfo = '${packageInfo.appName} ${packageInfo.version}';

 /* if (Utils.buildDebugMode) {
    debugPrint = (String message, {int wrapWidth}) {
      // add timestamp and app info to messages
      String formattedDate = DateFormat('EEE dd-MMM-yyyy kk:mm:ss').format(
        DateTime.now(),
      );
      var newMessage = "[$logMessageAppInfo, $formattedDate]: $message";

      debugPrintSynchronously(newMessage, wrapWidth: wrapWidth);
    };
  } else {
    // suppress the print messages in release mode
    debugPrint = (String message, {int wrapWidth}) {};
  }*/

  ///--------- SETUP SERVICE LOCATOR ---------///
   setupLocator();

  runApp(const HealthPulseApp());
}

class HealthPulseApp extends StatelessWidget {
  const HealthPulseApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        }),
        fontFamily: "Nunito",
        primaryColor: Colors.red,
        // ignore: deprecated_member_use
        accentColor: Colors.redAccent,
        primaryColorDark: const Color(0xff0029cb),
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => HealthPulse(
        theme: theme,
      ),
    );
  }
}

class HealthPulse extends StatefulWidget {
  const HealthPulse({Key? key, required this.theme}) : super(key: key);

  final ThemeData theme;

  static void setLocale(BuildContext context, Locale locale) async {
    print('setLocale()');
    _HealthPulseState? state = context.findAncestorStateOfType<
        _HealthPulseState>(); //ancestorStateOfType(TypeMatcher<_MyAppState>());

    state!.setState(() {
      state.locale = locale;
    });
  }

  @override
  _HealthPulseState createState() => _HealthPulseState();
}

class _HealthPulseState extends State<HealthPulse> {
  /*Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }*/

  late Locale locale;
  bool localeLoaded = false;

  late bool userIsLoggedIn = false;

  @override
  void initState() {

    Future.delayed(Duration.zero).then((_) async {
      // log app startup event
      // await analytics.logAppOpen();
    });

    //getUserInfo();
    getLoggedInState();
    super.initState();

    _fetchLocale().then((locale) {
      setState(() {
        localeLoaded = true;
        this.locale = locale;
      });
    });

    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment =
        false; //<--
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1f1e30),
        systemNavigationBarColor: Color(0xFF1f1e30),
      ),
    );
  }

  ///---------------- LOGIN STATUS ----------------///
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInPreference().then((value) {
      setState(() {
        userIsLoggedIn = value!;
      });
    });
  }

  ///---------------- LANGUAGE STATUS ----------------///
  late Locale appLocale;

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('languageCode') == null) {
      return null;
    }

    print(
        '_fetchLocale():${prefs.getString('languageCode')}:${prefs.getString('countryCode')}');

    return Locale(
        prefs.getString('languageCode')!, prefs.getString('countryCode'));
  }

  @override
  Widget build(BuildContext context) {
    ///---------------- LANGUAGE STATUS ----------------///
    final settingsService = locator.get<SettingsService>();

    /// set language from settings or revert to default
    var lang = SettingsHelper.getSavedLanguage();
    if (lang != null) {
      appLocale = lang.locale;
    } else {
      appLocale = LocaleDelegate.getDeviceLocale();

      /// save default language - blank screen bug
      /*PrefService.setDefaultValues(
        {SettingsHelper.language: appLocale.languageCode},
      );*/
      UserProfile.userLanguage = appLocale.languageCode;
    }

    /// send appLocale to app state (stream/sink)
    settingsService.setAppLocale(appLocale);

    return Builder(builder: (themeContext) {
      return StreamBuilder<Locale>(
          initialData: appLocale,
          stream: locator<SettingsService>().appLocale,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot != null && snapshot.hasData) {
              appLocale = snapshot.data;
            }
            return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              /*supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],*/
              supportedLocales: AppLocalizations.supportedLocales,
              locale: appLocale,
              title: 'Health Pulse',
              theme: widget.theme,
              debugShowCheckedModeBanner: false,
              home: userIsLoggedIn != null
                  ? userIsLoggedIn
                      ? const HomeScreenMA()
                      : Authenticate()
                  : Center(
                      child: Authenticate(),
                    ),
            );
          });
    });
  }
}
