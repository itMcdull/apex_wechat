import 'package:apex_wechat/pages/headlines/control.dart';
import 'package:apex_wechat/provider/news_provider.dart';
import 'package:apex_wechat/utils/time_format.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:provider/provider.dart';

class HeadlinesPage extends StatefulWidget {
  final String title;
  HeadlinesPage({Key? key, required this.title}) : super(key: key);

  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  @override
  void initState() {
    super.initState();
    HeadlinesControl.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        name: '头条',
        body: Consumer(
          builder: (BuildContext context, NewsProvider state, Widget? child) {
            return Container(
              padding:
                  EdgeInsets.only(bottom: 56, right: 15, top: 15, left: 15),
              child: SingleChildScrollView(
                child: Column(
                    children: (state.headlinesModel?.data.lists ?? [])
                        .map<Widget>((e) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: Color.fromRGBO(221, 0, 0, 1),
                                width: 5))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TimeFormat.dateFormat(e.createTime),
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      MPIcon(
                                        MaterialIcons.message,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        (e.commentCount ?? '0').toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                        Expanded(
                            child: SizedBox(
                          height: 110,
                          child: Image.network(
                            e.coverImg,
                            fit: BoxFit.cover,
                          ),
                        )),
                      ],
                    ),
                  );
                }).toList()),
              ),
            );
          },
        ));
  }
}
