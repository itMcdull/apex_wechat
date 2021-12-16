import 'package:apex_wechat/model/hero_model.dart';
import 'package:apex_wechat/utils/dio.dart';

class EncyclopediaControl {
  static gethreo(
      {required Function(HeroModel value) onsuccess,
      required Function(HeroModel value) onError,
      String value = '0'}) async {
    await Call.dispatch('/wiki/hero/sort/$value').then((result) {
      if (result['code'] == 0) {
        onsuccess(HeroModel.fromJson(result));
      } else {
        onError(HeroModel.fromJson(result));
      }
    });
  }
}
