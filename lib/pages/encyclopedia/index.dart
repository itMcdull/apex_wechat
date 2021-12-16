import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class EncyclopediaPage extends StatefulWidget {
  final String title;
  EncyclopediaPage({Key? key, required this.title}) : super(key: key);

  @override
  _EncyclopediaPageState createState() => _EncyclopediaPageState();
}

class _EncyclopediaPageState extends State<EncyclopediaPage> {
  MPPageController _pageController = MPPageController();
  MPPageController _apexClassController = MPPageController();
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
                  height: MediaQuery.of(context).size.height / 3.3,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ApexTabbarView(
                  key: ValueKey('all'),
                  controller: _pageController,
                  tab: ['传奇', '枪械', '地图'],
                  children: [
                    ApexTabbarView(
                      isDivider: false,
                      tab: [
                        '全部',
                        '突击型',
                        '防御型',
                        '支援型',
                        '侦擦型',
                      ],
                      children: [
                        Text('全部'),
                        Text('突击型'),
                        Text('防御型'),
                        Text('支援型'),
                        Text('侦擦型'),
                      ],
                      controller: _apexClassController,
                      key: ValueKey('apex'),
                    ),
                    Text('枪械'),
                    Text('地图'),
                  ],
                ),
              ],
            ))));
  }
}
