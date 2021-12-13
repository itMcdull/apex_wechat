import 'package:apex_wechat/pages/navigation/bottom_bar_page.dart';
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
      title: 'MPFlutter Demo',
      color: Colors.blue,
      routes: {
        '/': (context) => MainTabViewPage(),
      },
      navigatorObservers: [MPCore.getNavigationObserver()],
    );
  }
}
