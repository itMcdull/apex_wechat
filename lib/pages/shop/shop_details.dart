import 'package:apex_wechat/model/shop_details_model.dart';
import 'package:apex_wechat/utils/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';
import 'package:universal_miniprogram_api/universal_miniprogram_api.dart';

class ShopDetailsPage extends StatefulWidget {
  final String name;
  final int id;
  ShopDetailsPage({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  ShopDatailsModel? _shopDatailsModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Call.dispatch('/wiki/shop/topic/item/${widget.id}').then((result) {
        if (result['code'] == 0) {
          _shopDatailsModel = ShopDatailsModel.fromJson(result);
          if (!mounted) return;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: widget.name,
      body: Container(
        child: _shopDatailsModel == null
            ? Center(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('assets/images/loading.svg'),
                ),
              )
            : ListView(
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
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Column(
                    children: _shopDatailsModel!.data.contentPics
                        .map<Widget>(
                          (e) => GestureDetector(
                              onTap: () {
                                UniversalMiniProgramApi.uni
                                    .previewImage(PreviewImageOption(
                                  showmenu: true,
                                  urls: [e],
                                ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                child: Image.network(e),
                              )),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
      ),
    );
  }
}
