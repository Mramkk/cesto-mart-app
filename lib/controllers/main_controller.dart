import 'package:get/get.dart';
import 'package:cesto_mart/apis/auth.dart';
import 'package:cesto_mart/apis/main_api.dart';

class MainController extends GetxController {
  MainApi mainApi = MainApi();
  var myToken = "".obs;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  load() {
    Auth.getToken().then((token) {
      myToken.value = token;
      if (token != "null") {
        mainApi.api.dio.options.headers = {
          "Authorization": "Bearer ${myToken.value}"
        };
      }
    });
  }
}
