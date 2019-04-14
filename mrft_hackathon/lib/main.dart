import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "";
  // WebViewController _controlle6r;

  // void get() async{
  //   var a = await http.get(url, headers: {
  
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kuveyt"),),
      body: Column(
        children: [
            // Container(width:100,height: 200,
            // child: WebView(
            //   initialUrl: "https://flutter.io",
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (WebViewController webViewController){
            //     _controller = webViewController;
            //   },
            //   )),
          ]
      ),      
    );
  }
}