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
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

class EditBloodCamp extends StatefulWidget {
  String id;
  String city;
  String venue;
  String contact;
  String email;
  String fromtime;
  String totime;
  String fromdate;
  String todate;

  EditBloodCamp({
    @required this.id,
    @required this.city,
    @required this.venue,
    @required this.contact,
    @required this.email,
    @required this.fromtime,
    @required this.totime,
    @required this.fromdate,
    @required this.todate,
  });

  @override
  _EditBloodCampState createState() => _EditBloodCampState(
        id: id,
        city: city,
        venue: venue,
        email: email,
        fromdate: fromdate,
        totime: totime,
        todate: todate,
        fromtime: fromtime,
        contact: contact,
      );
}

class _EditBloodCampState extends State<EditBloodCamp> {
  String id;
  String city;
  String venue;
  String contact;
  String email;
  String dropdownCValue;
  String fromtime;
  String totime;
  String fromdate;
  String todate;
//  DateTime selectedDate = null;
//  DateTime selectedDate2 = null;
//  TimeOfDay selectedTime = null;
//  TimeOfDay selectedTime2 = null;

  _EditBloodCampState({
    @required this.id,
    @required this.city,
    @required this.venue,
    @required this.contact,
    @required this.email,
    @required this.fromtime,
    @required this.totime,
    @required this.fromdate,
    @required this.todate,
  }) {
    int d;
    int y;
    int m;
    int hr;
    int min;
    String mon = '';
    String year = '';
    String minute = '';
    String hour = '';
    for (int i = 0; i < fromtime.length; i++) {
      if (fromtime[i] == ':') {
        break;
      }
      hour = hour + fromtime[i];
    }
    int i;
    i = fromtime[1] == ':' ? 2 : 3;
    for (i; i < fromtime.length - 2; i++) {
      minute = minute + fromtime[i];
    }
    hr = int.parse(hour);
    min = int.parse(minute);
    if (fromtime[fromtime.length - 2] == 'a') {
      if (hr == 12) {
        hr = 0;
      }
    } else {
      if (hr != 12) {
        hr = hr + 12;
      }
    }
    selectedTime = TimeOfDay(hour: hr, minute: min);

    minute = '';
    hour = '';
    min = 0;
    hr = 0;
    i = 0;
    for (int i = 0; i < totime.length; i++) {
      if (totime[i] == ':') {
        break;
      }
      hour = hour + totime[i];
    }
    i = totime[1] == ':' ? 2 : 3;
    for (i; i < totime.length - 2; i++) {
      minute = minute + totime[i];
    }
    hr = int.parse(hour);
    min = int.parse(minute);
    if (totime[totime.length - 2] == 'a') {
      if (hr == 12) {
        hr = 0;
      }
    } else {
      if (hr != 12) {
        hr = hr + 12;
      }
    }
    selectedTime2 = TimeOfDay(hour: hr, minute: min);


    d = int.parse('${fromdate[0]}${fromdate[1] == '/' ? '' : fromdate[1]}');
    for (int i = 2; i < fromdate.length - 5; i++) {
      if (fromdate[i] == '/') {
        continue;
      } else {
        mon = mon + fromdate[i];
      }
    }
    m = int.parse(mon);
    for (int i = fromdate.length - 4; i < fromdate.length; i++) {
      if (fromdate[i] == '/') {
        continue;
      } else {
        year = year + fromdate[i];
      }
    }
    y = int.parse(year);
    selectedDate = DateTime(y, m, d);

    mon = '';
    year = '';

    d = int.parse('${todate[0]}${todate[1] == '/' ? '' : todate[1]}');
    for (int i = 2; i < todate.length - 5; i++) {
      if (todate[i] == '/') {
        continue;
      } else {
        mon = mon + todate[i];
      }
    }
    m = int.parse(mon);
    for (int i = todate.length - 4; i < todate.length; i++) {
      if (todate[i] == '/') {
        continue;
      } else {
        year = year + todate[i];
      }
    }
    y = int.parse(year);
    selectedDate2 = DateTime(y, m, d);

    dropdownCValue = this.city;
  }

  @override


