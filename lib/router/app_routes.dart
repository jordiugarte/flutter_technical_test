import 'package:flutter/material.dart';
import 'package:tech_test/data/constants.dart';
import 'package:tech_test/screens/address_details_screen.dart';
import 'package:tech_test/screens/address_form_screen.dart';
import 'package:tech_test/screens/location_list_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({
      Constants.routes.locationList: (BuildContext context) =>
          LocationListScreen(),
      Constants.routes.addressForm: (BuildContext context) =>
          const AddressFormScreen(),
      Constants.routes.addressDetails: (BuildContext context) =>
          AddressDetailsScreen(),
    });
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => LocationListScreen(),
    );
  }
}
