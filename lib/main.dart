import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Power\'s of two',
      theme: ThemeData(

        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Making the infinite powers of two'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  int twoPowers = 0;
  List<String> items = [];
  bool loading = false, allLoaded = false;
  mockFetch() async {
    if (allLoaded){
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    List<String> newData = items.length >= (1000+ twoPowers)? [] : List.generate(20, (index) => "2^${index+twoPowers} = ${pow(2, index + twoPowers)}") ;
    twoPowers = twoPowers + 20;
    if (newData.isNotEmpty){
      items.addAll(newData);
    }
      setState(() {
        loading = false;
        allLoaded = newData.isEmpty;
      });
  }
  void _makingPowersOfTwo (){

    setState(() {

    });
}
@override
  void initState() {

    super.initState();
    mockFetch();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading){
        print("New Data Call");
        mockFetch();
      }
    });
  }
  @override
  void dispose() {

    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (items.isNotEmpty){
          return Stack(
            children: [
              ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index){
                return ListTile(
                  title: Text(items[index]),
                );
              }, separatorBuilder: (context, index){
                return  Divider(height: 1, thickness: 1.0,);
              }, itemCount: items.length),
             if (loading)...[
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: constraints.maxWidth,
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
             ]
            ],);
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
