import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/model/hero_model.dart';
import 'package:flutter/material.dart';

class HeroProvider with ChangeNotifier {
  HeroModel? _heroModel;
  // Iterable<Data>? _heroType;
  BootstrapModel? _bootstrapModel;

  void setHero(HeroModel model) {
    this._heroModel = model;
    notifyListeners();
  }

  void setBootstrap(BootstrapModel model) {
    this._bootstrapModel = model;
    notifyListeners();
  }

  // resultType(Iterable<Data> model, int value) {
  //   if (value == 0) {
  //     this._heroType = model;
  //   } else {
  //     this._heroType = model.where((e) => e.sortId == value);
  //   }
  //   notifyListeners();
  // }

  HeroModel? get heroModel => _heroModel;
  BootstrapModel? get bootstrapModel => this._bootstrapModel;
  // Iterable<Data>? get heroType => this._heroType;
}

enum ApexType { assault, defense, support, scout }
