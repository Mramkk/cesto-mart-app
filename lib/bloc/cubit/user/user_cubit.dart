import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/bloc/cubit/user/user_state.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/models/user/user.dart';

class UserCubit extends Cubit<UserState> {
  MainController mc = Get.put(MainController());
  UserCubit() : super(UserLoadingState()) {
    mc.mainApi.getData(subUrl: "/user", query: {}).then((res) {
      if (res.isSuccessful && res.data.toString() != '[]') {
        List<UserModel> datalist = [];
        for (var item in res.data) {
          datalist.add(UserModel.fromJson(item));
        }
        emit(UserLoadedState(datalist));
      } else {
        emit(UserDataNotFoundState());
      }
    }).onError((error, stackTrace) {
      emit(UserErrorState(error.toString()));
    });
  }
}
