import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/location/location_cubit.dart';
import 'package:tech_test/bloc/saved_addresses/saved_addresses_cubit.dart';
import 'package:tech_test/models/address_form_arguments_model.dart';
import 'package:tech_test/models/address_model.dart';
import 'package:tech_test/models/location_model.dart';
import 'package:tech_test/utils/validators_helper.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _municipalityController = TextEditingController();
  String? _settlementValue;
  final _additionalController = TextEditingController();
  bool _defaultValue = false;

  late AddressModel? _addressModel;
  late bool _editing;

  bool _valuesWereSet = false;

  final SavedAddressesCubit _addressCubit = SavedAddressesCubit();
  final LocationCubit _locationCubit = LocationCubit();

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _postalCodeController.dispose();
    _stateController.dispose();
    _municipalityController.dispose();
    _settlementValue = null;
    _additionalController.dispose();
    _defaultValue = false;
    super.dispose();
  }

  void setValues() {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddressFormArgumentsModel;
    _addressModel = args.addressModel;
    _editing = args.editing;
    if (_editing) {
      _nameController.text = _addressModel!.name;
      _streetController.text = _addressModel!.street;
      _numberController.text = _addressModel!.number.toString();
      _postalCodeController.text = _addressModel!.postalCode;
      _stateController.text = _addressModel!.state;
      _municipalityController.text = _addressModel!.municipality;
      _settlementValue = _addressModel!.settlement;
      _additionalController.text = _addressModel!.additional;
      _defaultValue = _addressModel!.mark;
      _locationCubit.getLocations(_postalCodeController.text);
    }
    _valuesWereSet = true;
  }

  void editAddress() {
    _addressModel!.name = _nameController.text;
    _addressModel!.street = _streetController.text;
    _addressModel!.number = int.parse(_numberController.text);
    _addressModel!.postalCode = _postalCodeController.text;
    _addressModel!.state = _stateController.text;
    _addressModel!.municipality = _municipalityController.text;
    _addressModel!.settlement = _settlementValue!;
    _addressModel!.additional = _additionalController.text;
    _addressModel!.mark = _defaultValue;
    _addressCubit.editAddress(_addressModel!);
  }

  void addAddress() {
    AddressModel result = AddressModel(
      id: 0,
      name: _nameController.text,
      street: _streetController.text,
      number: int.parse(_numberController.text),
      postalCode: _postalCodeController.text,
      state: _stateController.text,
      municipality: _municipalityController.text,
      settlement: _settlementValue!,
      additional: _additionalController.text,
      mark: _defaultValue,
    );
    _addressCubit.addAddress(result);
  }

  @override
  Widget build(BuildContext context) {
    if (!_valuesWereSet) setValues();
    return Scaffold(
      appBar: AppBar(
        title: Text(_editing ? 'Edit address' : 'Add Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: BlocListener(
            bloc: _addressCubit,
            listener: (context, state) {
              if (state is SavedAddressesSavedState) {
                Navigator.pop(context, true);
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: ValidatorsHelper.isValidStreet,
                    maxLength: 128,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _streetController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Street',
                      border: OutlineInputBorder(),
                    ),
                    validator: ValidatorsHelper.isValidStreet,
                    maxLength: 128,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: ValidatorsHelper.isValidNumber,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _additionalController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Additional info',
                      border: OutlineInputBorder(),
                    ),
                    validator: ValidatorsHelper.isValidAdditional,
                    maxLength: 256,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SwitchListTile(
                    value: _defaultValue,
                    title: const Text('Default address'),
                    activeColor: Colors.redAccent,
                    onChanged: (value) {
                      setState(() {
                        _defaultValue = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Postal code',
                      border: OutlineInputBorder(),
                    ),
                    validator: ValidatorsHelper.isValidPostalCode,
                    onChanged: (value) {
                      _locationCubit.getLocations(value);
                    },
                    maxLength: 5,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<LocationCubit, LocationState>(
                    bloc: _locationCubit,
                    builder: (context, state) {
                      if (state is LocationLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is LocationLoadedState) {
                        return _locationFields(state.data);
                      } else if (state is LocationEmptyState) {
                        return const Text("No locations found");
                      } else if (state is LocationErrorState) {
                        return const Text("Error finding location");
                      } else {
                        return const Text("Set a postal code");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: _formKey.currentState!.validate()
                        ? () => _editing ? editAddress() : addAddress()
                        : null,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationFields(List<LocationModel> list) {
    _settlementValue ??= list.first.asentamiento;
    _stateController.text = list.first.estado;
    _municipalityController.text = list.first.municipio;
    return Column(
      children: [
        TextFormField(
          enabled: false,
          controller: _stateController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'State',
            border: OutlineInputBorder(),
          ),
          validator: ValidatorsHelper.isValidName,
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          enabled: false,
          controller: _municipalityController,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'Municipality',
            border: OutlineInputBorder(),
          ),
          validator: ValidatorsHelper.isValidMunicipality,
        ),
        const SizedBox(
          height: 16,
        ),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: _settlementValue,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (value) {
            setState(() {
              _settlementValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((LocationModel value) {
            return DropdownMenuItem<String>(
              value: value.asentamiento,
              child: Text(value.asentamiento),
            );
          }).toList(),
        ),
      ],
    );
  }
}
