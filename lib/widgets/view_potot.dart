//图片查看
//import 'dart:async';

/*
 * imgs 格式[{url:'',file:File}]
 * img 当前点击进入的图片
 * width 屏幕宽度
 */

import 'package:flutter/widgets.dart';

class ViewDialog extends StatefulWidget {
  ViewDialog({Key? key, this.img, this.imgs, this.width}) : super(key: key);
  final img;
  final imgs;
  final width;

  @override
  _PageStatus createState() => _PageStatus();
}

class _PageStatus extends State<ViewDialog> {
  var image;
  var w;
  var index = 1;
  var _scrollController;
  var down = 0.0; //触开始的时候的left
  var half = false; //是否超过一半

  last() {
    if (1 == index) {
    } else {
      setState(() {
        image = widget.imgs[index - 2];
        index = index - 1;
      });
    }
  }

  next() {
    if (widget.imgs.length == index) {
    } else {
      setState(() {
        image = widget.imgs[index];
        index = index + 1;
      });
    }
  }

  delete() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    //页面初始化
    super.initState();
    var n = 0;
    var nn;
    widget.imgs.forEach((i) {
      n = n + 1;
      if (i['key'] == widget.img['key']) {
        nn = n;
      }
    });
    print(nn);
    if (nn > 1) {
      print(widget.width);
      _scrollController =
          ScrollController(initialScrollOffset: widget.width * (nn - 1));
    } else {
      _scrollController = ScrollController(
        initialScrollOffset: 0,
      );
    }
    setState(() {
      image = widget.img;
      index = nn;
    });
  }

  nextPage(w) {
    setState(() {
      index = index + 1;
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  lastPage(w) {
    setState(() {
      index = index - 1;
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  moveEnd(e, w, l) {
    var end = e.primaryVelocity;
    if (end > 10 && index > 1) {
      lastPage(w);
    } else if (end < -10 && index < l) {
      nextPage(w);
    } else if (half == true) {
      if (down > w / 2 && index < l) {
        //右边开始滑动超过一半,则下一张
        nextPage(w);
      } else if (down < w / 2 && index > 1) {
        lastPage(w);
      } else {
        _scrollController.animateTo(
          (index - 1) * w,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      }
    } else {
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  imgMove(e, w, l) {
    //down 为起点
    var left = e.position.dx;
    var now = (index - 1) * w;
    var move = left - down; //移动距离
    if (left - down > w / 2 || down - left > w / 2) {
      half = true;
    } else {
      half = false;
    }
    _scrollController.jumpTo(now - move);
  }

  Widget list(w, l) {
    List<Widget> array = [];
    widget.imgs.forEach((i) {
      array.add(
        Listener(
          onPointerMove: (e) {
            imgMove(e, w, l);
          },
          onPointerDown: (e) {
            down = e.position.dx;
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            onHorizontalDragEnd: (e) {
              moveEnd(e, w, l);
            },
            child: Container(
              width: w,
              child: i['url'] != null
                  ? Image.network(i['url'])
                  : Image.file(i['file']),
            ),
          ),
        ),
      );
    });
    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: array,
    );
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    var l = widget.imgs.length;
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          list(w, l),
          Positioned(
            top: 20,
            child: Container(
                alignment: Alignment.center,
                width: w,
                child: Text('$index/$l',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 1)),
                      ],
                    ))),
          ),
          // Positioned(
          //   top: 20,
          //   right: 20,
          //   child: Container(
          //     alignment: Alignment.centerLeft,
          //     width: 20,
          //     child: GestureDetector(
          //       onTap: () {delete();},
          //       child: Icon(Icons.delete,color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
