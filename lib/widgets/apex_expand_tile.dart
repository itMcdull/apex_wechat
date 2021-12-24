import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class TolyExpandTile extends StatefulWidget {
  final Widget titleWidget;
  final Widget content;

  const TolyExpandTile(
      {Key? key, required this.titleWidget, required this.content})
      : super(key: key);
  @override
  _TolyExpandTileState createState() => _TolyExpandTileState();
}

class _TolyExpandTileState extends State<TolyExpandTile>
    with SingleTickerProviderStateMixin {
  var _crossFadeState = CrossFadeState.showFirst;
  String _materialIcons = MaterialIcons.arrow_right;
  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _togglePanel,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: widget.titleWidget,
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: AnimatedSwitcher(
                      transitionBuilder: (child, anim) {
                        return ScaleTransition(child: child, scale: anim);
                      },
                      duration: Duration(milliseconds: 300),
                      child: MPIcon(
                        _materialIcons,
                        size: 30,
                      ),
                    ))
              ],
            ),
          ),
          _buildPanel()
        ],
      ),
    );
  }

  void _togglePanel() {
    setState(() {
      if (_materialIcons == MaterialIcons.arrow_right)
        _materialIcons = MaterialIcons.arrow_drop_down;
      else {
        _materialIcons = MaterialIcons.arrow_right;
      }
      _crossFadeState =
          !isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }

  Widget _buildPanel() => AnimatedCrossFade(
        firstCurve: Curves.easeInCirc,
        secondCurve: Curves.easeInToLinear,
        firstChild: SizedBox(),
        secondChild: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Color(0xffeeeeee), width: 2))),
          child: widget.content,
        ),
        duration: Duration(milliseconds: 300),
        crossFadeState: _crossFadeState,
      );
}
