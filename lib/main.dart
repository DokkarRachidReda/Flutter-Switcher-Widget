import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:switcher_li/Switcher_li.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget  {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  Color color=Colors.grey[100];
  AnimationController ac;
  Animation animation;
int a=1;
  @override
  void initState() {
     ac=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
     animation=ColorTween(begin:Color(0xff5d5d5d),end:Color(0xfffdfdfd)).animate(
      CurvedAnimation(parent: ac,curve: Curves.easeInOutSine)
   );

   animation.addListener((){
         setState(() {
           
         });
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      backgroundColor:animation.value ,
      body: Center(

        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          
          child: switcherLi(width: 80,firstColor: Colors.white,secondColor: Color(0xff444444),onChanged:(){
            a==1 ? ac.forward():ac.reverse();
            a==1 ?a=2:a=1;
          }),
        )
      ),
    );
  }
}
