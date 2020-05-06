import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: MyAppHome());
  }
}

class MyAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {

  var step = 0;
  var score = 0;
  var shownWidget;
  var lastTypeAt = new DateTime.now().millisecondsSinceEpoch;
  String lorem ="                                             Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
      .toLowerCase()
      .replaceAll(',', ' ')
      .replaceAll('.', ' ');


  void onType(String value ){
    print (value);
  }



  void onStartClick(){
    setState(() {
      step++;
    });
    Timer.periodic(new Duration(seconds: 1), (timer) {
      int now = DateTime.now().millisecondsSinceEpoch;

      //game over
      if(now - lastTypeAt >7000){
        step = 2;
      }


      setState(() {
        if(step ==1 ) {
          score++;
        }
      });

    });
  }







  @override
  Widget build(BuildContext context) {
    // TODO: implement build




    if ( step == 0 ){
      shownWidget = <Widget>[
        Text("Hoşgeldin"),
        Container(padding: const EdgeInsets.only(top: 10),
          child: RaisedButton(
            child: Text("Başla!"),
            onPressed: onStartClick,
          ),
        )
      ];
    }

    else if (step == 1 )
    {
      shownWidget = <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text('score:'+ '$score'),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 80),
          child: Marquee(
            text: lorem,
            style: TextStyle(fontSize: 24,letterSpacing: 2),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            //blankSpace: 20.0,
            velocity: 100.0,
            //pauseAfterRound: Duration(seconds: 10),
            startPadding: 0, //startPadding: MediaQuery.of(context).size.width,
            accelerationDuration: Duration(seconds: 20),
            accelerationCurve: Curves.ease,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 32, right: 32, top: 16, bottom: 16),
          child: TextField(
            obscureText: false,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type',
            ),
            onChanged: onType,
          ),
        )
      ];
    }

    else if (step == 2){
      shownWidget = <Widget>[
        Text("Geç Kaldın! Score : '$score'"),
      ];
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('Helloo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shownWidget,
        ),
      ),
    );
  }
}



