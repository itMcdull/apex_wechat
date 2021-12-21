import 'package:apex_wechat/model/hero_details_model.dart';
import 'package:apex_wechat/pages/heroDetails/control.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class HeroDetails extends StatefulWidget {
  final int id;
  final String name;
  HeroDetails({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  HeroDetailsModel? _heroDetailsModel;
  @override
  void initState() {
    super.initState();
    _getData();
    print(widget.id);
  }

  _getData() {
    HeroDetailsControl.gethero(
        value: widget.id,
        onSuccess: (value) {
          print(value.data.heroVideo);
          _heroDetailsModel = value;
          if (!mounted) return;
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: widget.name,
      body: Container(
        padding: EdgeInsets.only(bottom: 56, left: 10, right: 10, top: 10),
        child: _heroDetailsModel == null
            ? Center(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('assets/images/loading.svg'),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: MPVideoView(
                            url: _heroDetailsModel!.data.heroVideo,
                          ),
                        ))
                  ],
                ),
              ),
      ),
    );
  }
}
