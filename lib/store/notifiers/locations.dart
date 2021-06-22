
import 'package:flutter/material.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:sihaclik/utils/api_results.dart';
import 'package:sihaclik/utils/network_util.dart';

class LocationsNotifier with ChangeNotifier {
  List<Wilaya> _wilayas = [];

  List<Wilaya> get wilayas => _wilayas;
  NetworkUtil _networkUtil = NetworkUtil();

  init() async {
    final ApiResult results = await _networkUtil.get("/wilaya", maxDays: 30);
    if (results.status == Status.COMPLETED) {
      _wilayas = (results.data as List).map((d) => Wilaya.fromJson(d)).toList();
      notifyListeners();
    }
  }
}
