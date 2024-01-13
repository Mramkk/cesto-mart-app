import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/bloc/cubit/store/store_cubit.dart';
import 'package:cesto_mart/bloc/cubit/store/store_state.dart';
import 'package:cesto_mart/bloc/cubit/user/user_cubit.dart';
import 'package:cesto_mart/bloc/cubit/user/user_state.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle txtStyle = const TextStyle(
      fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w500);
  TextStyle lblStyle = const TextStyle(
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      color: Colors.black38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: appbarStyle),
        backgroundColor: appbarColor,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Edit Profile')),
              const PopupMenuItem<int>(
                  value: 1, child: Text('Change Password')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/profile/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
            if (state is StoreLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            } else if (state is StoreDataNotFoundState) {
              return Center(
                child: Text("Data Not Found", style: dataNotFound),
              );
            } else if (state is StoreLoadedState) {
              return Column(
                children: [
                  const SizedBox(height: 250),
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.store,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Total Stores : ${state.datalist.length}",
                              style: txtStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                    if (state is UserLoadingState) {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.white));
                    } else if (state is UserDataNotFoundState) {
                      return Center(
                        child: Text("Data Not Found", style: dataNotFound),
                      );
                    } else if (state is UserLoadedState) {
                      final user = state.datalist.first;
                      return Column(
                        children: [
                          widTile(lbl: "Empcode", txt: user.empCode),
                          widTile(lbl: "Name", txt: user.name),
                          widTile(lbl: "Email", txt: user.email),
                          widTile(lbl: "Mobile No.", txt: user.mobile),
                          widTile(
                              lbl: "Joining Date",
                              txt:
                                  "${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}"),
                        ],
                      );
                    }
                    return Container();
                  })
                ],
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }

  widTile({required String lbl, required String txt}) {
    return Card(
      child: ListTile(
        title: Text(lbl, style: lblStyle),
        subtitle: Text(txt, style: txtStyle),
      ),
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        Get.toNamed('/edit-profile');
        break;
      case 1:
        Get.toNamed('/change-password');
        break;
    }
  }
}
