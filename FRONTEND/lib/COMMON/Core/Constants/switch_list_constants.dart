import 'package:health_pulse/imports.dart';


languageSwitchList(String val) {
  switch (val) {
    case 'en':
      return const Text(
        'English',
        style: TextStyle(fontSize: 16.0),
      );
    case 'ar':
      return const Text(
        'Arabic',
        style: TextStyle(fontSize: 16.0),
      );
    case 'id':
      return const Text(
        'Indonesia',
        style: TextStyle(fontSize: 16.0),
      );

    case 'es':
      return const Text(
        'Spanish',
        style: TextStyle(fontSize: 16.0),
      );

    case 'it':
      return const Text(
        'Italian',
        style: TextStyle(fontSize: 16.0),
      );

    default:
      return const Text(
        'English',
        style: TextStyle(fontSize: 16.0),
      );
  }
}