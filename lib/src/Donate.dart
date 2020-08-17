import 'dart:convert';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 12)
    return 'please note the pattern';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validateCNIC(String value) {
  Pattern pattern = r'^\d{5}-\d{7}-\d{1}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid CNIC';
  else
    return null;
}

class Donate extends StatefulWidget {
  String name;

  Donate({@required this.name});

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override

  String newDonorId;

  showAlertDialog(BuildContext context) {
    // set up the button
    if (selectedDate == null) {
      showEmptyDateAlertDialog(context);
      return;
    }
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Congratulations",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Registered.\nYour donor ID is",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "\n${newDonorId}\n",
              style: TextStyle(
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              "Remember your donor ID to update your details.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
            FittedBox(
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pop(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Donate(
                          name: "Donors Registration Form",
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

  String dropdownValue = 'MALE';
  String dropdownBValue = 'A+';
  String dropdownCValue = 'KARACHI';
  String dropdownEValue = 'ELIGIBLE';

  String _name = '';
  String _email = '';
  String _dob = '';
  String _contact = '';
  String _cnic = '';
  String _city = 'KARACHI';
  String _history = 'NO';
  String _gender = 'MALE';
  String _bloodgroup = 'A+';
  String _status = 'ELIGIBLE';

  void registerData(
      String name,
      String email,
      String status,
      String dob,
      String contact,
      String cnic,
      String city,
      String history,
      String gender,
      String bloodgroup) {
    if (selectedDate == null) {
      showEmptyDateAlertDialog(context);
      return;
    }

    final Map<String, String> registerVal = {
      'name': name,
      'email': email,
      'dob': dob,
      'contact': contact,
      'cnic': cnic,
      'city': city,
      'history': history,
      'gender': gender,
      'bloodgroup': bloodgroup,
      'status': status,
    };

    http.post('https://lifesource-da676.firebaseio.com/donor.json',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(registerVal))
        .then((http.Response response) {
      newDonorId = '';
      for (int i = 9; i < response.body.length - 2; i++) {
        newDonorId = newDonorId + response.body[i];
      }
      print(jsonDecode(response.body));
      showAlertDialog(context);
    });
    print(registerVal);
  }
  DateTime selectedDate = null;
  showAgeDateAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Age should be greater than or equals to 16.",
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

  showEmptyDateAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Kindly Choose Date of Birth.",
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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 16, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(DateTime.now().year - 60,),
      lastDate: DateTime(DateTime.now().year - 16, DateTime.now().month, DateTime.now().day),

    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      bool c = false;
      DateTime check = pickedDate;
      check = DateTime(check.year + 16, check.month, check.day);
      if (check.year < DateTime.now().year) {
        c = true;
      }
      else if(check.year == DateTime.now().year)
        {
          if(check.month <  DateTime.now(). month)
            {
              c = true;
            }
          else if(check.month ==  DateTime.now(). month)
            {
              if(check.day <=  DateTime.now(). day)
                {
                  c = true;
                }

            }

        }

      if (c == true) {
        setState(() {

          selectedDate = pickedDate;
          _dob =
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        });
      } else {
        showAgeDateAlertDialog(context);
      }
    });
  }

  var ValidateKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(),
              button: TextStyle(),
            ),
      ),
      home: Scaffold(
          appBar: new AppBar(
            title: Text(widget.name),
            backgroundColor: Colors.red,
          ),
          body: Form(
            key: ValidateKey,
            child: ListView(
              children: <Widget>[
                Container(
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
                                autofocus: true,
                                cursorColor: Colors.redAccent,
                                decoration: InputDecoration(
                                  labelText: 'Enter your Name',
                                ),
                                onChanged: (String name) {
                                  _name = name;
                                },
                                validator: (String name) {
                                  if (name.isEmpty)
                                    return 'Please Enter Your Name';
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
                                        labelText: 'Enter your email'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    onChanged: (String val) {
                                      _email = val;
                                    },
                                  ))
                            ]),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 65,
//                        padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "Date of Birth",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(selectedDate == null
                                          ? 'No Date Chosen!'
                                          : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                                      FlatButton(
                                        child: Text(
                                          'Choose Date',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        textColor: Colors.grey,
                                        padding:
                                            EdgeInsets.fromLTRB(9, 0, 9, 0),
                                        highlightColor: Colors.grey,
                                        onPressed: _presentDatePicker,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint: Text('Select Gender '),
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String newValue) {
                                      _gender = newValue;
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['MALE', 'FEMALE']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  child: DropdownButton<String>(
                                    value: dropdownEValue,
                                    focusColor: Colors.redAccent,
                                    hint: Text('Select Status   '),
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String newValue) {
                                      _status = newValue;
                                      setState(() {
                                        dropdownEValue = newValue;
                                      });
                                    },
                                    items: <String>['ELIGIBLE', 'NOT ELIGIBLE']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "BloodGroup",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButton<String>(
                                  value: dropdownBValue,
                                  hint: Text('Select B.Group'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
//
                                  onChanged: (String newValue) {
                                    _bloodgroup = newValue;
                                    setState(() {
                                      dropdownBValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'A+',
                                    'A-',
                                    'AB+',
                                    'AB-',
                                    'B+',
                                    'B-',
                                    'O+',
                                    'O-'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "CNIC",
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
                                        labelText: 'XXXXX-XXXXXXX-X'),
                                    validator: validateCNIC,
                                    onChanged: (String val) {
                                      _cnic = val;
                                    },
                                  ))
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 130,
                              child: Text(
                                "Contact no",
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
                                decoration:
                                    InputDecoration(labelText: '03XX-XXXXXXX'),
                                keyboardType: TextInputType.phone,
                                validator: validateMobile,
                                onChanged: (String val) {
                                  _contact = val;
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
                                  "Medical History",
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
                                      labelText: 'if any',
                                    ),
                                    onChanged: (String val) {
                                      _history = val;
                                    },
                                    style: TextStyle(height: 3.0),
                                  ))
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: 130,
                                child: Text(
                                  "Choose City",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: DropdownButton<String>(
                                  value: dropdownCValue,
                                  hint: Text('Select City   '),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String newValue) {
                                    _city = newValue;
                                    setState(() {
                                      dropdownCValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'KARACHI',
                                    'LAHORE',
                                    'ISLAMABAD',
                                    'QUETTA',
                                    'PESHAWAR',
                                    'HYDERABAD',
                                    'FAISALABAD'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              )
                            ]),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text('\n\n'),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    if (ValidateKey.currentState.validate()) {
                                      registerData(
                                          _name,
                                          _email,
                                          _status,
                                          _dob,
                                          _contact,
                                          _cnic,
                                          _city,
                                          _history,
                                          _gender,
                                          _bloodgroup);
                                    }
                                  });
                                },
                                child: Text(
                                  '     Register     ',
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
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
              ],
            ),
          )),
    );
  }
}
