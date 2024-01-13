import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:cesto_mart/apis/auth.dart';
import 'package:cesto_mart/bloc/cubit/internet/internet_cubit.dart';
import 'package:cesto_mart/bloc/cubit/internet/internet_state.dart';
import 'package:cesto_mart/bloc/cubit/store/store_cubit.dart';
import 'package:cesto_mart/bloc/cubit/store/store_state.dart';
import 'package:cesto_mart/config/colors.dart';
import 'package:cesto_mart/config/text_styles.dart';
import 'package:cesto_mart/controllers/main_controller.dart';
import 'package:cesto_mart/snack/my_snack.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MainController mc = Get.put(MainController());
  bool isLoading = false;
  TextStyle mytxtStyle = const TextStyle(
      fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: appbarStyle),
        backgroundColor: appbarColor,
        actions: isLoading
            ? [const CircularProgressIndicator(color: Colors.white)]
            : [
                PopupMenuButton<int>(
                  onSelected: (item) => handleClick(item),
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Profile')),
                    const PopupMenuItem<int>(value: 1, child: Text('Logout')),
                  ],
                ),
              ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCF6B19),
        onPressed: () {
          Get.toNamed('/add-store');
        },
        child: const Icon(
          Icons.add_business,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetLostState) {
            return const Center(child: Text("No Internet Connection"));
          } else if (state is InternetLostState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return BlocConsumer<StoreCubit, StoreState>(
            builder: (context, state) {
              if (state is StoreLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFCF6B19),
                  ),
                );
              }
              if (state is StoreDataNotFoundState) {
                return Center(
                  child: Center(
                    child: Text(
                      "Data Not Found",
                      style: dataNotFound,
                    ),
                  ),
                );
              }
              if (state is StoreLoadedState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ListView.builder(
                    itemCount: state.datalist.length,
                    itemBuilder: (context, index) {
                      final item = state.datalist[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/store-details',
                              arguments: {"store": item});
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              leading: const Icon(Icons.store),
                              trailing: const Icon(Icons.chevron_right),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: mytxtStyle),
                                  Text(item.email, style: mytxtStyle),
                                  Text(item.state, style: mytxtStyle),
                                  Text(item.city, style: mytxtStyle)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is StoreErrorState) {
                mySnack.error(message: state.error);
              }
            },
          );
        },
      ),
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        Get.toNamed('/profile');
        break;
      case 1:
        setState(() {});
        isLoading = true;
        mc.mainApi.setData(subUrl: "/auth/logout", data: {}).then((res) {
          if (res.isSuccessful) {
            Auth.deleteToken().then((value) {
              setState(() {});
              isLoading = false;
              Get.deleteAll(force: true);
              mySnack.success(message: res.message);
              Get.offAllNamed('/login');
            });
          } else {
            setState(() {});
            isLoading = false;
            mySnack.error(message: res.message);
          }
        }).onError((error, stackTrace) {
          setState(() {});
          isLoading = false;
          mySnack.error(message: error.toString());
        });
        break;
    }
  }
}
