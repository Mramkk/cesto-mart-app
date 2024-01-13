import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/apis/auth.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/snack/my_snack.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  MainController mc = Get.put(MainController());
  final formKey = GlobalKey<FormState>();
  TextEditingController txtoldpass = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  TextEditingController txtcpass = TextEditingController();
  bool isLoading = false;
  bool isObscureOldPass = true;
  bool isObscurePass = true;
  bool isObscureConfirmPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Change Password", style: appbarStyle),
          backgroundColor: appbarColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    TextFormField(
                      obscureText: isObscurePass,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Old password",
                        labelText: "Old password",
                        suffix: InkWell(
                            onTap: () {
                              setState(() {});
                              isObscureOldPass = !isObscureOldPass;
                            },
                            child: isObscureOldPass
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
                      controller: txtoldpass,
                      validator: (str) {
                        if (str == "") {
                          return "* Old password required !";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: isObscurePass,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        suffix: InkWell(
                            onTap: () {
                              setState(() {});
                              isObscurePass = !isObscurePass;
                            },
                            child: isObscurePass
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
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: isObscureConfirmPass,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        labelText: "Confirm Password",
                        suffix: InkWell(
                            onTap: () {
                              setState(() {});
                              isObscureConfirmPass = !isObscureConfirmPass;
                            },
                            child: isObscureConfirmPass
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
                      controller: txtcpass,
                      validator: (str) {
                        if (str == "") {
                          return "* Confirm Password required !";
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
                              "old_password": txtoldpass.text,
                              "password": txtpass.text,
                              "confirm_password": txtcpass.text
                            };
                            var res = await mc.mainApi.setData(
                                subUrl: "/auth/change-password", data: data);
                            if (res.isSuccessful) {
                              Auth.deleteToken().then((value) {
                                setState(() {});
                                isLoading = false;
                                mySnack.success(message: res.message);
                                Get.offAllNamed('/login');
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
                                color: Colors.white,
                              )
                            : Text(
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
        ));
  }
}
