import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_miniprogram_api/wechat_mini_program/map_view.dart';

class JumpWidgetPage extends StatefulWidget {
  final List skin;
  JumpWidgetPage({Key? key, required this.skin}) : super(key: key);

  @override
  _JumpWidgetPageState createState() => _JumpWidgetPageState();
}

class _JumpWidgetPageState extends State<JumpWidgetPage> {
  List<Map<String, dynamic>> _jumpList = [
    {'title': '终结技', 'type': 2},
    {'title': '跳伞动作', 'type': 0},
  ];
  @override
  Widget build(BuildContext context) {
    return ApexTabbarView(
        key: ValueKey('jumping'),
        tab: _jumpList.map<String>((e) => e['title']).toList(),
        children:
            _jumpList.map<Widget>((e) => _renderSkilItem(e['type'])).toList());
  }

  _renderSkilItem(int type) {
    List<Widget> item = [];
    for (var i = 0; i < widget.skin.length; i++) {
      for (var k = 0; k < widget.skin[i].items.length; k++) {
        if (widget.skin[i].items[k].level == type) {
          item.add(UnconstrainedBox(
              child: GestureDetector(
            onTap: () {
              UniversalMiniProgramApi.uni.previewImage(PreviewImageOption(
                showmenu: true,
                urls: [widget.skin[i].items[k].attrImg],
              ));
            },
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width / 1.5,
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.skin[i].items[k].attrImg,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  widget.skin[i].items[k].attrName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                child: Text(
                                  widget.skin[i].items[k].attrDesc +
                                      '' +
                                      widget.skin[i].items[k].attrFeature,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          _priceRender(
                              coin: widget.skin[i].items[k].coin,
                              metal: widget.skin[i].items[k].metal,
                              token: widget.skin[i].items[k].token)
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
    return Container(
      height: 250,
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
