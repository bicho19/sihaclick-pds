import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sihaclik/store/models/blood-exchange.dart';
import 'package:sihaclik/store/models/book_exchange.dart';
import 'package:sihaclik/store/models/material_exchange.dart';
import 'package:sihaclik/store/models/medicine-exchange.dart';
import 'package:sihaclik/utils/api_results.dart';
import 'package:sihaclik/utils/network_util.dart';

class ExchangesNotifier with ChangeNotifier {
  NetworkUtil _networkUtil = NetworkUtil();

  List<BloodExchange> _bloods = [];

  // List<BloodExchange> get bloods {
  //   final String type = filters['bloods']['type'];
  //   final String group = filters['bloods']['group'];
  //   final wilaya = filters['bloods']['wilaya'];
  //   final town = filters['bloods']['town'];
  //   return _bloods.where((blood) {
  //     if (type != null && type.isNotEmpty && blood.type != type) return false;
  //     if (group != null && group.isNotEmpty && blood.group != group)
  //       return false;
  //     if (wilaya != null && blood.wilaya.id != wilaya.id) return false;
  //     if (town != null && blood.town.id != town.id) return false;
  //     return true;
  //   }).toList();
  // }

  Future<List<BloodExchange>> getAllBloodDonation(
      {String groups = "all",
      String type = "all",
      String emergency = "all",
      String wilayaID = "all",
      String communeID = "all",
      int offset = 0,
      int limit = 10}) async {
    List<BloodExchange> temp = [];
    /**
     * Possible values:
        groups: A+|B+|AB+|O+ and negative ones
        type: blood|pads
        emergency: moyene|immediate|all
     */
    final ApiResult apiResult = await _networkUtil.get(
      "/api/public/donnation/blood/$groups/$type/$emergency/$wilayaID/$communeID/$offset/$limit",
      maxHours: 12,
    );
    if (apiResult.status == Status.COMPLETED) {
      print("getAllBloodDonation :: fetched data \n");
      temp = (apiResult.data as List)
          .map((e) => BloodExchange.publicFromJson(data: e))
          .toList();
    }
    return temp;
  }

  List<MedicineExchange> _medicines = [];

  // List<MedicineExchange> get medicines {
  //   final String title = filters['medicines']['title'];
  //   final String dosage = filters['medicines']['dosage'];
  //   final wilaya = filters['medicines']['wilaya'];
  //   final town = filters['medicines']['town'];
  //   return _medicines.where((medicine) {
  //     if (title != null && title.isNotEmpty && medicine.title != title)
  //       return false;
  //     if (dosage != null && dosage.isNotEmpty && medicine.dosage != dosage)
  //       return false;
  //     if (wilaya != null && medicine.wilaya.id != wilaya.id) return false;
  //     if (town != null && medicine.town.id != town.id) return false;
  //     return true;
  //   }).toList();
  // }

  Future<List<MedicineExchange>> getAllMedicineExchange(
      {String wilayaID = "all",
      String communeID = "all",
      int offset = 0,
      int limit = 10}) async {
    List<MedicineExchange> temp = [];
    final ApiResult apiResult = await _networkUtil.get(
        "/api/public/donnation/drugs/$wilayaID/$communeID/$offset/$limit",
        maxHours: 12);
    if (apiResult.status == Status.COMPLETED) {
      print("getAllMedicineExchange :: fetched data \n");
      temp = (apiResult.data as List)
          .map((e) => MedicineExchange.publicFromJson(data: e))
          .toList();
    }
    return temp;
  }

  // todo: save it to keep the same logic for the filter
  // List<BookExchange> get books {
  //   final String title = filters['books']['title'];
  //   final wilaya = filters['books']['wilaya'];
  //   final town = filters['books']['town'];
  //   return _books.where((book) {
  //     if (title != null && title.isNotEmpty && book.title != title)
  //       return false;
  //     if (wilaya != null && book.wilaya.id != wilaya.id) return false;
  //     if (town != null && book.town.id != town.id) return false;
  //     return true;
  //   }).toList();
  // }

  Future<List<BookExchange>> getAllBookExchange(
      {String wilayaID = "all",
      String communeID = "all",
      int offset = 0,
      int limit = 10}) async {
    List<BookExchange> temp = [];
    final ApiResult apiResult = await _networkUtil.get(
        "/api/public/donnation/books/$wilayaID/$communeID/$offset/$limit",
        maxHours: 12);
    if (apiResult.status == Status.COMPLETED) {
      print("getAllBookExchange :: fetched data \n");
      temp = (apiResult.data as List)
          .map((e) => BookExchange.publicFromJson(data: e))
          .toList();
    }
    return temp;
  }

