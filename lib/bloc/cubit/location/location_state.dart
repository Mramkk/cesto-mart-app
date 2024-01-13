import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationLoadingState extends LocationState {}

class LocationGainedState extends LocationState {
  final Position position;
  LocationGainedState(this.position);
}

class LocationErrorState extends LocationState {
  final String message;
  LocationErrorState(this.message);
}
