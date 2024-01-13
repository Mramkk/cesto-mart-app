import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/apis/auth.dart';
import 'package:cesto_mart/apis/main_api.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/snack/my_snack.dart';
import 'package:restart_app/restart_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  MainApi api = MainApi();
  final formKey = GlobalKey<FormState>();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  bool isLoading = false;
  bool isObscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: 580,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const Image(
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/imgs/logo.png'),
                            ),
                            const SizedBox(height: 10),
                            Text("Login", style: formTitle),
                            const SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email",
                                labelText: "Email",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              controller: txtemail,
                              validator: (str) {
                                if (str == "") {
                                  return "* Email required !";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              obscureText: isObscure,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Password",
                                labelText: "Password",
                                suffix: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      isObscure = !isObscure;
                                    },
                                    child: isObscure
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              controller: txtpass,
                              validator: (str) {
                                if (str == "") {
                                  return "* Password required !";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5788C6),
                                    shape: const RoundedRectangleBorder()),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {});
                                    isLoading = true;
                                    var data = {
                                      "email": txtemail.text,
                                      "password": txtpass.text
                                    };
                                    var res = await api.setData(
                                        subUrl: "/auth/login", data: data);
                                    if (res.isSuccessful) {
                                      Auth.saveToken(token: res.data['token'])
                                          .then((value) {
                                        setState(() {});
                                        isLoading = false;
                                        // mySnack.success(message: res.message);
                                        Restart.restartApp();
                                      }).onError((error, stackTrace) {
                                        setState(() {});
                                        isLoading = false;
                                        mySnack.error(
                                            message: "Something went wrong");
                                      });
                                    } else {
                                      setState(() {});
                                      isLoading = false;
                                      mySnack.error(message: res.message);
                                    }
                                  }
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        'Login',
                                        style: textStyleBtutton,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF68121),
                                    shape: const RoundedRectangleBorder()),
                                onPressed: () {
                                  Get.toNamed('/signup');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: textStyleBtutton,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
