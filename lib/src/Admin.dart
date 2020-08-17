import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'AdminSrc/AdminDonors.dart';
import 'AdminSrc/AdminHospitals.dart';
import 'AdminSrc/AdminBloodCamps.dart';
import 'AdminSrc/BloodStock.dart';
import 'AdminSrc/Messages.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        errorColor: Colors.redAccent,

      ),

      home: Scaffold(
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
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).copyWith().size.width,
                    height: MediaQuery.of(context).copyWith().size.height / 3.2,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).copyWith().size.width,
                          height:
                              MediaQuery.of(context).copyWith().size.height /
                                  3.2,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(
                              "https://www.noakhalipage.com/wp-content/uploads/2016/06/werw-660x330.jpg",
                            ),
                          ),
                        ),
                        Align(
//                    alignment: FractionalOffset(0.5, 0.5),
                          child: Center(
                            child: Container(
                              color: Colors.white.withOpacity(0.7),
                              width:
                                  MediaQuery.of(context).copyWith().size.width,
                              child: Text(
                                "ADMIN",
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
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new BloodStock()));
                                });
                              },
                              color: Colors.red,
                              child: Text('Blood Stock'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new Messages()));
                                });
                              },
                              color: Colors.red,
                              child: Text('Messages'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new AdminDonors()));
                                });
                              },
                              color: Colors.red,
                              child: Text('Donors'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new AdminHospitals()));
                                });
                              },
                              color: Colors.red,
                              child: Text('Hospitals'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new AdminBloodCamps()));
                                });
                              },
                              color: Colors.red,
                              child: Text('Blood Camps'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.red,
                              child: Text('Log Out'),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              highlightColor: Colors.grey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
