import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/bloc/cubit/user/user_cubit.dart';
import 'package:cesto_mart/bloc/cubit/user/user_state.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/snack/my_snack.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  MainController mc = Get.put(MainController());
  final formKey = GlobalKey<FormState>();
  TextEditingController txtusername = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtmobile = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: appbarStyle),
        backgroundColor: appbarColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            } else if (state is UserLoadedState) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
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
                        const SizedBox(height: 40),
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
                                };
                                var res = await mc.mainApi.setData(
                                    subUrl: "/auth/edit-profile", data: data);
                                if (res.isSuccessful) {
                                  setState(() {});
                                  isLoading = false;
                                  mySnack.success(message: res.message);
                                  Get.offNamed('/profile');
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
                                    'Update Profile',
                                    style: textStyleBtutton,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
          listener: (BuildContext context, UserState state) {
            if (state is UserLoadedState) {
              setState(() {});
              final user = state.datalist.first;
              txtusername.text = user.name;
              txtemail.text = user.email;
              txtmobile.text = user.mobile;
            }
          },
        ),
      ),
    );
  }
}
