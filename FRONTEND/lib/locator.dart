import 'package:get_it/get_it.dart';
import 'imports.dart';

/// the main service locator
GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(SettingsService());
  // locator.registerSingleton(MqttService());
}
