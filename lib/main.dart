import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'src/CreateButtons.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override

  State<StatefulWidget> createState() =>_MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    // var question =['What is your favourite colour ?', 'what is your favourite animal ?'];
    return MaterialApp(
      title: 'Life Source',
        theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        errorColor: Colors.red,

        ),

      home: mycontainer(),
    );
  }
}

class mycontainer extends StatefulWidget {
  @override
  _mycontainerState createState() => _mycontainerState();
}

class _mycontainerState extends State<mycontainer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Life Source',
        ),
        backgroundColor: Colors.red,
        actions: <Widget>[
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).copyWith().size.width,
                height: MediaQuery.of(context).copyWith().size.height / 3.2,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width,
                      height: MediaQuery.of(context).copyWith().size.height / 3.2,
                      child: FittedBox(
                        fit: BoxFit.fill,

                        child: Image.network(
                          "https://www.noakhalipage.com/wp-content/uploads/2016/06/werw-660x330.jpg",
//                        color: Color.fromRGBO(255, 255, 255, 0.5),
//                        colorBlendMode: BlendMode.modulate,

                        ),
                      ),
                    ),
                    Align(
//                    alignment: FractionalOffset(0.5, 0.5),
                      child: Center(
                        child: Container(
                          color: Colors.white.withOpacity(0.7),
                          width: MediaQuery.of(context).copyWith().size.width,
                          child: Text(
                            "WELCOME",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,

                              // textBaseline: TextBaseline.
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Button(name: 'Donate Now'),
                      Button(name: 'Donors'),
                      Button(name: 'Hospitals'),
                      Button(name: 'Blood Camps'),
                      Button(name: 'Login'),
                      Button(name: 'About us'),
                      Button(name: 'Contact us'),

                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
