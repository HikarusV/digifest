import 'dart:developer';

import 'package:digifest/common/state.dart';
import 'package:digifest/data/global.dart';
import 'package:digifest/data/model/allowance_table.dart';
import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<IncomeTable> incomeTableDataList = [];
  List<ExpenditureTable> expenditureTableDataList = [];

  int expenditure = 0;
  int income = 0;
  int allowance = 0;

  ResultState allowanceDataState = ResultState.empty;
  ResultState incomeDataState = ResultState.empty;
  ResultState expenditureDataState = ResultState.empty;

  List<String> allowanceCategories = [];
  List<int> allowanceCategoriesPrice = [];
  Map<String, List<AllowanceTable>> allowanceTableData = {};

  Future fetchAllowanceData() async {
    allowanceDataState = ResultState.loading;
    notifyListeners();

    try {
      databaseHelper.getAllowanceCategoriesData().then((value) async {
        allowanceCategories.clear();
        for (Map<String, dynamic> i in value) {
          allowanceCategories.add(i['categories']);
        }

        allowanceTableData.clear();
        allowanceCategoriesPrice.clear();

        int index = 0;
        for (String i in allowanceCategories) {
          await databaseHelper.getAllowanceByCategories(i).then((value) {
            List<AllowanceTable> buffer = [];
            allowance = 0;

            for (Map<String, dynamic> i in value) {
              buffer.add(AllowanceTable.fromMap(i));
              allowance += buffer[buffer.length - 1].jumlah!;
            }
            buffer.sort((a, b) => a.tanggal!.compareTo(b.tanggal!));
            allowanceTableData[i] = List.from(buffer);
            allowanceCategoriesPrice.add(allowance);
          });
          index++;
        }
        allowanceDataState = allowanceCategories.isNotEmpty
            ? ResultState.hasData
            : ResultState.noData;
        notifyListeners();
      });
    } on Exception catch (e) {
      allowanceDataState = ResultState.error;
      notifyListeners();
    }
  }

  Future fetchExpenditureData() async {
    expenditureDataState = ResultState.loading;
    notifyListeners();

    try {
      databaseHelper.getExpenditure().then((value) {
        List<ExpenditureTable> buffer = [];

        expenditure = 0;

        for (Map<String, dynamic> i in value) {
          buffer.add(ExpenditureTable.fromMap(i));
          expenditure += buffer[buffer.length - 1].jumlah!;
        }
        buffer.sort((a, b) => a.tanggal!.compareTo(b.tanggal!));
        expenditureTableDataList = List.from(buffer);
        expenditureDataState =
            buffer.isNotEmpty ? ResultState.hasData : ResultState.noData;
        notifyListeners();
      });
    } on Exception catch (e) {
      expenditureDataState = ResultState.error;
      notifyListeners();
    }
  }

  Future fetchIncomeData() async {
    incomeDataState = ResultState.loading;
    notifyListeners();

    try {
      databaseHelper.getIncome().then((value) {
        // print(value);
        List<IncomeTable> buffer = [];
        income = 0;

        for (Map<String, dynamic> i in value) {
          buffer.add(IncomeTable.fromMap(i));
          income += buffer[buffer.length - 1].jumlah!;
        }
        buffer.sort((a, b) => a.tanggal!.compareTo(b.tanggal!));
        incomeTableDataList = List.from(buffer);
        incomeDataState =
            buffer.isNotEmpty ? ResultState.hasData : ResultState.noData;
        notifyListeners();
      });
    } on Exception catch (e) {
      incomeDataState = ResultState.error;
      notifyListeners();
    }
  }
}
