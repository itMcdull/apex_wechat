import 'package:apex_wechat/model/headlines_model.dart';
import 'package:apex_wechat/provider/news_provider.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:provider/provider.dart';

class HeadlinesControl {
  /// 获取头条数据列表
  static getData() async {
    await Call.dispatch('/article/latest').then((result) {
      if (result['code'] == 0) {
        Provider.of<NewsProvider>(currentContext!, listen: false)
            .setHero(HeadlinesModel.fromJson(result));
      }
    });
  }
}
