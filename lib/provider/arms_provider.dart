import 'package:apex_wechat/model/arms_model.dart';
import 'package:flutter/material.dart';

class ArmsProvider with ChangeNotifier {
  ArmsModel? _amrsModel;

  void setHero(ArmsModel model) {
    this._amrsModel = model;
    notifyListeners();
  }

  ArmsModel? get amrsModel => _amrsModel;
}
