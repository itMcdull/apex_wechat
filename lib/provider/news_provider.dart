import 'package:apex_wechat/model/headlines_model.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  HeadlinesModel? _headlinesModel;

  void setHero(HeadlinesModel model) {
    this._headlinesModel = model;
    notifyListeners();
  }

  HeadlinesModel? get headlinesModel => this._headlinesModel;
}

enum ApexType { assault, defense, support, scout }
