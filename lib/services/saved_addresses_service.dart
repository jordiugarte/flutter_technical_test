import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_test/models/address_model.dart';

class SavedAddressesService {
  final String _key = "ADDRESS_LIST";

  Future<bool> _saveAddressList(List<AddressModel> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String json = jsonEncode(list.map((e) => e.toJson()).toList());
      prefs.setString(_key, json);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AddressModel>> getAddressList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String json = prefs.getString(_key)!;
      return List<AddressModel>.from(
          jsonDecode(json).map((e) => AddressModel.fromJson(e)).toList());
    } catch (e) {
      return [];
    }
  }

  Future<AddressModel?> getAddress(int id) async {
    List<AddressModel> list = await getAddressList();
    try {
      return list.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addAddress(AddressModel addressModel) async {
    List<AddressModel> list = await getAddressList();
    try {
      addressModel.id = list.length;
      list.add(addressModel);
      return await _saveAddressList(list);
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAddress(int id) async {
    List<AddressModel> list = await getAddressList();
    try {
      list.removeWhere((element) => element.id == id);
      return await _saveAddressList(list);
    } catch (e) {
      return false;
    }
  }

  Future<bool> editAddress(AddressModel addressModel) async {
    List<AddressModel> list = await getAddressList();
    try {
      int index = list.indexWhere((element) => element.id == addressModel.id);
      list[index] = addressModel;
      return await _saveAddressList(list);
    } catch (e) {
      return false;
    }
  }
}
