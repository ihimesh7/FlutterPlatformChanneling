import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Platform Channel Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.platform_channeling/native');

  String _nativeResponse = 'Waiting for response...';

  Future<void> _getNativeResponse() async {
    String response;
    try {
      response = await platform.invokeMethod('getNativeMessage');
    } on PlatformException catch (e) {
      response = "Failed to get native message: '${e.message}'.";
    }

    setState(() {
      _nativeResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Platform Channel Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_nativeResponse),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getNativeResponse,
              child: Text('Get Native Response'),
            ),
          ],
        ),
      ),
    );
  }
}