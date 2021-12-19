import 'package:apex_wechat/model/hero_model.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:provider/provider.dart';

class EncyclopediaControl {
  static gethero(
      {required Function(HeroModel value) onsuccess,
      required Function(HeroModel value) onError,
      String value = '0'}) async {
    await Call.dispatch('/wiki/hero/sort/$value').then((result) {
      print(result['data']);
      if (result['code'] == 0) {
        Provider.of<HeroProvider>(currentContext!, listen: false)
            .setHero(HeroModel.fromJson(result));
        onsuccess(HeroModel.fromJson(result));
      } else {
        onError(HeroModel.fromJson(result));
      }
    });
  }
}
