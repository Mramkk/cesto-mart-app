import 'package:cesto_mart/models/store/store.dart';

abstract class StoreState {}

class StoreLoadingState extends StoreState {}

class StoreLoadedState extends StoreState {
  final List<StoreModel> datalist;
  StoreLoadedState(this.datalist);
}

class StoreDataNotFoundState extends StoreState {}

class StoreErrorState extends StoreState {
  final String error;
  StoreErrorState(this.error);
}
