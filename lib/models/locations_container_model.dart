import 'dart:convert';

import 'package:tech_test/models/location_model.dart';

LocationsContainerModel locationsContainerFromJson(String str) =>
    LocationsContainerModel.fromJson(json.decode(str));

String locationsContainerToJson(LocationsContainerModel data) =>
    json.encode(data.toJson());

class LocationsContainerModel {
  LocationsContainerModel({
    required this.locations,
  });

  List<LocationModel> locations;

  factory LocationsContainerModel.fromJson(Map<String, dynamic> json) {
    try {
      return LocationsContainerModel(
        locations: List<LocationModel>.from(
            json["sepomex"].map((x) => LocationModel.fromJson(x))),
      );
    } catch (e) {
      return LocationsContainerModel(locations: []);
    }
  }

  Map<String, dynamic> toJson() => {
        "sepomex": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}
