import 'package:apex_wechat/model/hero_model.dart';
import 'package:flutter/material.dart';

class HeroProvider with ChangeNotifier {
  HeroModel? _heroModel;

  void setHero(HeroModel model) {
    this._heroModel = model;
    notifyListeners();
  }

  get heroModel => _heroModel;
}
