import 'package:flutter/material.dart';
import 'package:tech_test/bloc/saved_addresses/saved_addresses_cubit.dart';
import 'package:tech_test/data/constants.dart';
import 'package:tech_test/models/address_form_arguments_model.dart';
import 'package:tech_test/models/address_model.dart';
import 'package:tech_test/models/location_model.dart';

class AddressTile extends StatelessWidget {
  final AddressModel addressModel;
  final SavedAddressesCubit savedAddressesCubit;

  const AddressTile(
      {super.key,
      required this.addressModel,
      required this.savedAddressesCubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: const Color.fromARGB(31, 122, 122, 122),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 128,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(addressModel.name),
              Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      Constants.routes.addressForm,
                      arguments: AddressFormArgumentsModel(
                          addressModel: addressModel, editing: true),
                    ),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () => showAlertDialog(context),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(Constants.routes.addressDetails, arguments: addressModel),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () => savedAddressesCubit.deleteAddress(addressModel.id),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Delete address"),
      content: const Text("Are you sure you want to delete this address?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
