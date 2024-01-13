import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cesto_mart/bloc/cubit/location/location_state.dart';
import 'package:cesto_mart/myclass/location.dart';

class LocationCubit extends Cubit<LocationState> {
  Location location = Location();
  LocationCubit() : super(LocationLoadingState()) {
    location.getGeoLocationPosition().then((position) {
      emit(LocationGainedState(position));
    }).onError((error, stackTrace) {
      emit(LocationErrorState(error.toString()));
    });
  }
}