  DateTime selectedDate = null;
  DateTime selectedDate2 = null;
  TimeOfDay selectedTime = null;
  TimeOfDay selectedTime2 = null;

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
        "Kindly Choose From Date.",
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
  showEmptyDateAlertDialog2(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Kindly Choose To Date.",
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
  showToDateAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "To Date should be greater than or equals to From Date",
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
  showFromDateAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "From Date should be less than or equals to To-Date",
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
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year - 2,
      ),
      lastDate: DateTime(DateTime.now().year + 10),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      bool c = false;
      DateTime check = pickedDate;
      if (selectedDate2 == null || check.year < selectedDate2.year) {
        c = true;
      } else if (check.year == selectedDate2.year) {
        if (check.month < selectedDate2.month) {
          c = true;
        } else if (check.month == selectedDate2.month) {
          if (check.day <= selectedDate2.day) {
            c = true;
          }
        }
      }
      if (c == true) {
        setState(() {
          selectedDate = pickedDate;
          fromdate =
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        });
      } else {
        showFromDateAlertDialog(context);
      }
    });
  }
  void _presentDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year - 2,
      ),
      lastDate: DateTime(DateTime.now().year + 10),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      bool c = false;
      DateTime check = pickedDate;
      if (selectedDate == null || check.year > selectedDate.year) {
        c = true;
      } else if (check.year == selectedDate.year) {
        if (check.month > selectedDate.month) {
          c = true;
        } else if (check.month == selectedDate.month) {
          if (check.day >= selectedDate.day) {
            c = true;
          }
        }
      }
      if (c == true) {
        setState(() {
          selectedDate2 = pickedDate;
          todate =
              '${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}';
        });
      } else {
        showToDateAlertDialog(context);
      }
    });
  }

  showEmptyTimeAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Kindly Choose From Time.",
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
  showEmptyTimeAlertDialog2(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Kindly Choose To Time.",
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
  void _presentTimePicker() {
    showTimePicker(context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false, ),
            child: child,
          );
        }
    ).then((pickedTime){
      if (pickedTime == null) {
        return;
      }
      setState(() {
        selectedTime = pickedTime;
        fromtime =
        '${selectedTime.hour == 0 ? 12 : (selectedTime.hour > 12 ?
        selectedTime.hour - 12 : selectedTime.hour)}:'
            '${selectedTime.minute.toString().length == 1 ?
        '0'+selectedTime.minute.toString() :
        selectedTime.minute}${selectedTime.hour > 11 ?
        'pm' : 'am'}';
      });
    });


  }
  void _presentTimePicker2() {
    showTimePicker(context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false, ),
            child: child,
          );
        }
    ).then((pickedTime){
      if (pickedTime == null) {
        return;
      }
      setState(() {
        selectedTime2 = pickedTime;
        totime =
        '${selectedTime2.hour == 0 ? 12 : (selectedTime2.hour > 12 ?
        selectedTime2.hour - 12 : selectedTime2.hour)}:'
            '${selectedTime2.minute.toString().length == 1 ?
        '0'+selectedTime2.minute.toString() :
        selectedTime2.minute}${selectedTime2.hour > 11 ?
        'pm' : 'am'}';
      });
    });


  }

  showAlertDialog(BuildContext context) {
    // set up the button
    // set up the AlertDialog
    if (selectedDate == null) {
      showEmptyDateAlertDialog(context);
      return;
    } else if (selectedDate2 == null) {
      showEmptyDateAlertDialog(context);
      return;
    }
    if(selectedTime == null)
    {
      showEmptyTimeAlertDialog(context);
      return;
    }
    else if(selectedTime2 == null)
    {
      showEmptyTimeAlertDialog2(context);
      return;
    }

    AlertDialog alert = AlertDialog(
      title: Text(
        "Congratulations",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Blood Camp Details Updated Successfully.",
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

  void updateData(
    String id,
    String city,
    String venue,
    String contact,
    String email,
    String fromtime,
    String totime,
    String fromdate,
    String todate,
  ) {
    final Map<String, String> registerVal = {
      'id': id,
      'city': city,
      'venue': venue,
      'email': email,
      'fromdate': fromdate,
      'totime': totime,
      'todate': todate,
      'fromtime': fromtime,
      'contact': contact,
    };

    http
        .put('https://lifesource-da676.firebaseio.com/bloodcamps/${id}.json',
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
                          "Venue",
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
                          initialValue: venue,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            labelText: 'Enter Venue',
                          ),
                          onChanged: (String val) {
                            venue = val;
                          },
                          validator: (String val) {
                            if (val.isEmpty)
                              return 'Please Enter Venue';
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
                            initialValue: email,
                            cursorColor: Colors.redAccent,
                            decoration: InputDecoration(
                                labelText: 'Enter Email Address'),
                            validator: validateEmail,
                            onChanged: (String val) {
                              email = val;
                            },
                          ))
                    ],
                  ),
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
                            "From Time",
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
                                Text(selectedTime == null
                                    ? 'No Time Chosen!'
                                    :  '${selectedTime.hour == 0 ? 12 : (selectedTime.hour > 12 ?
                                selectedTime.hour - 12 : selectedTime.hour)}:'
                                    '${selectedTime.minute.toString().length == 1 ?
                                '0'+selectedTime.minute.toString() :
                                selectedTime.minute}${selectedTime.hour > 11 ?
                                'pm' : 'am'}'),
                                FlatButton(
                                  child: Text(
                                    'Choose Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  textColor: Colors.grey,
                                  padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                                  highlightColor: Colors.grey,
                                  onPressed: _presentTimePicker,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                            "To Time",
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
                                Text(selectedTime2 == null
                                    ? 'No Time Chosen!'
                                    :  '${selectedTime2.hour == 0 ? 12 : (selectedTime2.hour > 12 ?
                                selectedTime2.hour - 12 : selectedTime2.hour)}:'
                                    '${selectedTime2.minute.toString().length == 1 ?
                                '0'+selectedTime2.minute.toString() :
                                selectedTime2.minute}${selectedTime2.hour > 11 ?
                                'pm' : 'am'}'),
                                FlatButton(
                                  child: Text(
                                    'Choose Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  textColor: Colors.grey,
                                  padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                                  highlightColor: Colors.grey,
                                  onPressed: _presentTimePicker2,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                            "From Date",
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
                                  padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
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
                            "To Date",
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
                                Text(selectedDate2 == null
                                    ? 'No Date Chosen!'
                                    : '${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}'),
                                FlatButton(
                                  child: Text(
                                    'Choose Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  textColor: Colors.grey,
                                  padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                                  highlightColor: Colors.grey,
                                  onPressed: _presentDatePicker2,
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
                            city = newValue;
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
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                                updateData(id, city, venue, contact, email,
                                    fromtime, totime, fromdate, todate);
                              }
                            });
                          },
                          child: Text(
                            '     UPDATE     ',
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
