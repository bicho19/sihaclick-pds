import 'package:flutter/material.dart';
import 'package:sihaclik/store/models/pds_model.dart';
import 'package:sihaclik/utils/api_results.dart';
import 'package:sihaclik/utils/network_util.dart';

class PDSNotifier with ChangeNotifier {
  List<ProfessionalDS> _listPds = [];

  List<ProfessionalDS> get listPds => _listPds;
  NetworkUtil _networkUtil = NetworkUtil();

  Future<List<ProfessionalDS>> getListOfPDS() async {
    //URL : /api/public/pds/:offset/:limit, default offset : 0, limit : 10
    final ApiResult results =
        await _networkUtil.get("/api/public/pds/0/10", maxDays: 3);
    if (results != null && results.status == Status.COMPLETED) {
      debugPrint("PDSListNotifier :: Fetched pdslist");
      List<dynamic> tempList = results.data as List;
      _listPds = tempList.map((d) => ProfessionalDS.fromJson(data: d)).toList();
      //notifyListeners();
      return _listPds;
    }
  }
}
