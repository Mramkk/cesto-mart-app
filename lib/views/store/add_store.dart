import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/bloc/cubit/location/location_cubit.dart';
import 'package:cesto_mart/bloc/cubit/location/location_state.dart';
import 'package:cesto_mart/myclass/location.dart';
import 'package:cesto_mart/snack/my_snack.dart';
import 'package:image_picker/image_picker.dart';

class AddStore extends StatefulWidget {
  const AddStore({super.key});

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  MainController mc = Get.put(MainController());
  final formKey = GlobalKey<FormState>();
  Location location = Location();
  String filePath = '';
  bool isFilePicked = false;

  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  TextEditingController txtwhatsapp = TextEditingController();
  TextEditingController txtaadhar = TextEditingController();
  TextEditingController txtpan = TextEditingController();
  TextEditingController txtgst = TextEditingController();
  TextEditingController txtpincode = TextEditingController();
  TextEditingController txtaddress = TextEditingController();
  TextEditingController txtstate = TextEditingController();
  TextEditingController txtcity = TextEditingController();
  TextEditingController txtdivision = TextEditingController();
  TextEditingController txtarea = TextEditingController();
  TextEditingController txtlatitude = TextEditingController();
  TextEditingController txtlongitude = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Store", style: appbarStyle),
        backgroundColor: appbarColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "* Name",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtname,
                  validator: (str) {
                    if (str == "") {
                      return "* Name required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "* Email",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Mobile No.",
                    labelText: "* Mobile No.",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtmobile,
                  validator: (str) {
                    if (str == "") {
                      return "* Mobile No. required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Whatsapp No.",
                    labelText: "* Whatsapp No.",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtwhatsapp,
                  validator: (str) {
                    if (str == "") {
                      return "* Whatsapp No. required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Aadhar No.",
                    labelText: "* Aadhar No.",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtaadhar,
                  validator: (str) {
                    if (str == "") {
                      return "* Aadhar No. required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "PAN",
                    labelText: "* PAN",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtpan,
                  validator: (str) {
                    if (str == "") {
                      return "* PAN required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "GSTIN",
                    labelText: "GSTIN",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtgst,
                  // validator: (str) {
                  //   if (str == "") {
                  //     return "* GSTIN required !";
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10),
                BlocConsumer<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "State",
                            labelText: "* State",
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: txtstate,
                          validator: (str) {
                            if (str == "") {
                              return "* State required !";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "City",
                            labelText: "* City",
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: txtcity,
                          validator: (str) {
                            if (str == "") {
                              return "* City required !";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Division",
                            labelText: "* Division",
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: txtdivision,
                          validator: (str) {
                            if (str == "") {
                              return "* Division required !";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Area",
                            labelText: "* Area",
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: txtarea,
                          validator: (str) {
                            if (str == "") {
                              return "* Area required !";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Pin Code",
                            labelText: "* Pin Code",
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: txtpincode,
                          validator: (str) {
                            if (str == "") {
                              return "* Pin Code required !";
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  },
                  listener: (context, state) {
                    if (state is LocationGainedState) {
                      location
                          .getAddressFromLatLong(state.position)
                          .then((place) {
                        setState(() {});
                        txtlatitude.text = state.position.latitude.toString();
                        txtlongitude.text = state.position.longitude.toString();
                        txtstate.text = place.administrativeArea.toString();
                        txtcity.text = place.locality.toString();
                        txtdivision.text =
                            place.subAdministrativeArea.toString();
                        txtpincode.text = place.postalCode.toString();
                        txtarea.text = place.subLocality.toString();
                      });
                    } else if (state is LocationErrorState) {
                      mySnack.error(message: state.message);
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Address",
                    labelText: "* Address",
                    hintStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  controller: txtaddress,
                  validator: (str) {
                    if (str == "") {
                      return "* Address required !";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    File? file = await pickImg();
                    if (file != null) {
                      setState(() {});
                      isFilePicked = true;
                      filePath = file.path;
                    } else {
                      mySnack.error(message: "No document selected !");
                    }
                  },
                  child: Container(
                    width: Get.width,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: isFilePicked
                            ? null
                            : Border.all(color: Colors.black),
                        image: isFilePicked
                            ? DecorationImage(
                                image: FileImage(
                                  File(filePath),
                                ),
                                fit: BoxFit.cover,
                              )
                            : null),
                    child: isFilePicked
                        ? null
                        : const Center(
                            child: Text(
                            "Upload document",
                            style: TextStyle(color: Colors.black),
                          )),
                  ),
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
                          "name": txtname.text,
                          "email": txtemail.text,
                          "mobile_no": txtmobile.text,
                          "whatsapp_no": txtwhatsapp.text,
                          "aadhar_no": txtaadhar.text,
                          "pan": txtpan.text,
                          "gstin": txtgst.text,
                          "state": txtstate.text,
                          "city": txtcity.text,
                          "division": txtdivision.text,
                          "area": txtarea.text,
                          "pincode": txtpincode.text,
                          "address": txtaddress.text,
                          "latitude": txtlatitude.text,
                          "longitude": txtlongitude.text,
                        };

                        if (isFilePicked) {
                          var res = await mc.mainApi
                              .setData(subUrl: "/store/save", data: data);
                          if (res.isSuccessful) {
                            var res2 = await mc.mainApi.uploadDocument(
                                subUrl: "/store/document",
                                file: File(filePath));
                            if (res2.isSuccessful) {
                              setState(() {});
                              isLoading = false;
                              Get.offAllNamed('/home');
                              mySnack.success(message: res2.message);
                            } else {
                              setState(() {});
                              isLoading = false;
                              mySnack.error(message: res2.message);
                            }
                          } else {
                            setState(() {});
                            isLoading = false;
                            mySnack.error(message: res.message);
                          }
                        } else {
                          var res = await mc.mainApi
                              .setData(subUrl: "/store/save", data: data);
                          if (res.isSuccessful) {
                            setState(() {});
                            isLoading = false;
                            Get.offAllNamed('/home');
                            mySnack.success(message: res.message);
                          } else {
                            setState(() {});
                            isLoading = false;
                            mySnack.error(message: res.message);
                          }
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Submit',
                            style: textStyleBtutton,
                          ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> pickImg() async {
    ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  }
}
