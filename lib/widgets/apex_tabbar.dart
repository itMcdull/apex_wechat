import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/widgets.dart';

class ApexTabbarView extends StatefulWidget {
  final List<String> tab;
  final List<Widget> children;
  final bool isDivider;
  final bool isImage;
  final Function(int index)? onTap;
  ApexTabbarView({
    Key? key,
    required this.tab,
    required this.children,
    this.onTap,
    this.isDivider = true,
    this.isImage = false,
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

    for (var i = 0; i < widget.tab.length; i++) {
      item.add(Expanded(
          child: GestureDetector(
        onTap: () {
          widget.onTap?.call(i);
          setState(() {
            currentIndex = i;
            _widget = widget.children[i];
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !widget.isImage
                ? Text(
                    widget.tab[i],
                    style: TextStyle(
                        color: currentIndex == i
                            ? Color(0xff3C3C3C)
                            : Color(0xff969696),
                        fontSize: 16),
                  )
                : Image.network(
                    widget.tab[i],
                    width: 20,
                    height: 20,
                  ),
            SizedBox(height: 5),
            Opacity(
                opacity: currentIndex == i ? 1 : 0,
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xff1A1616), width: 3))),
                ))
          ],
        ),
      )));
    }
    setState(() {});
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: 55,
          decoration: widget.isDivider
              ? BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffE8E8E8), width: 1)))
              : null,
          width: MediaQuery.of(currentContext!).size.width,
          child: Row(children: _randerItem()),
        ),
        Container(child: _widget ?? widget.children[0])
      ],
    ));
  }
}
