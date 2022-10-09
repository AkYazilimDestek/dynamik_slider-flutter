import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late List imageList;
  bool loading = true;
  fetchAllImage() async {
    final response  = await http.get(Uri.parse("https://raw.githubusercontent.com/AkYazilimDestek/dynamik_slider-flutter/b1b8de6f9755f855ea87bfac47ea3bbf920a6388/slider.json"));
    if (response.statusCode == 200) {
      setState(() {
          imageList = jsonDecode(response.body);
          loading = false;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    fetchAllImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter slider"),
      ),
      body : Center(
        child : Column(
          children: [
            SizedBox(
                height: 150.0,
                width: 300.0,
                child: Carousel(
                  images: imageList.map((element) {
                    return Image.network(element["image"].toString());
                  }).toList(),
                )
            )
          ],
        ),
      ),
    );
  }
}

