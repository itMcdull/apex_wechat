import 'dart:convert';

import 'package:apex_wechat/model/headlines_details_model.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/time_format.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:simple_html_css/simple_html_css.dart';

class HeadlinesDetailsPage extends StatefulWidget {
  final int id;
  HeadlinesDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _HeadlinesDetailsPageState createState() => _HeadlinesDetailsPageState();
}

class _HeadlinesDetailsPageState extends State<HeadlinesDetailsPage> {
  HeadLinesDetailsModel? _headLinesDetailsModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Call.dispatch("/article/${widget.id}").then((result) {
        if (result['code'] == 0) {
          _headLinesDetailsModel = HeadLinesDetailsModel.fromJson(result);
          print(_headLinesDetailsModel!.data.content);
          if (!mounted) return;
          setState(() {});
        }
      });
      Call.dispatch("/comment/${widget.id}/latest").then((result) {
        if (result['code'] == 0) {
          print(json.encode(result));
          // _headLinesDetailsModel = HeadLinesDetailsModel.fromJson(result);
          // print(_headLinesDetailsModel!.data.content);
          // if (!mounted) return;
          // setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: '详情',
      body: _headLinesDetailsModel == null
          ? Center(
              child: Container(
                width: 120,
                height: 120,
                child: Image.asset('assets/images/loading.svg'),
              ),
            )
          : Container(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxHeight: 300, minHeight: 200),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            _headLinesDetailsModel!.data.coverImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          _headLinesDetailsModel!.data.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: Image.network(_headLinesDetailsModel!
                                    .data.publisherHeadImg),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      _headLinesDetailsModel!
                                          .data.publisherName,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff000000))),
                                  Text(
                                      TimeFormat.dateFormat(
                                          _headLinesDetailsModel!
                                              .data.createTime),
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff969696))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Builder(
                            builder: (context) {
                              return RichText(
                                text: HTML.toTextSpan(
                                  context,
                                  _headLinesDetailsModel!.data.content,
                                  defaultTextStyle: TextStyle(
                                      color: Color(0xff585858), fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 80,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '全部评论(${_headLinesDetailsModel!.data.commentCount ?? "0"})',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Color(0xffeeeeee),
                    child: Text('全部评论',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff969696),
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
