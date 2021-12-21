import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/model/hero_model.dart';
import 'package:flutter/material.dart';

class HeroProvider with ChangeNotifier {
  HeroModel? _heroModel;
  BootstrapModel? _bootstrapModel;

  void setHero(HeroModel model) {
    this._heroModel = model;
    notifyListeners();
  }

  void setBootstrap(BootstrapModel model) {
    this._bootstrapModel = model;
    notifyListeners();
  }

  HeroModel? get heroModel => _heroModel;
  BootstrapModel? get bootstrapModel => this._bootstrapModel;
}

enum ApexType { assault, defense, support, scout }
