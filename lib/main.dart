

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final formKey = GlobalKey<FormState>();

  String name = "";

  bool labelSwitch = false;

  TextEditingController controllerWidth = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();

  int result = 0, width = 0, haight = 0 ;
  String textF = "";
  multiplication(){
    setState(() {
        width = int.parse(controllerWidth.text);
        haight = int.parse(controllerHeight.text);
        result = width * haight;
    });
  }
  mainResText (){
    setState(() {
      if (!labelSwitch){
        textF = "Заполните все поля";
      }else
        {
          textF = "S = ${width} * ${haight} = ${result}";
        }
    });
  }

  @override
  Widget build(BuildContext context) {
      final double height = MediaQuery.of(context).size.height;
      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      mainResText ();
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Square calculator")
        ),
        body: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
            children: [

            Text("$textF"
                , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            TextFormField(

              controller: controllerHeight,
              decoration: InputDecoration(
                  labelText: "Введите длинну ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )

              ),
              validator: (controllerHeight){
                if (controllerHeight!.isEmpty || !RegExp(r'^[0-9+]').hasMatch(controllerHeight!))
                  {
                    return "Введите число";
                  }else
                    {
                      return null;
                    }
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: controllerWidth,
              decoration: InputDecoration(
                  labelText: "Введите ширину",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
              validator: (controllerHeight){
                if (controllerHeight!.isEmpty || !RegExp(r'^[0-9+]').hasMatch(controllerHeight!))
                {
                  return "Введите число";
                }else
                {
                  return null;
                }
              },
            ),
            SizedBox(height: 20,),
        ],
        )),
            Center(
                child:  ElevatedButton(onPressed: () {
                  if (formKey.currentState!.validate()){
                        multiplication();
                        if(!labelSwitch){
                          labelSwitch = true;
                        }
                        controllerHeight.clear();
                        controllerWidth.clear();

                      }else{
                    labelSwitch = false;
                  }
                    }, child: Text("Посчитать"))

            )
          ],
        )
      );
  }
}
