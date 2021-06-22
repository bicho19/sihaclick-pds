class Config {
  // static const String API_URL = "http://192.168.1.9:8000";
  static const String API_URL = "http://207.154.201.247:8000";

  // ignore: non_constant_identifier_names
  static final RegExp EMAIL_REGEXP =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const int int64MaxValue = 9223372036854775807;
}
