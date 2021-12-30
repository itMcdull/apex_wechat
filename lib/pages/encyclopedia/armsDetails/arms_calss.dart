import 'package:apex_wechat/model/arms_class_model.dart';
import 'package:apex_wechat/pages/encyclopedia/armsDetails/arms_details.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';

class ArmsClassPage extends StatefulWidget {
  final int id;
  final String name;
  ArmsClassPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _ArmsClassPageState createState() => _ArmsClassPageState();
}

class _ArmsClassPageState extends State<ArmsClassPage> {
  ArmsClassModel? _armsClassModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Call.dispatch('/wiki/arms/sorts/${widget.id}').then((result) {
        if (result['code'] == 0) {
          _armsClassModel = ArmsClassModel.fromJson(result);
          if (!mounted) return;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        name: '枪械类型',
        backgroundColor: Color(0xffeeeeee),
        body: _armsClassModel == null
            ? Container(
                width: 120,
                height: 120,
                child: Image.asset('assets/images/loading.svg'),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView(children: [
                  _banners(widget.name),
                  Column(
                    children: _armsClassModel!.data.items.map<Widget>((e) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ArmsDetailsPage(
                                id: e.id,
                                name: e.armsName,
                              ));
                        },
                        child: Container(
                            height: 90,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffabbaab),
                                  // Color(0xff6dd5fa),
                                  Color(0xffffffff),
                                ]),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/logo_icon.png'),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.armsName,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          _armsDetailsItem(
                                              title: "弹容",
                                              value: e.quickCapacity),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _armsDetailsItem(
                                              title: "射速",
                                              value: e.quickShotSpeed),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          _armsDetailsItem(
                                              title: "爆头倍率",
                                              value: e.quickShotHeadTimes),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          _armsDetailsItem(
                                              title: "秒伤", value: e.quickDps),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  height: 40,
                                  child: Image.network(
                                    e.armsImg,
                                  ),
                                ),
                              ],
                            )),
                      );
                    }).toList(),
                  ),
                  _banners(widget.name + '默认数据'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 24,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '此表格内所有数据来自游戏资源拆包',
                      style: TextStyle(
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      '游戏中如果枪械没有单独设计数据，则会使用下表中的数据。',
                      softWrap: true,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xfff8f8f8),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('数据名')),
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text('值'),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('备注'),
                        ))
                      ],
                    ),
                  ),
                  Column(
                    children: _armsClassModel!.data.params.map<Widget>((e) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffeeeeee), width: 1)),
                          color: Colors.white,
                        ),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(e.name),
                            ),
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text(e.value),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(e.remark),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ]),
              ));
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

  _armsDetailsItem({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          '$title：',
          style: TextStyle(
            color: Color(0xff666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 12,
              foreground: Paint()
                ..shader = LinearGradient(colors: [
                  Colors.red,
                  Colors.black,
                ]).createShader(Rect.fromLTWH(0, 0, 150, 0))),
        ),
      ],
    );
  }
}
