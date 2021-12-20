import 'dart:convert';

import 'package:apex_wechat/model/arms_model.dart';
import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/model/hero_model.dart';
import 'package:apex_wechat/provider/arms_provider.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:provider/provider.dart';

class EncyclopediaControl {
  static gethero({String value = '0'}) async {
    await Call.dispatch('/wiki/hero/sort/$value').then((result) {
      if (result['code'] == 0) {
        Provider.of<HeroProvider>(currentContext!, listen: false)
            .setHero(HeroModel.fromJson(result));
      }
    });
  }

  static getArms() async {
    await Call.dispatch('/wiki/arms/sorts').then((result) {
      if (result['code'] == 0) {
        Future.delayed(Duration(seconds: 3), () {
          Provider.of<ArmsProvider>(currentContext!, listen: false)
              .setHero(ArmsModel.fromJson(result));
        });
      } else {}
    });
  }

  static armsTopics() async {
    await Call.dispatch('/wiki/arms/topics').then((result) {
      if (result['code'] == 0) {
      } else {}
    });
  }

  static bootstrap() async {
    await Call.dispatch('/wiki/bootstrap').then((result) {
      if (result['code'] == 0) {
        BootstrapModel model = BootstrapModel.fromJson(result);
        Provider.of<HeroProvider>(currentContext!, listen: false)
            .setBootstrap(BootstrapModel.fromJson(result));
      } else {}
    });
  }
}
