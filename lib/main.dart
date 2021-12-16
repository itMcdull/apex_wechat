import 'package:apex_wechat/pages/navigation/bottom_bar_page.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

void main() {
  runApp(MyApp());
  MPCore().connectToHostChannel();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MPApp(
      title: 'APEX',
      navigatorKey: Instances.navigatorKey,
      routes: {
        '/': (context) => MainTabViewPage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
    );
  }
}
