import 'package:apex_wechat/pages/encyclopedia/control.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:provider/provider.dart';

typedef ListClass = List<String>;

const ListClass ApexType = [
  '全部',
  '突击型',
  '防御型',
  '支援型',
  '侦擦型',
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
    _getData();
  }

  _getData() {
    EncyclopediaControl.gethero(onsuccess: (value) {}, onError: (value) {});
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        appBar: MPAppBar(
          context: context,
          title: Text(widget.title), // 标题
          backgroundColor: Color(0xffeeeeee),
          appBarHeight: 56, // AppBar 高度
        ),
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
                  children: [
                    ApexTabbarView(
                      isDivider: false,
                      tab: ApexType,
                      children: [
                        ApexHeroListView(
                          type: 0,
                        ),
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
                    ),
                    Text('枪械'),
                    Text('地图'),
                  ],
                ),
              ],
            ))));
  }
}

class ApexHeroListView extends StatelessWidget {
  final int type;
  const ApexHeroListView({Key? key, this.type = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      key: ValueKey(type),
      builder: (BuildContext context, HeroProvider state, Widget? child) {
        return Container(
          padding: EdgeInsets.only(bottom: 56, top: 10, left: 10, right: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: (type != 0
                    ? (state.heroModel == null ? [] : state.heroModel!.data)
                        .where((element) => element.sortId == type)
                    : (state.heroModel == null ? [] : state.heroModel!.data))
                .map<Widget>((e) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.network(
                        e.heroImg,
                        fit: BoxFit.cover,
                      ),
                      height: 147,
                      width: MediaQuery.of(currentContext!).size.width / 3.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(e.heroName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff585858),
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
