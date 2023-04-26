part of 'saved_addresses_cubit.dart';

@immutable
abstract class SavedAddressesState {}

class SavedAddressesInitialState extends SavedAddressesState {}

class SavedAddressesLoadingState extends SavedAddressesState {}

class SavedAddressesLoadedState extends SavedAddressesState {
  final List<AddressModel> data;
  SavedAddressesLoadedState(this.data);
}

class SavedAddressesSavedState extends SavedAddressesState {}

class SavedAddressesLoadedEmptyState extends SavedAddressesState {}

class SavedAddressesErrorState extends SavedAddressesState {
  final String message;
  SavedAddressesErrorState(this.message);
}
