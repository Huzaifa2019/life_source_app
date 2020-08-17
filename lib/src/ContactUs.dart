import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

class ContactUs extends StatefulWidget {
  String name;

  ContactUs({@required this.name});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var top = 0.0;

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Message",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Your Message Sent Successfully.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ContactUs(
                          name: "Contact Us",
                        )));
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String _name = '';
  String _email = '';
  String _subject = '';
  String _message = '';

  void registerData(String name, String email, String subject, String message) {
    final Map<String, String> registerVal = {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message
    };

    http
        .post('https://lifesource-da676.firebaseio.com/messages.json',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(registerVal))
        .then((http.Response response) {
      print(jsonDecode(response.body));
    });
    showAlertDialog(context);
    print(registerVal);
  }

  var ValidateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
          ),
          button: TextStyle(
          ),
        ),

        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
              ),
            )),

      ),
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.red,
                expandedHeight: 200.0,
                floating: true,
//              leading:
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  // print('constraints=' + constraints.toString());
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text(widget.name),
                    background: Image.network(
                      "https://www.noakhalipage.com/wp-content/uploads/2016/06/werw-660x330.jpg",
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ];
          },
          body: Form(
            key: ValidateKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 150,
                                child: TextFormField(
                                    cursorColor: Colors.redAccent,
                                    decoration: InputDecoration(
                                        labelText: 'Enter Name'),
                                    onChanged: (String name) {
                                      _name = name;
                                    },
                                    validator: (String name) {
                                      if (name.isEmpty)
                                        return 'Please Enter Your Name';
                                      else
                                        return null;
                                    }))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 150,
                                child: TextFormField(
                                  cursorColor: Colors.redAccent,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Email ID'),
                                  validator: validateEmail,
                                  onChanged: (String val) {
                                    _email = val;
                                  },
                                ))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Subject",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 150,
                                child: TextFormField(
                                  cursorColor: Colors.redAccent,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      labelText: 'Write a Subject'),
                                  validator: (String val) {
                                    if (val.isEmpty)
                                      return 'Please Enter Subject';
                                    else
                                      return null;
                                  },
                                  onChanged: (String val) {
                                    _subject = val;
                                  },
                                ))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Message",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 150,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  cursorColor: Colors.redAccent,
                                  decoration: InputDecoration(
                                      labelText: 'Type Your Message'),
                                  validator: (String val) {
                                    if (val.isEmpty)
                                      return 'Please Write Message';
                                    else
                                      return null;
                                  },
                                  onChanged: (String val) {
                                    _message = val;
                                  },
                                  style: TextStyle(height: 3.0),
                                ))
                          ]),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text('\n\n'),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              if (ValidateKey.currentState.validate()) {
                                print("object");
                                registerData(_name, _email, _subject, _message);
                              }
                            });
                          },
                          child: Text(
                            '     SUBMIT     ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                          highlightColor: Colors.grey,
                          color: Colors.red,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
