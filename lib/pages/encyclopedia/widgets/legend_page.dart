import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/pages/heroDetails/index.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ApexHeroListView extends StatelessWidget {
  final int type;
  const ApexHeroListView({Key? key, this.type = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      key: ValueKey(type),
      builder: (BuildContext context, HeroProvider state, Widget? child) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 56, top: 10, left: 10, right: 10),
          child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              children: _renderItem(
                  list: state.bootstrapModel?.data.hero.sorts ?? null,
                  id: type)),
        );
      },
    );
  }

  _renderItem({required List<Sorts>? list, int id = 0}) {
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
      for (var k = 0; k < list[i].heroes.length; k++) {
        if (id == list[i].id) {
          item.add(GestureDetector(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    child: Image.network(
                      list[i].heroes[k].heroImg,
                      fit: BoxFit.cover,
                    ),
                    height: 147,
                    width: MediaQuery.of(currentContext!).size.width / 3.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(list[i].heroes[k].heroName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff585858),
                      )),
                ],
              ),
            ),
            onTap: () {
              Get.to(() => HeroDetails(
                    id: list[i].heroes[k].id,
                    name: list[i].heroes[k].heroName,
                  ));
            },
          ));
        }
      }
    }
    return item;
  }
}
