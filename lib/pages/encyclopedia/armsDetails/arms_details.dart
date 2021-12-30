import 'package:apex_wechat/model/arms_details.dart';
import 'package:apex_wechat/pages/encyclopedia/armsDetails/widgets/arms_skin.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class ArmsDetailsPage extends StatefulWidget {
  final String name;
  final int id;
  ArmsDetailsPage({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  _ArmsDetailsPageState createState() => _ArmsDetailsPageState();
}

class _ArmsDetailsPageState extends State<ArmsDetailsPage> {
  ArmsDetailsModel? _armsDetailsModel;
  List<Map<String, dynamic>> _list = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Call.dispatch('/wiki/arms/${widget.id}').then((result) {
        if (result['code'] == 0) {
          _armsDetailsModel = ArmsDetailsModel.fromJson(result);
          _list = [
            {'title': '距离', 'value': _armsDetailsModel!.data.distance},
            {'title': '精准度', 'value': _armsDetailsModel!.data.accuracy},
            {'title': '射速', 'value': _armsDetailsModel!.data.shotSpeed},
            {'title': '头部伤害', 'value': _armsDetailsModel!.data.headDamage},
            {'title': '身体伤害', 'value': _armsDetailsModel!.data.bodyDamage},
            {'title': '四肢伤害', 'value': _armsDetailsModel!.data.limbDamage},
            {'title': '秒伤', 'value': _armsDetailsModel!.data.dps},
            {'title': '弹道速度', 'value': _armsDetailsModel!.data.trajectorySpeed},
            {
              'title': '战术换弹',
              'value': _armsDetailsModel!.data.bulletChangeSpeed
            },
            {
              'title': '完整换弹',
              'value': _armsDetailsModel!.data.bulletFullChangeSpeed
            },
            {'title': '弹夹容量', 'value': _armsDetailsModel!.data.capacity},
            {'title': '竞技场价格', 'value': _armsDetailsModel!.data.arenaPrice},
          ];
          if (!mounted) return;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: widget.name,
      backgroundColor: Color(0xffeeeeee),
      body: _armsDetailsModel == null
          ? Container(
              width: 120,
              height: 120,
              child: Image.asset('assets/images/loading.svg'),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  // _banners(widget.name),
                  Container(
                      height: 140,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xffabbaab),
                          Color(0xffffffff),
                        ]),
                      ),
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _armsDetailsModel!.data.armsName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _armsDetailsModel!.data.armsType,
                                  style: TextStyle(
                                      color: Color(0xffeeeeee), fontSize: 14),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _armsDetailsModel!.data.armsShotType,
                                  style: TextStyle(
                                      color: Color(0xffeeeeee), fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 40,
                            child: Image.network(
                              _armsDetailsModel!.data.armsImg,
                            ),
                          ),
                        ],
                      )),

                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: _list
                          .map<Widget>(
                            (e) => Container(
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffeeeeee), width: 1)),
                                // gradient: LinearGradient(colors: [
                                //   Color(0xffabbaab),
                                //   Color(0xffffffff),
                                // ]),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e['title']),
                                  Text(e['value']),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _banners('配件'),
                  Container(
                    child: Column(
                      children: _attrItem(type: 3),
                    ),
                  ),
                  _banners('瞄准镜'),
                  Container(
                    child: Column(
                      children: _attrItem(type: 4),
                    ),
                  ),
                  _banners('皮肤'),
                  ArmsWidgetPage(skin: _armsDetailsModel!.data.attrs),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
    );
  }

  _attrItem({required int type}) {
    List<Widget> item = [];
    List<Attrs> list = _armsDetailsModel!.data.attrs
        .where((element) => element.type == type)
        .toList();
    for (var i = 0; i < list.length; i++) {
      for (var k = 0; k < list[i].levels.length; k++) {
        for (var j = 0; j < list[i].levels[k].items.length; j++) {
          item.add(Container(
            height: 40,
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.network(
                    list[i].levels[k].items[j].attrImg,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(list[i].levels[k].items[j].attrName)
              ],
            ),
          ));
        }
      }
    }
    return item;
  }

  _banners(String name) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        height: 40,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                'assets/images/logo_icon.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }
}
