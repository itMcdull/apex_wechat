import 'package:apex_wechat/pages/encyclopedia/control.dart';
import 'package:apex_wechat/pages/encyclopedia/legend_page.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

typedef ListClass = List<String>;

const ListClass ApexType = [
  '全部',
  '突击型',
  '防御型',
  '支援型',
  '侦擦型',
];
const ListClass ArmsType = [
  '全部',
  '轻型',
  '重型',
  '能量',
  '霰弹',
  '弓',
  '空投',
  '狙击',
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
    _getHeroData();
    _getArmsData();
  }

  _getHeroData() {
    EncyclopediaControl.gethero(onsuccess: (value) {}, onError: (value) {});
  }

  _getArmsData() {
    EncyclopediaControl.getArms();
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
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
                  onTap: (index) {
                    print(index);
                  },
                  children: [
                    _heroWidget,
                    ApexTabbarView(
                      key: ValueKey('arms'),
                      isDivider: false,
                      tab: ArmsType,
                      children: [
                        const Text('text'),
                        Container(
                          child: Image.asset(
                            "assets/images/loading.svg",
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const Text('text'),
                        const Text('text'),
                        const Text('text'),
                        const Text('text'),
                        const Text('text'),
                        const Text('text'),
                      ],
                    ),
                    _heroWidget,
                  ],
                ),
              ],
            ))));
  }

  ///[传奇]
  get _heroWidget => ApexTabbarView(
        isDivider: false,
        tab: ApexType,
        key: ValueKey('hero'),
        children: [
          ApexHeroListView(),
          ApexHeroListView(
            type: 1,
          ),
          ApexHeroListView(
            type: 4,
          ),
          ApexHeroListView(
            type: 3,
          ),
          ApexHeroListView(
            type: 2,
          ),
        ],
      );
}
