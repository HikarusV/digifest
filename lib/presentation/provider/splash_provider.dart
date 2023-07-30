import 'package:digifest/common/state.dart';
import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  ResultState state = ResultState.empty;

  Future splashscreenController(int second) async {
    state = ResultState.loading;
    notifyListeners();

    await Future.delayed(Duration(seconds: second));

    state = ResultState.hasData;
    notifyListeners();
  }
}
