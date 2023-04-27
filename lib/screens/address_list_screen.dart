import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test/bloc/saved_addresses/saved_addresses_cubit.dart';
import 'package:tech_test/data/constants.dart';
import 'package:tech_test/models/address_form_arguments_model.dart';
import 'package:tech_test/widgets/location_tile_widget.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final SavedAddressesCubit _addressBloc = SavedAddressesCubit();

  @override
  Widget build(BuildContext context) {
    _addressBloc.getSavedAddresses();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
          bloc: _addressBloc,
          builder: (context, state) {
            if (state is SavedAddressesLoadedState) {
              return ListView.builder(
                clipBehavior: Clip.none,
                itemCount: state.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AddressTile(
                    addressModel: state.data[index],
                    savedAddressesCubit: _addressBloc,
                  );
                },
              );
            } else if (state is SavedAddressesLoadedEmptyState) {
              return const Expanded(
                child: Center(
                  child: Text(
                    'No locations found',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (state is SavedAddressesErrorState) {
              return Text(state.message);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(
              Constants.routes.addressForm,
              arguments: AddressFormArgumentsModel(
                addressModel: null,
                editing: false,
              ),
            )
            .then((val) => val as bool
                ? setState(() {
                    _addressBloc.getSavedAddresses();
                  })
                : null),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
