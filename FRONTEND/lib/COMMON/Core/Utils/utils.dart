
import 'package:health_pulse/imports.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:logger/logger.dart';

class Utils {
  Utils._();

  /// app-level debug flag for logging and test UIs
  static bool appDebugMode = false;

  /// check if app is built in debug mode
  static bool get buildDebugMode {
    return Foundation.kDebugMode;
  }

  /// use this to react in app for debug / release mode.
  /// tests if both [appDebugMode] and [buildDebugMode] are [true]
  static bool get isDebugModeOn {
    return Foundation.kDebugMode && appDebugMode;
  }

  /// set the device orientation
  static void setScreenOrientationLandscape() {
    // set the device orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  /// set the device orientation portrait
  static void setScreenOrientationPortrait() {
    // set the device orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Brightness is between 0.0 to 1.0
  static Future<void> setScreenAwake(
      {bool keepOn: true, required double brightness}) async {
    // Prevent screen from going into sleep mode
    Screen.keepOn(keepOn);

    if (brightness != null) {
      if (brightness > 0.0 && brightness < 1.0)
        Screen.setBrightness(brightness);
    }
  }

  /// Hide both bottom bar and status bar
  static void hideStatusBars({hideBars: true}) {
    // hide both bottom bar and status bar
    SystemChrome.setEnabledSystemUIOverlays(
        hideBars ? [] : SystemUiOverlay.values);
  }

  /// Adds a widget to list of children of it's not null
  static void addIfNonNull(Widget child, List children) {
    if (child != null) {
      children.add(child);
    }
  }

  /// Pretty Logger
  static final log = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 60,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static String getJsonString(dynamic jsonObject, {String spaces = '  '}) {
    return JsonEncoder.withIndent(spaces).convert(jsonObject);
  }

    Future launchUrl(url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    }
    return Future.value(false);
  }
}

class Screen {
  static const MethodChannel _channel = const MethodChannel('github.com/clovisnicolas/flutter_screen');

  static Future<double> get brightness async => (await _channel.invokeMethod('brightness')) as double;
  static Future setBrightness(double brightness) =>_channel.invokeMethod('setBrightness',{"brightness" : brightness});
  static Future<bool> get isKeptOn async => (await _channel.invokeMethod('isKeptOn')) as bool;
  static Future keepOn(bool on) => _channel.invokeMethod('keepOn', {"on" : on});
}
