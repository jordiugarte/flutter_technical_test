part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitialState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final List<LocationModel> data;
  LocationLoadedState({required this.data});
}

class LocationEmptyState extends LocationState {}

class LocationErrorState extends LocationState {
  final String message;
  LocationErrorState({required this.message});
}
