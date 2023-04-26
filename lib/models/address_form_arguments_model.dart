import 'package:tech_test/models/address_model.dart';

class AddressFormArgumentsModel {
  final AddressModel? addressModel;
  final bool editing;

  AddressFormArgumentsModel({
    required this.addressModel,
    required this.editing,
  });
}
