import 'package:flutter/material.dart';
import 'package:tech_test/models/address_model.dart';

class AddressDetailsScreen extends StatelessWidget {
  late AddressModel _address;

  AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _address = ModalRoute.of(context)!.settings.arguments as AddressModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(_address.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(_address.name),
            Text(_address.street),
            Text('${_address.number}'),
            Text(_address.postalCode),
            Text(_address.state),
            Text(_address.municipality),
            Text(_address.settlement),
            Text(_address.additional),
            _address.mark ? const Text('Default') : Container(),
          ],
        ),
      ),
    );
  }
}
