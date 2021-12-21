import 'package:apex_wechat/pages/encyclopedia/arms_page.dart';
import 'package:apex_wechat/pages/encyclopedia/control.dart';
import 'package:apex_wechat/pages/encyclopedia/legend_page.dart';
import 'package:apex_wechat/pages/encyclopedia/map_page.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

typedef ListClass = List<String>;
typedef JsonClass = List<Map<String, dynamic>>;

const JsonClass ApexType = [
  {'title': '全部', 'id': 0},
  {'title': '突击型', 'id': 1},
  {'title': '防御型', 'id': 4},
  {'title': '支援型', 'id': 3},
  {'title': '侦擦型', 'id': 2},
];
const JsonClass MaoType = [
  {'title': '大逃杀', 'id': 1},
  {'title': '竞技场', 'id': 2},
];
const JsonClass ArmsType = [
  {'title': '全部', "id": 0},
  {'title': '轻型', "id": 2},
  {'title': '重型', "id": 3},
  {'title': '能量', "id": 5},
  {'title': '霰弹', "id": 4},
  {'title': '弓', "id": 1},
  {'title': '空投', "id": 7},
  {'title': '狙击', "id": 6},
];
const ListClass TabPageClass = ['传奇', '枪械', '地图'];

class EncyclopediaPage extends StatefulWidget {
  final String title;
  EncyclopediaPage({Key? key, required this.title}) : super(key: key);

  @override
  _EncyclopediaPageState createState() => _EncyclopediaPageState();
}

class _EncyclopediaPageState extends State<EncyclopediaPage> {
  @override
  void initState() {
    super.initState();
    // _getHeroData();
    _getBootstrapData();
  }

  // _getHeroData() {
  //   EncyclopediaControl.gethero();
  // }

  // _getArmsData() {
  //   EncyclopediaControl.getArms();
  // }

  _getBootstrapData() {
    EncyclopediaControl.bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        name: '百科',
        body: Container(
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: MediaQuery.of(currentContext!).size.height / 3.3,
                  color: Colors.red,
                  width: MediaQuery.of(currentContext!).size.width,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ApexTabbarView(
                  key: ValueKey('all'),
                  tab: TabPageClass,
                  onTap: (index) {},
                  children: [_heroWidget, _armsWidget, _mapWidget],
                ),
              ],
            ))));
  }

  ///[传奇]
  get _heroWidget => ApexTabbarView(
        isDivider: false,
        tab: ApexType.map<String>((e) => e['title']).toList(),
        key: ValueKey('hero'),
        children: ApexType.map((e) => ApexHeroListView(
              type: e['id'],
            )).toList(),
      );

  ///[枪械]
  get _armsWidget => ApexTabbarView(
        key: ValueKey('arms'),
        isDivider: false,
        tab: ArmsType.map<String>((e) => e['title']).toList(),
        children: ArmsType.map((e) => ApexArmsListView(
              type: e['id'],
            )).toList(),
      );

  ///[地图]
  get _mapWidget => ApexTabbarView(
        key: ValueKey('map'),
        isDivider: false,
        tab: MaoType.map<String>((e) => e['title']).toList(),
        children: MaoType.map((e) => ApexMapListView(
              type: e['id'],
            )).toList(),
      );
}
