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
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ApexTabbarView(
                  tab: ['传奇', '枪械', '地图'],
                  children: [
                    Container(),
                    Center(
                      child: Text('2'),
                    ),
                    Center(
                      child: Text('3'),
                    ),
                  ],
                )
              ],
            ))));
  }
}
