import 'package:apex_wechat/model/hero_details_model.dart';
import 'package:apex_wechat/pages/encyclopedia/heroDetails/control.dart';
import 'package:apex_wechat/pages/encyclopedia/heroDetails/widgets/frame_page.dart';
import 'package:apex_wechat/pages/encyclopedia/heroDetails/widgets/skin_page.dart';
import 'package:apex_wechat/widgets/apex_tabbar.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:simple_html_css/simple_html_css.dart';

class HeroDetails extends StatefulWidget {
  final int id;
  final String name;
  HeroDetails({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  HeroDetailsModel? _heroDetailsModel;
  List<Map<String, dynamic>> _baseInfo = [];
  List<Levels> _skinList = [];
  List<Levels> _frameList = [];
  List<Levels> _parachute = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    HeroDetailsControl.gethero(
        value: widget.id,
        onSuccess: (value) {
          _heroDetailsModel = value;
          List<Levels> jumping = [];
          List<Levels> ults = [];
          _baseInfo = [
            {'title': '姓名', 'value': _heroDetailsModel!.data.realName},
            {'title': '性别', 'value': _sexFilter(_heroDetailsModel!.data.sex)},
            {'title': '绰号', 'value': _heroDetailsModel!.data.nickName},
            {'title': '年龄', 'value': _heroDetailsModel!.data.age.toString()},
            {'title': '身高', 'value': _heroDetailsModel!.data.height},
            {'title': '体重', 'value': _heroDetailsModel!.data.weight},
            {'title': '家园', 'value': _heroDetailsModel!.data.homeland},
            {'title': '移速', 'value': _heroDetailsModel!.data.moveSpeed},
          ];
          for (var i = 0; i < _heroDetailsModel!.data.attrs.length; i++) {
            if (_heroDetailsModel!.data.attrs[i].type == 1) {
              _skinList = _heroDetailsModel!.data.attrs[i].levels;
            } else if (_heroDetailsModel!.data.attrs[i].type == 3) {
              _frameList = _heroDetailsModel!.data.attrs[i].levels;
            }
            if (_heroDetailsModel!.data.attrs[i].type == 4) {
              jumping = _heroDetailsModel!.data.attrs[i].levels;
            }
            if (_heroDetailsModel!.data.attrs[i].type == 5) {
              ults = _heroDetailsModel!.data.attrs[i].levels;
            }
          }

          _parachute.addAll(jumping);
          _parachute.addAll(ults);
          if (!mounted) return;
          setState(() {});
        });
  }

  _sexFilter(value) {
    switch (value) {
      case 0:
        return '女';
      case 1:
        return '男';
      default:
        return '未知';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        name: widget.name,
        backgroundColor: Color(0xffeeeeee),
        body: Container(
          padding: EdgeInsets.only(bottom: 56, left: 10, right: 10, top: 10),
          child: _heroDetailsModel == null
              ? Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/loading.svg'),
                  ),
                )
              : ListView(
                  children: [
                    _heroVideo,
                    _herodescribe,
                    _banners('基本信息'),
                    _heroInfo,
                    _banners('座右铭'),
                    _motto,
                    _banners('英雄技能'),
                    _heroSkill,
                    _banners('皮肤'),
                    SkinWidgetPage(skin: _skinList),
                    _banners('边框'),
                    SkinWidgetPage(skin: _frameList),
                    _banners('跳伞动作/终结技'),
                    JumpWidgetPage(skin: _parachute),
                    _banners('战略'),
                    _strategy,
                    _banners('历史更新'),
                    _historyUpdate,
                  ],
                ),
        ));
  }

  /// 战略
  Widget get _strategy => Container(
        padding: EdgeInsets.all(10),
        child: Builder(
          builder: (context) {
            return RichText(
              text: HTML.toTextSpan(
                context,
                _heroDetailsModel!.data.strategy,
                defaultTextStyle:
                    TextStyle(color: Color(0xff585858), fontSize: 12),
              ),
            );
          },
        ),
      );

  /// 战略
  Widget get _historyUpdate => Container(
        padding: EdgeInsets.all(10),
        child: Builder(
          builder: (context) {
            return RichText(
              text: HTML.toTextSpan(
                context,
                _heroDetailsModel!.data.historyUpdate,
                defaultTextStyle:
                    TextStyle(color: Color(0xff585858), fontSize: 12),
              ),
            );
          },
        ),
      );

  /// 座右铭
  Widget get _motto => Container(
      height: 40,
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          _heroDetailsModel!.data.motto,
          style: TextStyle(color: Color(0xff585858), fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ));

  /// 英雄技能
  Widget get _heroSkill => ApexTabbarView(
      isImage: true,
      key: ValueKey('jineng'),
      tab: _heroDetailsModel!.data.skills
          .map<String>((e) => e.skillImg)
          .toList(),
      children: _heroDetailsModel!.data.skills
          .map<Widget>((e) => Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.skillName, style: TextStyle(fontSize: 14)),
                    SizedBox(
                      height: 3,
                    ),
                    Text(e.skillTitle, style: TextStyle(fontSize: 12)),
                    SizedBox(
                      height: 3,
                    ),
                    Builder(
                      builder: (context) {
                        return RichText(
                          text: HTML.toTextSpan(
                            context,
                            e.skillContent,
                            defaultTextStyle: TextStyle(
                              color: Color(0xff585858),
                              // etc etc
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ))
          .toList());

  /// 英雄信息
  Widget get _heroInfo => Container(
        child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: _baseInfo
                .map<Widget>((e) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      height: 60,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e['value'],
                            maxLines: 1,
                            style: TextStyle(
                                color: Color(0xff585858),
                                fontSize: e['value'].length > 6 ? 10 : 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            e['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14
                                // etc etc
                                ),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 4.8,
                    ))
                .toList()),
      );

  /// 广告横幅
  Widget _banners(title) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(8))),
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
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ));
  }

  /// 背景故事
  Widget get _herodescribe => Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
                height: 40,
                padding: EdgeInsets.all(10),
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
                      '背景故事',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xffeeeeee), width: 2))),
              child: Builder(
                builder: (context) {
                  return RichText(
                    text: HTML.toTextSpan(
                      context,
                      _heroDetailsModel!.data.backStory,
                      defaultTextStyle: TextStyle(
                        color: Color(0xff585858),
                        fontSize: 10,
                        // etc etc
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );

  /// 视频
  Widget get _heroVideo => Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: MPVideoView(
          url: _heroDetailsModel!.data.heroVideo,
        ),
      ));
}
