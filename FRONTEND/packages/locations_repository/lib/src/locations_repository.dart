import 'package:location_api_client/location_api_client.dart';
import 'package:locations_repository/locations_repository.dart';

import 'package:http/http.dart' as http;

/// Flutter package that handles locations related requests
class LocationsRepository {
  /// {@macro locations_repository}
  const LocationsRepository({required LocationApiClient locationApiClient})
      : _locationApiClient = locationApiClient;

  final LocationApiClient _locationApiClient;

  /// get locations that matches given name
  Future<List<HealthFacilityInformation>> getLocationsFromFile({required String location}) async {

    /// String to URI, using the same url used in the nodejs code
    var uri = Uri.parse('http://192.168.1.138:3300/health_facility/');

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
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final locations = healthFacilityInfoFromJson(response.body)
          .where((element) =>
      element.address!
          .toLowerCase()
          .contains(location.toLowerCase()))
          .toList();

      // print(locations);
      return locations;
    }
    return [];
  }

  /// get locations that matches given name
  /*Future<List<Location>> getLocations({required String location}) async {
    final locations = <Location>[];
    final locationsData =
        await _locationApiClient.getLocations(location: location);

    for (final data in locationsData) {
      locations.add(
        Location.fromLocationData(data),
      );
    }
    return locations;
  }*/
}
