import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

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
        debugShowCheckedModeBanner: false,
        home: Splash()
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String _anim = "spin1";
  bool _isPaused = false;


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              setState(() {
                _anim == "spin1" ? _anim = "spin2" : _anim = "spin1";
              });
            },
            onLongPress: () {
              setState(() {
                _isPaused ? _isPaused = false : _isPaused = true;
              });
            },
            child: Container(
              width: 150,
              height: 150,
              child: FlareActor(
                "assets/AnimGears.flr", animation: _anim, isPaused: _isPaused,
              ),
            )
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Flutter + Flare", style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center),
          Container(
            width: 100,
            height: 100,
            child: FlareActor("assets/AnimHeart.flr", animation: "pulse",),
          )
        ],
      ),
    );
  }
}
