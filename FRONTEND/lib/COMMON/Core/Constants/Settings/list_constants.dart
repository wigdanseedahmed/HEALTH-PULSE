import 'package:health_pulse/imports.dart';

var genderList = [
  'Female',
  "Male",
  "Other",
];

var languageList = [
  'English',
  "Arabic",
];

// list of languages for Display
final languageLocalNames = LocaleDelegate.getLanguagesList()
    .map((language) => language.localName)
    .toList();

final languageKeys = LocaleDelegate.getLanguagesMap().keys.toList(growable: false);