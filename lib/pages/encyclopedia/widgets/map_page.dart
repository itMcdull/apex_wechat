import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/pages/encyclopedia/mapDetails/index.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ApexMapListView extends StatelessWidget {
  final int type;
  const ApexMapListView({Key? key, this.type = 0}) : super(key: key);

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
                  list: state.bootstrapModel?.data.map.groups ?? null,
                  id: type)),
        );
      },
    );
  }

  _renderItem({required List<BootMapGroups>? list, int id = 0}) {
    List<Widget> item = [];
    if (list == null) {
      return [
        Center(
          child: Container(
            width: 120,
            height: 120,
            child: Image.asset('assets/images/loading.svg'),
          ),
        )
      ];
    }
    for (var i = 0; i < list.length; i++) {
      for (var k = 0; k < list[i].items.length; k++) {
        if (id == list[i].type) {
          item.add(GestureDetector(
            onTap: () {
              Get.to(() => MapDetailsPage(
                    id: list[i].items[k].id,
                    name: list[i].items[k].mapName,
                  ));
            },
            child: Container(
              height: 140,
              // decoration: BoxDecoration(
              //     color: Color(0xffeeeeee),
              //     borderRadius: BorderRadius.all(Radius.circular(10))),
              width: MediaQuery.of(currentContext!).size.width / 2.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(currentContext!).size.width / 2.3,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(12),
                      //     topRight: Radius.circular(12)),
                      child: Image.network(
                        list[i].items[k].mapImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(list[i].items[k].mapName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff585858),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ));
        }
      }
    }
    return item;
  }
}
