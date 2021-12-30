// import 'package:flutter/material.dart';
import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/pages/shop/shop_details.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:provider/provider.dart';

class ShopAllPage extends StatefulWidget {
  final int id;
  final String name;
  ShopAllPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _ShopAllPageState createState() => _ShopAllPageState();
}

class _ShopAllPageState extends State<ShopAllPage> {
  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: widget.name,
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/banners.png'),
                    fit: BoxFit.cover),
              ),
              height: 60,
              alignment: Alignment.centerLeft,
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Consumer(builder:
                (BuildContext context, HeroProvider state, Widget? widgets) {
              return Container(
                  child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: _renderItem(state.bootstrapModel!.data.shop.topics),
              ));
            })
          ],
        ),
      ),
    );
  }

  _renderItem(List<Topics> state) {
    List<Widget> item = [];
    for (var i = 0; i < state.length; i++) {
      if (state[i].id == widget.id) {
        for (var k = 0; k < state[i].items.length; k++) {
          item.add(GestureDetector(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: 100,
                  child: Image.network(state[i].items[k].itemImg),
                ),
                Text(
                  state[i].items[k].itemName,
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            onTap: () {
              Get.to(() => ShopDetailsPage(
                    name: state[i].items[k].itemName,
                    id: state[i].items[k].id,
                  ));
            },
          ));
        }
      }
    }
    return item;
  }
}
