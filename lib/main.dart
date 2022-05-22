import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;




class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



Future<List<Post>> fetchPhotos(http.Client client) async {
  




  final Responce = await client.get(Uri.parse('https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
  print(Responce.body);
  return compute(parsePhotos,Responce.body);
}

List <Post> parsePhotos (String resBody){


  final parsed = jsonDecode(resBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post{
  final String ID;
  final String ACTIVE_FROM;
  final String TITLE;
  final String PREVIEW_TEXT;
  final String PREVIEW_PICTURE_SRC;
  final String DETAIL_TEXT;

  const Post({
    required this.ID,
    required this.ACTIVE_FROM,
    required this.TITLE,
    required this.PREVIEW_TEXT,
    required this.PREVIEW_PICTURE_SRC,
    required this.DETAIL_TEXT,
});

  factory Post.fromJson(Map<String, dynamic> json)  {
    return Post(
      ID: json['ID'] as String,
      ACTIVE_FROM: json['ACTIVE_FROM'] as String,
      TITLE: json['TITLE'] as String,
      PREVIEW_TEXT: json['PREVIEW_TEXT'] as String,
      PREVIEW_PICTURE_SRC: json['PREVIEW_PICTURE_SRC'] as String,
      DETAIL_TEXT: json['DETAIL_TEXT'] as String,
    );
  }
}

void main() async{

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());



}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Фотогалерея',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Лента новостей КубГАУ'),

    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<Post>>(
            future: fetchPhotos(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return  Center(
                  child: Text(snapshot.error.toString())
                );
              } else if (snapshot.hasData) {
                return PhotosList(Posts : snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        ),


    );
  }
}

class PhotosList extends StatelessWidget {

  const PhotosList({Key? key, required this.Posts}) : super(key: key);

  final List<Post> Posts;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: ListView.builder(
          itemCount: Posts.length,
            itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top:10),
              child: Card(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.greenAccent[100],
                  shadowColor: Colors.cyan[400],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.teal,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      Image.network(Posts[index].PREVIEW_PICTURE_SRC),
                      ListTile(
                        title: Text(Posts[index].TITLE),
                        subtitle: Text(Posts[index].ACTIVE_FROM),

                      ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal)
                  ),),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(Bidi.stripHtmlIfNeeded(Posts[index].DETAIL_TEXT),
                        style: TextStyle(

                        ) ,),
                      
                      ),
                      
                    ],
                  ),
              ),
            );

            }

        )
    );

  }
}
