import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';

class ApexTabbarView extends StatefulWidget {
  final List<String>? tab;
  final List<Widget>? children;
  final bool isDivider;
  ApexTabbarView({
    Key? key,
    required this.tab,
    required this.children,
    this.isDivider = true,
  }) : super(key: key);

  @override
  _ApexTabbarViewState createState() => _ApexTabbarViewState();
}

class _ApexTabbarViewState extends State<ApexTabbarView> {
  int currentIndex = 0;
  Widget? _widget;
  @override
  void initState() {
    super.initState();
  }

  ///[tabbar]
  _randerItem() {
    List<Widget> item = [];
    for (var i = 0; i < widget.tab!.length; i++) {
      item.add(Expanded(
          child: GestureDetector(
        onTap: () {
          setState(() {
            print(i);
            print(widget.children![i]);
            currentIndex = i;
            _widget = widget.children![i];
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.tab![i],
                style: TextStyle(
                    color: currentIndex == i
                        ? Color(0xff3C3C3C)
                        : Color(0xff969696),
                    fontSize: 16),
              ),
              SizedBox(height: 5),
              Opacity(
                  opacity: currentIndex == i ? 1 : 0,
                  child: Container(
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xff1A1616), width: 3))),
                  ))
            ],
          ),
        ),
      )));
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
              border: widget.isDivider
                  ? Border(
                      bottom: BorderSide(color: Color(0xffE8E8E8), width: 1))
                  : Border()),
          width: MediaQuery.of(currentContext!).size.width,
          child: Row(children: _randerItem()),
        ),
        Container(child: _widget ?? widget.children![0])
      ],
    ));
  }
}
