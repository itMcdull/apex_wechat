import 'package:apex_wechat/model/hero_details_model.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:provider/provider.dart';

class HeroDetailsControl {
  ///获取传奇数据列表
  static gethero(
      {int value = 1,
      Function(HeroDetailsModel)? onSuccess,
      Function(bool)? onError}) async {
    await Call.dispatch('/wiki/hero/$value').then((result) {
      if (result['code'] == 0) {
        onSuccess?.call(HeroDetailsModel.fromJson(result));
        Provider.of<HeroProvider>(currentContext!, listen: false)
            .setHeroDetails(HeroDetailsModel.fromJson(result));
      } else {
        onError?.call(false);
      }
    });
  }
}
