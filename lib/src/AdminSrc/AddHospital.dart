import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 12)
    return 'Please note the pattern';
  else
    return null;
}

class AddHospital extends StatefulWidget {


  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  String name = '';
  String address = '';
  String contact = '';

  @override
  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Congratulations",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Hospital Details Added Successfully.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
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

  void addData() {
    final Map<String, String> registerVal = {
      'name': name,
      'address': address,
      'contact': contact,
    };

    http
        .post('https://lifesource-da676.firebaseio.com/hospitals.json',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(registerVal))
        .then((http.Response response) {
//      print(jsonDecode(response.body));
      showAlertDialog(context);
    });
//    print(registerVal);
  }

  var ValidateKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // TODO: implement build
    return new Form(
      key: ValidateKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            // color: Colors.blue,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Hospital Name",
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
                          initialValue: name,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            labelText: 'Enter Hospital Name',
                          ),
                          onChanged: (String val) {
                            name = val;
                          },
                          validator: (String name) {
                            if (name.isEmpty)
                              return 'Please Enter Hospital Name';
                            else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Text(
                            "Address",
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
                              initialValue: address,
                              cursorColor: Colors.redAccent,
                              decoration: InputDecoration(
                                  labelText: 'Enter Address'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (String address) {
                                if (address.isEmpty)
                                  return 'Please Enter Address';
                                else
                                  return null;
                              },
                              onChanged: (String val) {
                                address = val;
                              },
                            ))
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Contact",
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
                          initialValue: contact,
                          cursorColor: Colors.redAccent,
                          decoration:
                              InputDecoration(labelText: '03XX-XXXXXXX'),
                          keyboardType: TextInputType.phone,
                          validator: validateMobile,
                          onChanged: (String val) {
                            contact = val;
                          },
                        ),
                      )
                    ],
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
                                addData();
                              }
                            });
                          },
                          child: Text(
                            '   ADD   ',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
