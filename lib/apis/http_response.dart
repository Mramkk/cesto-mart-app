class HttpRes<T> {
  bool isSuccessful;
  T data;
  String message;
  int? responseCode;
  HttpRes(this.isSuccessful, this.data,
      {required this.message, this.responseCode});
}
