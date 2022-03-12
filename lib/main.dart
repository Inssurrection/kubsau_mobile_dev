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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Инкремент'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {

      _counter--;
    });
  }
  void _incrementWipe(){
    setState(() {
      _counter = 0;
    });
  }
  Widget buildButton () => Container(

      margin:  EdgeInsets.only(left:107,right:107, bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 0,

          child: ElevatedButton(

          child: const Text('-', style: TextStyle( color: Colors.black),),
          onPressed: () => _decrementCounter(),
          style: ElevatedButton.styleFrom(
          primary: Colors.red,


          textStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
     ),
    ),
            ),
          Expanded(
            flex: 0,
            child: ElevatedButton(
              child: Text('+', style: TextStyle( color: Colors.black) ,),
              onPressed: () => _incrementCounter(),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,

                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                  )

              ),
            ),
          ),

           ]

          ),

          );
  Widget bulidText () => Container(
    child: Text('Значение инкремента:'),
    margin: EdgeInsets.only(top: 250 ),
  );
  Widget buildCounter () => Container(
    margin: EdgeInsets.only(bottom: 10 ),
    padding: EdgeInsets.only(top: 0),
    child: Text('$_counter', style: TextStyle(color: Colors.grey[600], fontSize: 30),),
    alignment: Alignment.center,

  );
  Widget bulidWipe () => Container(
      margin: EdgeInsets.only(bottom: 282 ),
      child: TextButton(child: Text('Сбросить', style: TextStyle(color: Colors.grey)),
      onPressed: () =>{_incrementWipe()},style: TextButton.styleFrom(
      ),),

  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(


       child: Column(

         children: <Widget>[
           Expanded(
              flex:0,
             child: bulidText(),
           ),
           Expanded(
             flex:0,
             child: buildCounter(),
           ),
           Expanded(
                flex:0,
               child: buildButton(),
           ),
           Expanded( flex: 0,
              child: bulidWipe(),
           ),
         ],
       ),

      ),



    );

  }
}
