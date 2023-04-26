import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tech_test/models/location_model.dart';
import 'package:tech_test/models/locations_container_model.dart';
import 'package:tech_test/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitialState()) {}

  void getLocations(String postalCode) async {
    emit(LocationLoadingState());
    LocationsContainerModel? response =
        await LocationService().getLocations(postalCode);
    if (response != null) {
      if (response.locations.isEmpty) {
        emit(LocationEmptyState());
      } else {
        emit(LocationLoadedState(data: response.locations));
      }
    } else {
      emit(LocationErrorState(message: 'Error loading'));
    }
  }
}
