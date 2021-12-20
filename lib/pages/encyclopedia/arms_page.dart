import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ApexArmsListView extends StatelessWidget {
  final int type;
  const ApexArmsListView({Key? key, this.type = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      key: ValueKey(type),
      builder: (BuildContext context, HeroProvider state, Widget? child) {
        return Container(
          padding: EdgeInsets.only(bottom: 56, top: 10, left: 10, right: 10),
          child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              children: _renderItem(
                  list: state.bootstrapModel?.data.arms.groups, id: type)),
        );
      },
    );
  }

  _renderItem({required List<ArmsGroups>? list, int id = 0}) {
    List<Widget> item = [];
    for (var i = 0; i < list!.length; i++) {
      for (var k = 0; k < list[i].items.length; k++) {
        if (id == list[i].id) {
          item.add(Container(
            height: 100,
            width: MediaQuery.of(currentContext!).size.width / 3.5,
            decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Image.network(
                    list[i].items[k].img,
                    width: MediaQuery.of(currentContext!).size.width / 3.5,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  ),
                  height: 50,
                  width: MediaQuery.of(currentContext!).size.width / 3.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(list[i].items[k].name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff585858),
                    )),
              ],
            ),
          ));
        }
      }
    }
    return item;
  }
}
