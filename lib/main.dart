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
      home : _Vucut(),
    );
  }
}

class _Vucut extends StatefulWidget {
  const _Vucut({Key? key}) : super(key: key);

  @override
  State<_Vucut> createState() => _VucutState();
}

class _VucutState extends State<_Vucut> {

  late List imageList;
  late bool loading = true;
  fetchAllImage() async {
    final response = await http.get(Uri.parse("https://raw.githubusercontent.com/AkYazilimDestek/dynamik_slider-flutter/b1b8de6f9755f855ea87bfac47ea3bbf920a6388/slider.json"));
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
        title: Text("Dynamic slider"),
      ),
      body : Container(
        child: Center(
          child : Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child :  loading? CircularProgressIndicator() : Carousel(
                  images: imageList.map((element) {
                    return Image.network(element["image"]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

