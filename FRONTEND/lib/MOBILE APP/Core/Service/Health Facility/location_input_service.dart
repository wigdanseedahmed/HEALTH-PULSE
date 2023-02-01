///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:http/http.dart' as http;

class LocationInputService {
  /*LocationInputService({
    required this.locationsRepository,
  });*/

  // final LocationsRepository locationsRepository;

  ///------------------  READ GEOGRAPHIC DATA FROM BACKEND ------------------///

  Future<List<HealthFacilityInformationModel>> getSuggestionsFromFile(
      String searchingWord) async {
    final List<HealthFacilityInformationModel> suggestions = [];

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse(AppUrl.getHealthFacilities);

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
    // print('searchingWord: ${searchingWord}');
    // print('Response body: ${healthFacilityInformationFromJson(response.body)}');

    if (response.statusCode == 200) {
      if (searchingWord.isNotEmpty) {

        suggestions.addAll(healthFacilityInformationFromJson(response.body)
            .where((element) => element.medical_facility_name_en
                .toString()
                .toLowerCase()
                .contains(searchingWord.toLowerCase()))
            .toList());

        suggestions.addAll(healthFacilityInformationFromJson(response.body)
            .where((element) => element.medical_facility_name_ar
                .toString()
                .contains(searchingWord))
            .toList());

        suggestions.addAll(healthFacilityInformationFromJson(response.body)
            .where((element) => element.doctor_name
                .toString()
                .toLowerCase()
                .contains(searchingWord.toLowerCase()))
            .toList());

        // print('suggestions: $suggestions');

        return suggestions;
      }
      return [];
    }
    return [];
  }

/*Future<List<Location>> getSuggestions(String searchingWord) async {
    if (searchingWord.length >= 3) {
      final suggestions = await locationsRepository.getLocations(
        location: searchingWord,
      );
      return suggestions;
    }
    return [];
  }*/
}
