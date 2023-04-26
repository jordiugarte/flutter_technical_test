import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tech_test/models/address_model.dart';
import 'package:tech_test/services/saved_addresses_Service.dart';

part 'saved_addresses_state.dart';

class SavedAddressesCubit extends Cubit<SavedAddressesState> {
  SavedAddressesCubit() : super(SavedAddressesInitialState()) {}

  SavedAddressesService _savedAddressesService = SavedAddressesService();

  void getSavedAddresses() async {
    emit(SavedAddressesLoadingState());
    List<AddressModel> response = await _savedAddressesService.getAddressList();
    if (response.isNotEmpty) {
      emit(SavedAddressesLoadedState(response));
    } else {
      emit(SavedAddressesLoadedEmptyState());
    }
  }

  void addAddress(AddressModel addressModel) async {
    emit(SavedAddressesLoadingState());
    bool response = await _savedAddressesService.addAddress(addressModel);
    if (response) {
      emit(SavedAddressesSavedState());
    } else {
      emit(SavedAddressesErrorState("Could not save."));
    }
  }

  void deleteAddress(int id) async {
    emit(SavedAddressesLoadingState());
    bool response = await _savedAddressesService.deleteAddress(id);
    if (response) {
      emit(SavedAddressesSavedState());
    } else {
      emit(SavedAddressesErrorState("Could not delete."));
    }
  }

  void editAddress(AddressModel addressModel) async {
    emit(SavedAddressesLoadingState());
    bool response = await _savedAddressesService.editAddress(addressModel);
    if (response) {
      emit(SavedAddressesSavedState());
    } else {
      emit(SavedAddressesErrorState("Could not edit."));
    }
  }
}
