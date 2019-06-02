

import 'package:flutter/material.dart';

class switcherLi extends StatefulWidget  {

const switcherLi({Key key, this.width,Color this.firstColor,Color this.secondColor,this.onChanged}): super(key: key);

final double width;
final Function onChanged;
final Color firstColor;  //=Color(0xffffffff);
final Color secondColor; //=Color(0xff222222);


  @override
  switcherState createState() {
    
    return switcherState();
  }

}

class switcherState extends State<switcherLi> with TickerProviderStateMixin{
 
  int _actualColor=1;
  
  Color firstColor;  
  Color secondColor;
  AnimationController ac;
  AnimationController ac1;
  Animation animation;
  Animation animation1;
  Animation colorAnimation;
   double width;
   double height;
  @override
  void initState() {
    firstColor=widget.firstColor;
    secondColor=widget.secondColor;
    width=widget.width != null ? widget.width : 60;
    //height=widget.height != null ? widget.height : 30;
   ac=AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
   ac1=AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
   animation=Tween(begin:-3*(0.17),end:(0.17)).animate(
      CurvedAnimation(parent: ac,curve: Curves.bounceOut)
   );
           //width*0.25/60
    animation1=Tween(begin:3*(0.17),end:-(0.17)).animate(
      CurvedAnimation(parent: ac1,curve: Curves.bounceOut)
   );
  

   colorAnimation=ColorTween(begin:firstColor,end:secondColor).animate(
      CurvedAnimation(parent: ac,curve: Curves.fastOutSlowIn)
   );

   animation.addListener((){
     setState(() {});
   });

   animation1.addListener((){
     setState(() {});
   });

   colorAnimation.addListener((){setState(() {
     
   });});
  
    super.initState();
  }
@override
  void dispose() {
    ac?.dispose();
    super.dispose();
  }
  
 double getOffset(){
   
     if(animation.status==AnimationStatus.dismissed && animation1.status==AnimationStatus.dismissed && animation.value !=(0.17) ){return -(0.17);} //first pos
     else if(animation1.status==AnimationStatus.forward ){return animation1.value;}
     else if(animation.status==AnimationStatus.forward ||(animation.status==AnimationStatus.completed && animation1.status!=AnimationStatus.completed)){return animation.value;}
     else if(animation1.status==AnimationStatus.completed){return -(0.17);}
     
  }

  @override
  Widget build(BuildContext context) {
   
    return FittedBox(
    child: Container(
      width: width,
      height:width/2 +5,
      
      
        child: Material(
        elevation: 5.0,
        type: MaterialType.canvas,
        clipBehavior: Clip.antiAlias,   
        borderRadius: BorderRadius.circular(60.0),
        color: colorAnimation.value, 
  
          child: GestureDetector(
          onTap: (){
            
            if(_actualColor==1){
              ac.forward();
              ac1.reset();
              setState(() {
                 _actualColor=2;
              });
            }else{
             ac1.forward();
             ac.reset();
              setState(() {
                _actualColor=1;
              });
              
            }     
            widget.onChanged();
           
          },

          child: Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child:  Container(
          
          transform: Matrix4.translationValues( width*getOffset(), 0, 0),
          child: Material(
                    color: _actualColor==1 ? secondColor :firstColor,
                    type: MaterialType.circle,
                    //shape: const CircleBorder(),
                    elevation: 5.0,
          ),
        ),
          )
        
        ),
        )
      
      
      ),
    );
      
  }
}

/*

                   

                    Container(
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _actualColor==1 ? secondColor :firstColor
            ),
          )
 */