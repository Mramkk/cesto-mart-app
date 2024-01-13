import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/bloc/cubit/store/store_state.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/models/store/store.dart';

class StoreCubit extends Cubit<StoreState> {
  MainController mc = Get.put(MainController());
  StoreCubit() : super(StoreLoadingState()) {
    mc.mainApi.getData(subUrl: "/store", query: {}).then((res) {
      if (res.isSuccessful && res.data.toString() != '[]') {
        List<StoreModel> datalist = [];
        for (var item in res.data) {
          datalist.add(StoreModel.fromJson(item));
        }
        emit(StoreLoadedState(datalist));
      } else {
        emit(StoreDataNotFoundState());
      }
    }).onError((error, stackTrace) {
      emit(StoreErrorState(error.toString()));
    });
  }
}
