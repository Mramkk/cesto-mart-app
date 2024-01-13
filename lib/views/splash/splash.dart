import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/apis/auth.dart';
import 'package:cesto_mart/controllers/main_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainController mc = Get.put(MainController());
  @override
  void initState() {
    Auth.getToken().then((token) {
      if (token != "null") {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offNamed('/home');
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offNamed('/login');
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(
      fit: BoxFit.cover,
      image: AssetImage('assets/imgs/splash/splash.png'),
    );
  }
}
