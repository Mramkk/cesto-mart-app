import 'package:cesto_mart/models/user/user.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> datalist;
  UserLoadedState(this.datalist);
}

class UserDataNotFoundState extends UserState {}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
}
