import 'package:apex_wechat/model/bootstrap_model.dart';
import 'package:apex_wechat/pages/shop/shop_all.dart';
import 'package:apex_wechat/pages/shop/shop_details.dart';
import 'package:apex_wechat/provider/hero_provider.dart';
import 'package:apex_wechat/utils/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpcore/mpcore.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  final String title;
  ShopPage({Key? key, required this.title}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
        name: widget.title,
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Consumer(builder:
                  (BuildContext context, HeroProvider state, Widget? widget) {
                return Column(
                  children: _renderItem(state.bootstrapModel!.data.shop.topics),
                );
              }),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ));
  }

  _renderItem(List<Topics> topics) {
    List<Widget> item = [];
    for (var i = 0; i < topics.length; i++) {
      item.add(Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/banners.png'),
                    fit: BoxFit.cover),
              ),
              height: 60,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    topics[i].topicName,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ShopAllPage(
                              id: topics[i].id,
                              name: topics[i].topicName,
                            ));
                      },
                      child: Text(
                        '全部  >',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            height: 180,
            child: Row(
              children: [
                _shopImageItem(topics[i].items[0]),
                topics[i].items.length > 2
                    ? Container(
                        width: 130,
                        child: Column(
                          children: [
                            _shopImageItem(topics[i].items[1]),
                            _shopImageItem(topics[i].items[2]),
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          )
        ],
      ));
    }
    return item;
  }

  _shopImageItem(TopicsItems item) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Get.to(() => ShopDetailsPage(
              name: item.itemName,
              id: item.id,
            ));
      },
      child: Container(
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(currentContext!).size.height,
          width: MediaQuery.of(currentContext!).size.width,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.itemImg,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  item.itemName,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          )),
    ));
  }
}
