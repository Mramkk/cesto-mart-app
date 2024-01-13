import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cesto_mart/bloc/cubit/internet/internet_cubit.dart';
import 'package:cesto_mart/bloc/cubit/location/location_cubit.dart';
import 'package:cesto_mart/bloc/cubit/store/store_cubit.dart';
import 'package:cesto_mart/bloc/cubit/user/user_cubit.dart';
import 'package:cesto_mart/models/store/store.dart';
import 'package:cesto_mart/views/home/home.dart';
import 'package:cesto_mart/views/login/login.dart';
import 'package:cesto_mart/views/profile/change_password.dart';
import 'package:cesto_mart/views/profile/edit_profile.dart';
import 'package:cesto_mart/views/profile/profile.dart';
import 'package:cesto_mart/views/signup/signup.dart';
import 'package:cesto_mart/views/splash/splash.dart';
import 'package:cesto_mart/views/store/add_store.dart';
import 'package:cesto_mart/views/store/store_details.dart';

class Routes {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const Login(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => StoreCubit()),
              BlocProvider(create: (_) => UserCubit()),
            ],
            child: const Profile(),
          ),
        );
      case '/edit-profile':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => UserCubit(),
            child: const EditProfile(),
          ),
        );
      case '/change-password':
        return MaterialPageRoute(
          builder: (_) => const ChangePassword(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => InternetCubit()),
              BlocProvider(create: (_) => StoreCubit()),
            ],
            child: const Home(),
          ),
        );

      case '/add-store':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LocationCubit(),
            child: const AddStore(),
          ),
        );
      case '/store-details':
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        final StoreModel store = arguments['store'];
        return MaterialPageRoute(
          builder: (_) => StoreDetails(
            store: store,
          ),
        );

      default:
        return null;
    }
  }
}
