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
            Text(
              _address.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            _address.mark ? const Chip(label: Text('Default')) : Container(),
            _paddingContainer(const Icon(Icons.streetview), _address.street),
            _paddingContainer(const Icon(Icons.numbers), '${_address.number}'),
            _paddingContainer(
                const Icon(Icons.door_back_door), _address.postalCode),
            _paddingContainer(const Icon(Icons.car_crash), _address.state),
            _paddingContainer(
                const Icon(Icons.location_city), _address.municipality),
            _paddingContainer(
                const Icon(Icons.location_city_sharp), _address.settlement),
            _paddingContainer(const Icon(Icons.info), _address.additional),
          ],
        ),
      ),
    );
  }

  Widget _paddingContainer(Icon icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
