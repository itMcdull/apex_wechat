import 'package:apex_wechat/pages/navigation/bottom_bar_page.dart';
import 'package:apex_wechat/provider/arms_provider.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/provider/news_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  initStore();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => HeroProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ArmsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NewsProvider(),
      ),
    ],
    child: MyApp(),
  ));
  MPCore().connectToHostChannel();
}

Future<void> initStore() async {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMPApp(
      title: 'APEX',
      color: Colors.blue,
      navigatorKey: Instances.navigatorKey,
      routes: {
        '/': (context) => MainTabViewPage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
    );
  }
}
