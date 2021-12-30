import 'package:apex_wechat/model/arms_details.dart';
import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_miniprogram_api/wechat_mini_program/map_view.dart';

class ArmsWidgetPage extends StatefulWidget {
  final List<Attrs> skin;
  ArmsWidgetPage({Key? key, required this.skin}) : super(key: key);

  @override
  _ArmsWidgetPageState createState() => _ArmsWidgetPageState();
}

class _ArmsWidgetPageState extends State<ArmsWidgetPage> {
  List<Map<String, dynamic>> _attrsList = [
    {'title': '传说', 'type': 2},
    {'title': '史诗', 'type': 3},
    {'title': '稀有', 'type': 4},
    {'title': '普通', 'type': 5},
  ];
  @override
  Widget build(BuildContext context) {
    return ApexTabbarView(
        key: ValueKey('armsPifu'),
        tab: _attrsList.map<String>((e) => e['title']).toList(),
        children:
            _attrsList.map<Widget>((e) => _renderSkilItem(e['type'])).toList());
  }

  _renderSkilItem(int type) {
    List<Widget> item = [];
    List<Attrs> list =
        widget.skin.where((element) => element.type == 1).toList();
    for (var i = 0; i < list.length; i++) {
      for (var k = 0; k < list[i].levels.length; k++) {
        for (var j = 0; j < list[i].levels[k].items.length; j++) {
          if (list[i].levels[k].items[j].level == type) {
            item.add(UnconstrainedBox(
                child: GestureDetector(
              onTap: () {
                UniversalMiniProgramApi.uni.previewImage(PreviewImageOption(
                  showmenu: true,
                  urls: [list[i].levels[k].items[j].attrImg],
                ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/logo.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width / 2.42,
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          list[i].levels[k].items[j].attrImg,
                          // fit: type == 3 ? BoxFit.fill : BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 70,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 20,
                              child: Text(
                                list[i].levels[k].items[j].attrName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                              child: Text(
                                list[i].levels[k].items[j].attrDesc +
                                    '' +
                                    list[i].levels[k].items[j].attrFeature,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            _priceRender(
                                coin: list[i].levels[k].items[j].coin,
                                metal: list[i].levels[k].items[j].metal,
                                token: list[i].levels[k].items[j].token)
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff200122), Color(0xff6f0000)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                      ))
                    ],
                  )),
            )));
          }
        }
      }
    }

    return Container(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: item,
      ),
    );
  }

  Widget _priceRender(
      {required String token, required String metal, required String coin}) {
    String img = 'assets/images/jinbi.svg';
    String value = '';
    Color textColor = Colors.yellow;
    if (token != '') {
      img = 'assets/images/daibi.svg';
      textColor = Colors.deepOrange;
      value = token;
    } else if (metal != '') {
      img = 'assets/images/jinshu.svg';
      textColor = Colors.white;
      value = metal;
    } else {
      value = coin;
    }
    if (token == '' && metal == '' && coin == '') {
      img = '';
    }
    return Container(
      height: 20,
      child: Row(
        children: [
          img != ''
              ? Image.asset(
                  img,
                  width: 18,
                  height: 18,
                )
              : SizedBox(),
          SizedBox(
            width: 5,
          ),
          Text(value,
              style: TextStyle(
                  color: textColor, fontSize: 12, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
