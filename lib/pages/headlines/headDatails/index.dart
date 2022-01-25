import 'package:apex_wechat/model/commit_model.dart';
import 'package:apex_wechat/model/headlines_details_model.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:apex_wechat/utils/relative_dareformat.dart';
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
  CommitModel? _commitModel;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Call.dispatch("/article/${widget.id}").then((result) {
        if (result['code'] == 0) {
          _headLinesDetailsModel = HeadLinesDetailsModel.fromJson(result);
          if (!mounted) return;
          setState(() {});
        }
      });
      print(MediaQuery.of(context).viewInsets.bottom);
      Call.dispatch("/comment/${widget.id}/latest").then((result) {
        if (result['code'] == 0) {
          _commitModel = CommitModel.fromJson(result);
          if (!mounted) return;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: '详情',
      bottomBar: _headLinesDetailsModel == null || _commitModel == null
          ? SizedBox()
          : Container(
              height: 80 + MediaQuery.of(context).viewInsets.bottom,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Color(0xffeeeeee), width: 1))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                height: 24,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: MPEditableText(
                                    controller: editingController,
                                    focusNode: FocusNode(),
                                    placeholderStyle: TextStyle(fontSize: 11),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    placeholder: '我也来说两句',
                                  ),
                                ))),
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MPIcon(
                                MaterialIcons.message_sharp,
                                color: Color(0xffe3a654),
                                size: 16,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(_headLinesDetailsModel
                                          ?.data.readCount
                                          .toString() ??
                                      '0')),
                              MPIcon(
                                MaterialIcons.thumb_up_outlined,
                                size: 16,
                                color: Color(0xffaaaaaa),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10, left: 5),
                                child: Text(_headLinesDetailsModel
                                        ?.data.likeCount
                                        .toString() ??
                                    '0'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ))
                ],
              )),
      body: _headLinesDetailsModel == null || _commitModel == null
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
                                      "发布于" +
                                          RelativeDateFormat.format(
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
                  Column(
                    children: _commitModel!.data.lists
                        .map<Widget>((e) => Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffeeeeee), width: 1))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              e.publisherHeadImg ?? '',
                                              // fit: type == 3 ? BoxFit.fill : BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                e.publisherName ?? '',
                                                style: TextStyle(
                                                    color: Color(0xff333333)),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  90,
                                              child: Text(
                                                e.comment,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                RelativeDateFormat.format(
                                                    e.createTime),
                                                style: TextStyle(
                                                    color: Color(0xff333333)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(right: 3),
                                          child: Text(
                                            e.likeCount.toString(),
                                            style: TextStyle(
                                                color: Color(0xffaaaaaa),
                                                fontSize: 10),
                                          )),
                                      MPIcon(
                                        MaterialIcons.thumb_up_outlined,
                                        size: 18,
                                        color: e.liked
                                            ? Colors.redAccent
                                            : Color(0xffaaaaaa),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
