import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

class HeadlinesPage extends StatefulWidget {
  final String title;
  HeadlinesPage({Key? key, required this.title}) : super(key: key);

  @override
  _HeadlinesPageState createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  @override
  Widget build(BuildContext context) {
    return MPScaffold(
      name: '头条',
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/second');
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
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
