import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Admin.dart';
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

class Login extends StatefulWidget {
  String name;

  Login({@required this.name});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var top = 0.0;

  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Login",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Login Successfully.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              Navigator.pop(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new Login(
                        name: "Login",
                      )));
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Admin(),
                ),
              );
            });
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
  showIncorrectAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Incorrect Email or Password!\nPlease try again.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
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


  String _email = '';
  String _password = '';

  void fetchData(String email, String password) {
    bool check = false;
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/login.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'email': data['email'],
            'password': data['password'],
          };
          listFetchData.add(fdata);
        });
      });
      listFetchData.forEach((Map<String, dynamic> data){
          if(data['email'].toString().toLowerCase() == email.toLowerCase() && data['password'] == password)
            {
              check = true;
            }
        });
      if(check == true)
      {
        setState(() {
          showAlertDialog(context);
        });
      }
      else
        {
          setState(() {
            showIncorrectAlertDialog(context);
          });
        }
    });
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
                              "Password",
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
                                    labelText: 'Enter Password'),
                                validator: (String val) {
                                  if (val.isEmpty)
                                    return 'Please Enter Password';
                                  else
                                    return null;
                                },
                                obscureText: true,
                                onChanged: (String val) {
                                  _password = val;
                                },
                              ))
                        ],
                      ),
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
//                                  if (ValidateKey.currentState.validate()) {
//                                    fetchData(
//                                        _email, _password);
//                                  }
                            showAlertDialog(context);
                            });
                          },
                          child: Text(
                            '     LOGIN     ',
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
