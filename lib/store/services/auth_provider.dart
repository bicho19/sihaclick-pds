import 'package:flutter/foundation.dart';
import 'package:sihaclik/config.dart';
import 'package:sihaclik/store/models/chaab.dart';
import 'package:sihaclik/store/models/user.dart';
import 'package:sihaclik/utils/api_results.dart';
import 'package:sihaclik/utils/database_helper.dart';
import 'package:sihaclik/utils/network_util.dart';

class AuthStateProvider with ChangeNotifier {
  static final AuthStateProvider _instance = AuthStateProvider.internal();

  factory AuthStateProvider() => _instance;
  User _currentUser;
  Map<String, dynamic> _registerAuthMap;
  NetworkUtil _networkUtil = NetworkUtil();
  DatabaseHelper _databaseHelper;

  AuthStateProvider.internal() {
    initState();
  }

  User get currentUser => _currentUser;

  void initState() async {
    //TODO: implement secure storage
    _currentUser = User(chaab: Chaab());
    _registerAuthMap = {};
    _databaseHelper = DatabaseHelper();
  }

  void setUserBasicInformation(User user) {
    if (user != null) {
      this._currentUser = this._currentUser.copyWith(
            name: user?.name,
            lastname: user?.lastname,
            email: user?.email,
            phone: user?.phone,
            password: user?.password,
            confirm: user?.confirm,
          );
    }
  }

  void setUserChaab(Chaab chaab) {
    if (chaab != null) {
      this._currentUser = this._currentUser.copyWith(
            chaab: chaab,
          );
    }
  }

  Future<bool> registerUser() async {
    _registerAuthMap['name'] = _currentUser.name;
    _registerAuthMap['lastname'] = _currentUser.lastname;
    _registerAuthMap['email'] = _currentUser.email;
    _registerAuthMap['phone'] = _currentUser.phone;
    _registerAuthMap['password'] = _currentUser.password;
    _registerAuthMap['confirm'] = _currentUser.confirm;

    _registerAuthMap['chaab'] = <String, dynamic>{
      "address": <String, dynamic>{
        "commune": <String, dynamic>{
          "id": _currentUser.chaab?.address?.commune?.id
        }
      },
      "language": _currentUser.chaab?.language,
      "blood_notification": _currentUser.chaab?.blood_notification
    };
    print(_registerAuthMap);
    final results =
    await _networkUtil.post("/api/chaab/signup/", body: _registerAuthMap);

    //Check for response body, ERROR || JWT TOKEN
    print("After post \n" + results.status.toString() + " data: \n " +
        results.data.toString());
    if (results.status == Status.ERROR ||
        results.status == Status.FIELDS_ERROR) {
      //Error while signing up
      debugPrint("Error signing up, error: ");
      print(results.status);
      return Future.value(false);
    } else if (results.status == Status.COMPLETED) {
      //We got a token,
      debugPrint("Success signing up, token is ");
      print(results);
      await _databaseHelper.saveToken(token: results.data);
      _networkUtil.setAuthenticationToken(token: results.data);
      await _getUserInfo();
      return Future.value(true);
    }
  }

  Future<bool> loginUser({String email, String password}) async {
    Map<String, String> authMap = {"email": email, "password": password};
    bool _returnValue;

    final results = await _networkUtil.post("/api/chaab/login/", body: authMap);
    //Check for response body, ERROR || JWT TOKEN
    if (results.status == Status.ERROR ||
        results.status == Status.FIELDS_ERROR) {
      //Error while signing up
      debugPrint("Error signing in, error: ");
      print(results.message);
      _returnValue = false;
      return _returnValue;
    } else if (results.status == Status.COMPLETED && results.data is String) {
      //We got a token,
      debugPrint("Success signing in, token is ");
      print(results);
      await _databaseHelper.saveToken(token: results.data);
      _networkUtil.setAuthenticationToken(token: results.data);
      //get chaab information
      await _getUserInfo();
      _returnValue = true;
      return _returnValue;
    }
  }

  void setBloodGroup(int id) {
    _registerAuthMap['blood_group'] = <String, dynamic>{"id": id};
  }

  Future<void> logout() async {
    await _databaseHelper.clearAllData();
    _networkUtil.removeAuthentification();
  }

  Future<bool> isUserLoggedIn() async {
    String token = await _databaseHelper.isLoggedIn();
    User user = await _databaseHelper.getLoggedInUser();
    _currentUser = user ?? User();
    if (token != null && token.length > 0 && user != null) {
      print("Token : \n" + token);
      //user is logged in already,
      //set token header
      _networkUtil.setAuthenticationToken(token: token);
      return true;
    } else {
      return false;
    }
  }

  Future<void> _getUserInfo() async {
    final results = await _networkUtil.get("/api/chaab/get-chaab");
    //Check for response body, ERROR || JWT TOKEN
    if (results.status == Status.ERROR ||
        results.status == Status.FIELDS_ERROR) {
      //Error while signing up
      print("Error signing up, error: ");
      print(results.message);
      return null;
    } else {
      //We got a token,
      print("Got User data");
      print(results);
      _currentUser = User.fromJson(results.data);
      //Save it to local database
      await _databaseHelper.saveUser(_currentUser);
    }
  }
}
