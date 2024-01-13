import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/apis/main_api.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/snack/my_snack.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  MainApi api = MainApi();
  final formKey = GlobalKey<FormState>();
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  TextEditingController txtcpass = TextEditingController();
  bool isLoading = false;
  bool isObscurepass = true;
  bool isObscureconfirmpass = true;
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
            height: 590,
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
                            Text("Sign Up", style: formTitle),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Username",
                                labelText: "Username",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              controller: txtusername,
                              validator: (str) {
                                if (str == "") {
                                  return "* Username required !";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Mobile",
                                labelText: "Mobile",
                                hintStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              controller: txtmobile,
                              validator: (str) {
                                if (str == "") {
                                  return "* Mobile required !";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              obscureText: isObscurepass,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Password",
                                labelText: "Password",
                                suffix: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      isObscurepass = !isObscurepass;
                                    },
                                    child: isObscurepass
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
                              obscureText: isObscureconfirmpass,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                labelText: "Confirm Password",
                                suffix: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      isObscureconfirmpass =
                                          !isObscureconfirmpass;
                                    },
                                    child: isObscureconfirmpass
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
                                      "username": txtusername.text,
                                      "email": txtemail.text,
                                      "mobile": txtmobile.text,
                                      "password": txtpass.text,
                                      "confirm_password": txtcpass.text
                                    };
                                    var res = await api.setData(
                                        subUrl: "/auth/register", data: data);
                                    if (res.isSuccessful) {
                                      setState(() {});
                                      isLoading = false;
                                      mySnack.success(message: res.message);
                                      Get.offAllNamed('/login');
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
