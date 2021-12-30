import 'dart:convert';

import 'package:apex_wechat/model/map_details_model.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:simple_html_css/simple_html_css.dart';

class MapDetailsPage extends StatefulWidget {
  final int id;
  final String name;
  MapDetailsPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _MapDetailsPageState createState() => _MapDetailsPageState();
}

class _MapDetailsPageState extends State<MapDetailsPage> {
  MapDetailsModel? _mapDetailsModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Call.dispatch("/wiki/map/${widget.id}").then((result) {
        print(json.encode(result));
        if (result['code'] == 0) {
          _mapDetailsModel = MapDetailsModel.fromJson(result);
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
        body: _mapDetailsModel == null
            ? Center(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('assets/images/loading.svg'),
                ),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    _banners(_mapDetailsModel!.data.mapName),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Builder(
                        builder: (context) {
                          return RichText(
                            text: HTML.toTextSpan(
                              context,
                              _mapDetailsModel!.data.mapDesc,
                              defaultTextStyle: TextStyle(
                                  color: Color(0xff585858), fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      constraints:
                          BoxConstraints(maxHeight: 300, minHeight: 200),
                      child: Image.network(_mapDetailsModel!.data.mapImg),
                    ),
                    _banners('历史更新'),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Builder(
                        builder: (context) {
                          return RichText(
                            text: HTML.toTextSpan(
                              context,
                              _mapDetailsModel!.data.mapHistory,
                              defaultTextStyle: TextStyle(
                                  color: Color(0xff585858), fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    _banners('历史地图版本'),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Builder(
                        builder: (context) {
                          return RichText(
                            text: HTML.toTextSpan(
                              context,
                              _mapDetailsModel!.data.mapHistoryVersion,
                              defaultTextStyle: TextStyle(
                                  color: Color(0xff585858), fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ));
  }

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
}
