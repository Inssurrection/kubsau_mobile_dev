import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePanel(),
  ));
}

class HomePanel extends StatefulWidget {
  const HomePanel({Key? key}) : super(key: key);


  @override
  State<HomePanel> createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _likeCounter = 0;
  void likesAmountCounter() {
    setState(() {
      _likeCounter++;
    });
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Общежитие №20'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/Hostel_20.jpg'),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Общежитие №20', style: TextStyle(
                        fontWeight: FontWeight.bold,

                      )),
                      Text('Краснодар, ул. Калинина, 13', style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'TimesNewRoman',
                      ))
                    ],),

                    Row(
                      children: [
                        TextButton.icon(
                            onPressed: ()=>{likesAmountCounter()},
                            icon: Icon(Icons.favorite, color: Colors.red,),
                            label: Text('$_likeCounter'))
                      ],
                    )
                  ],
                ),
                SizedBox(width: 100,height: 20,),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [


                    Column(children: [
                      IconButton(onPressed: ()=>{}, icon: Icon(Icons.phone),color: Colors.green,),
                      Text('Позвонить', style: TextStyle(color: Colors.green, )),

                    ],),
                    Column(children: [
                      IconButton(onPressed: ()=>{}, icon: Icon(Icons.near_me_sharp),color: Colors.green,),
                      Text('Маршрут', style: TextStyle(color: Colors.green))
                      ]
                    ),
                    Column(children: [

                      IconButton(onPressed: ()=>{}, icon: Icon(Icons.share),color: Colors.green,),
                      Text('Поделиться', style: TextStyle(color: Colors.green))
                    ]

                    ),

                  ],
                ),
                SizedBox(width: 100,height: 20,),
                Row(
                  children: [
                    Flexible(child: Text('Студенческий городок или так'
                        ' называемый кампус Кубанского ГАУ состоит'
                        ' из двадцати общежитий, в которых проживает '
                        'более 8000 студентов, что составляет 96% от всех'
                        ' нуждающихся. Студенты первого курса обеспечены'
                        ' местами в общежитии полностью. В соответствии с'
                        ' Положением о студенческих общежитиях университета,'
                        ' при поселении между администрацией и студентами'
                        ' заключается договор найма жилого помещения.'
                        ' Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.'))

                  ],
                ),
              ],
            )
          ],
        )
      ),
      ),
    );
  }
}

