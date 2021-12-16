import 'package:apex_wechat/pages/navigation/bottom_bar_page.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  initStore();
  runApp(MyApp());
  MPCore().connectToHostChannel();
}

Future<void> initStore() async {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MPApp(
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
