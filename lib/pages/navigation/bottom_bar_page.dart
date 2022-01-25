import 'package:apex_wechat/pages/encyclopedia/index.dart';
import 'package:apex_wechat/pages/headlines/index.dart';
import 'package:apex_wechat/pages/mine/index.dart';
import 'package:apex_wechat/pages/shop/index.dart';
import 'package:apex_wechat/utils/instances.dart';
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
    "icon": 'assets/images/baike.svg',
    "icon_active": 'assets/images/baike_active.svg'
  },
  {
    "title": '商店',
    'page': ShopPage(
      title: '商店',
    ),
    "icon": 'assets/images/shandian.svg',
    "icon_active": 'assets/images/shandian_active.svg'
  },
  {
    "title": '头条',
    "page": HeadlinesPage(
      title: '头条',
    ),
    "icon": 'assets/images/zixun.svg',
    "icon_active": 'assets/images/zixun_active.svg'
  },
  {
    "title": '我的',
    "page": MinePage(
      title: '我的',
    ),
    "icon": 'assets/images/zixun.svg',
    "icon_active": 'assets/images/zixun_active.svg'
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
          activeIcon: _tabBarData[i]['icon_active'],
          title: _tabBarData[i]['title']));
    }
    return item;
  }

  /// [单个item]
  MPMainTabItem bottomBarItem(
      {required String title,
      required Widget page,
      required String icon,
      required String activeIcon}) {
    return MPMainTabItem(
      activeTabWidget: renderIcon(
          icon: icon, title: title, actived: true, activeIcon: activeIcon),
      inactiveTabWidget: renderIcon(
          icon: icon, title: title, actived: false, activeIcon: activeIcon),
      builder: (context) => page,
    );
  }

  /// [底部图标激活]
  Widget renderIcon(
      {required String icon,
      required String title,
      required bool actived,
      required String activeIcon}) {
    return Container(
        width: MediaQuery.of(currentContext!).size.width / _tabBarData.length,
        color: Color(0xffeeeeee),
        height: 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MPIcon(icon, color: actived ? Colors.blue : Colors.grey),
            SizedBox(
              width: 15,
              height: 15,
              child: Image.asset(
                actived ? activeIcon : icon,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: actived ? Color(0xff1296db) : Colors.black,
              ),
            ),
          ],
        ));
  }
}
