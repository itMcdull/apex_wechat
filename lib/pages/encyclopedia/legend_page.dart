import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';
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
          padding: EdgeInsets.only(bottom: 56, top: 10, left: 10, right: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            children: (type != 0
                    ? (state.heroModel == null ? [] : state.heroModel!.data)
                        .where((element) => element.sortId == type)
                    : (state.heroModel == null ? [] : state.heroModel!.data))
                .map<Widget>((e) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.network(
                        e.heroImg,
                        fit: BoxFit.cover,
                      ),
                      height: 147,
                      width: MediaQuery.of(currentContext!).size.width / 3.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(e.heroName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff585858),
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
