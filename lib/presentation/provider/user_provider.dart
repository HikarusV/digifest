import 'package:digifest/data/global.dart';
import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:flutter/material.dart';

import '../../data/model/allowance_table.dart';

class UserProvider with ChangeNotifier {
  String? _name;
  List<AllowanceTable> allowanceDataList = [];
  List<ExpenditureTable> expenditureDataList = [];
  List<IncomeTable> incomeDataList = [];

  void init() {
    _name = dataCache.getString('user');
  }

  void changeName(String name) {
    _name = name;
    dataCache.setString('user', name);
    notifyListeners();
  }

  String getName() => _name ?? "";
}
