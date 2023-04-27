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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _paddingContainer(
              Text(
                _address.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            _address.mark ? const Chip(label: Text('Default')) : Container(),
            _paddingContainer(Row(
              children: [
                Icon(Icons.streetview),
                Text(_address.street),
              ],
            )),
            Text('${_address.number}'),
            Text(_address.postalCode),
            Text(_address.state),
            Text(_address.municipality),
            Text(_address.settlement),
            Text(_address.additional),
          ],
        ),
      ),
    );
  }

  Widget _paddingContainer(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: widget,
    );
  }
}
