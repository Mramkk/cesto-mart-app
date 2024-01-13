import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cesto_mart/bloc/cubit/internet/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity con = Connectivity();
  StreamSubscription? conSubscription;
  InternetCubit() : super(InternetInitialState()) {
    conSubscription = con.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetGainedState());
      } else {
        emit(InternetLostState());
      }
    });
  }
  @override
  Future<void> close() {
    conSubscription?.cancel();
    return super.close();
  }
}
