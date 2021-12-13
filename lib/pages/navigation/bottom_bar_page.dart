import 'package:apex_wechat/pages/encyclopedia/index.dart';
import 'package:apex_wechat/pages/headlines/index.dart';
import 'package:apex_wechat/pages/mine/index.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpkit/mpkit.dart';
import 'package:mpcore/mpcore.dart';

enum TabViewPageValue { ency, head, mine }
List<Map<String, dynamic>> _tabBarData = [
  {
    "title": '百科',
    'page': EncyclopediaPage(
      title: '百科',
    ),
    "icon": MaterialIcons.home
  },
  {
    "title": '头条',
    "page": HeadlinesPage(
      title: '头条',
    ),
    "icon": MaterialIcons.new_label
  },
  {
    "title": '我的',
    "page": MinePage(
      title: '我的',
    ),
    "icon": MaterialIcons.access_time_filled_sharp
  },
];

class MainTabViewPage extends StatefulWidget {
  MainTabViewPage({Key? key}) : super(key: key);

  @override
  _MainTabViewPageState createState() => _MainTabViewPageState();
}

class _MainTabViewPageState extends State<MainTabViewPage> {
  @override
  Widget build(BuildContext context) {
    return MPMainTabView(
      tabs: _renderItem(),
    );
  }

  _renderItem() {
    List<MPMainTabItem> item = [];
    for (var i = 0; i < _tabBarData.length; i++) {
      item.add(bottomBarItem(
          icon: _tabBarData[i]['icon'],
          page: _tabBarData[i]['page'],
          title: _tabBarData[i]['title']));
    }
    return item;
  }

  /// [单个item]
  MPMainTabItem bottomBarItem(
      {required String title, required Widget page, required String icon}) {
    return MPMainTabItem(
      activeTabWidget: renderIcon(
        icon: icon,
        title: title,
        actived: true,
      ),
      inactiveTabWidget: renderIcon(
        icon: icon,
        title: title,
        actived: false,
      ),
      builder: (context) => page,
    );
  }

  /// [底部图标激活]
  Widget renderIcon({
    required String icon,
    required String title,
    required bool actived,
  }) {
    return Container(
        width: MediaQuery.of(context).size.width / 3,
        color: Color(0xffeeeeee),
        height: 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MPIcon(icon, color: actived ? Colors.blue : Colors.grey),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: actived ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ));
  }
}
