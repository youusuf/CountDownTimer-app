import 'dart:async';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  Timer timer;
  var minute = 0;
  var second = 0;
  int totalTime;
  void startTimer(){
    final oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      totalTime = minute*60+second;
      setState(() {
        if(totalTime<1){
          timer.cancel();
        }
        else{
          totalTime-=1;
          second = totalTime%60;
          if(second==0)minute-=1;
        }
      });
    });
  }
  void cancelTimer(){
    setState(() {
      minute = 0;
      second = 0;
    });
    timer.cancel();
  }
  void setSecond(value){
    setState(() {
      second = value;
    });
  }
  void setMinute(value){
    setState(() {
      minute = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            return showDialog(
                context: context,
                builder:(BuildContext context)=>SimpleDialog(
                  contentPadding: EdgeInsets.all(15.0),
                  children: [
                    Text("Set Your Timer"),
                    DropdownButton(
                      value: minute,
                      icon: Text("Minute"),
                        items: List.generate(60, (index){
                      return DropdownMenuItem(

                        value: index,
                          child:Text(index.toString()));
                    }),
                      onChanged: setMinute,
                    ),
                    DropdownButton(
                      value: second,
                      icon: Text("Second"),
                      items: List.generate(60, (index){
                        return DropdownMenuItem(
                          value: index,
                            child:Text(index.toString()));
                      }),
                      onChanged: setSecond,
                    ),
                    SizedBox(height: 20.0,),
                    OutlinedButton(
                        onPressed:(){
                          startTimer();
                          Navigator.of(context).pop();
                        },
                      child: Text("Start"),
                    )

                  ],
                )
            );
          },
          child: Icon(
            Icons.alarm_add_outlined
          ),
        ),
        appBar: AppBar(
          title: Text('Countdown Timer App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              SizedBox(height: 25.0,),
              Text(
                  "$minute:$second",style:TextStyle(
                fontSize: 65.0
              )
              ),

              TextButton(onPressed:cancelTimer, child: Text('STOP',style: TextStyle(
                fontSize: 35.0
              ),)
              ),
              SizedBox(height: 25.0,)
            ],
          ),
        )
    );
  }
}

