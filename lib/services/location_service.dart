import 'dart:convert';

import 'package:tech_test/data/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tech_test/models/locations_container_model.dart';

class LocationService {
  Future<LocationsContainerModel?> getLocations(String postalCode) async {
    final response =
        await http.get(Uri.parse('${Constants.urls.baseUrl}$postalCode'));
    if (response.statusCode == 200) {
      try {
        return LocationsContainerModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