  List<MaterialExchange> _materials = [];

  // List<MaterialExchange> get materials {
  //   final String title = filters['materials']['title'];
  //   final wilaya = filters['materials']['wilaya'];
  //   final town = filters['materials']['town'];
  //   return _materials.where((material) {
  //     if (title != null && title.isNotEmpty && material.title != title)
  //       return false;
  //     if (wilaya != null && material.wilaya.id != wilaya.id) return false;
  //     if (town != null && material.town.id != town.id) return false;
  //     return true;
  //   }).toList();
  // }

  Future<List<MaterialExchange>> getAllMaterialExchange(
      {String wilayaID = "all",
      String communeID = "all",
      int offset = 0,
      int limit = 10}) async {
    List<MaterialExchange> temp = [];
    final ApiResult apiResult = await _networkUtil.get(
        "/api/public/donnation/equipments/$wilayaID/$communeID/$offset/$limit",
        maxHours: 12);
    if (apiResult.status == Status.COMPLETED) {
      print("getAllMaterialExchange :: fetched data \n");
      temp = (apiResult.data as List)
          .map((e) => MaterialExchange.publicFromJson(data: e))
          .toList();
    }
    return temp;
  }

  Map<String, Map<String, dynamic>> filters = {
    "bloods": {},
    "medicines": {},
    "books": {},
    "materials": {},
  };

  init() async {
    // Exchange initialization
    // notifyListeners();
  }

  Future<void> createMedicine({
    @required title,
    @required description,
    image,
    @required date,
    @required molecule,
    @required dosage,
    @required experation,
    @required wilaya,
    @required town,
    @required phone,
  }) async {
    _medicines.insert(
      0,
      MedicineExchange(
        // title: title,
        // image: image,
        // date: date,
        // molecule: molecule,
        // dosage: dosage,
        // experation: experation,
        // wilaya: wilaya,
        // town: town,
        // phone: phone,
      ),
    );
    notifyListeners();
  }

  Future<void> createMaterial({
    @required title,
    @required description,
    image,
    @required date,
    @required quantity,
    @required wilaya,
    @required town,
    @required phone,
  }) async {
    _materials.insert(
      0,
      MaterialExchange(
        name: title,
        //description: description,
        quantity: quantity,
        imgPath: image,
        createdAt: date,
        //wilaya: wilaya,
        //town: town,
        //phone: phone,
      ),
    );
    notifyListeners();
  }

  Future<void> createBook({
    @required title,
    @required description,
    image,
    @required date,
    @required quantity,
    @required wilaya,
    @required town,
    @required phone,
  }) async {
    _materials.insert(
      0,
      MaterialExchange(
        // title: title,
        // description: description,
        // quantity: quantity,
        // image: image,
        // date: date,
        // wilaya: wilaya,
        // town: town,
        // phone: phone,
      ),
    );
    notifyListeners();
  }

  Future<void> createBlood({
    @required type,
    @required group,
    @required date,
    @required wilaya,
    @required town,
    @required phone,
  }) async {
    _bloods.insert(
      0,
      BloodExchange(
        // type: type,
        // group: group,
        // date: date,
        // wilaya: wilaya,
        // town: town,
        // phone: phone,
        // urgent: false,
      ),
    );
    notifyListeners();
  }

  void filterMedicine({
    @required title,
    @required dosage,
    @required wilaya,
    @required town,
  }) {
    filters['medicines'] = {
      "title": title,
      "dosage": dosage,
      "wilaya": wilaya,
      "town": town,
    };
    notifyListeners();
  }

  void filterMaterial({
    @required title,
    @required wilaya,
    @required town,
  }) {
    filters['materials'] = {
      "title": title,
      "wilaya": wilaya,
      "town": town,
    };
    notifyListeners();
  }

  void filterBook({
    @required title,
    @required wilaya,
    @required town,
  }) {
    filters['books'] = {
      "title": title,
      "wilaya": wilaya,
      "town": town,
    };
    notifyListeners();
  }

  void filterBlood({
    @required type,
    @required group,
    @required wilaya,
    @required town,
  }) {
    filters['bloods'] = {
      "type": type,
      "group": group,
      "wilaya": wilaya,
      "town": town,
    };
    notifyListeners();
  }
}
