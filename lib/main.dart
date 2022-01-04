import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: OCRPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "TEXT";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('OCR'),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _text,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Center(
                child: RaisedButton(
                  color: Colors.amber,
                  onPressed: _read,
                  child: Text(
                    'Scanning',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: true,
      );

      setState(() {
        _text = texts[0].value;
      });
    } on Exception {
      texts.add(OcrText('Failed to recognize text'));
    }
  }
}
