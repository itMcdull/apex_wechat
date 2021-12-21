import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class MinePage extends StatefulWidget {
  final String title;

  MinePage({Key? key, required this.title}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: '我的',
      body: Center(
        child: GestureDetector(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Text(
                'Hello, MPFlutter!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
