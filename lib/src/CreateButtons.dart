import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'AboutUs.dart';
import 'Hospitals.dart';
import 'Donors.dart';
import 'BloodCamps.dart';
import 'ContactUs.dart';
import 'Login.dart';
import 'Donate.dart';
import 'Admin.dart';

class Button extends StatefulWidget {
  String name;

  Button({@required this.name});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  MaterialPageRoute donatepage()
  {
    MaterialPageRoute a;
    setState(() {
      a = new MaterialPageRoute(
          builder: (context) => new ViewDonors(
            name: "Donors",
          ));
    });

    return a;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      width: 200,
      child: RaisedButton(
        onPressed: () {
//          setState(() {
//
////            lFetchData = fetchdata();
//          });
          setState(() {
            if (widget.name == 'Donors')
              child:
            Navigator.push(
                context, donatepage()
                );

            if (widget.name == "Blood Camps")
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new BloodCamps(
                      name: "Blood Camps",
                    )));
            if (widget.name == 'Hospitals')
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ViewHospitals(
                      name: "Hospitals",
                    )));
            if (widget.name == 'Login')
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
//                        new Admin()
                    new Login(name: "Login"),
                ),
            );
            if (widget.name == 'About us')
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AboutUs(
                      name: "About us",
                    )));
            if (widget.name == 'Donate Now')
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Donate(
                      name: "Donor Registration Form",
                    )));
            if (widget.name == 'Contact us')
              child:
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ContactUs(
                      name: "Contact us",
                    )));
          });
        },
        color: Colors.red,
        child: Text(widget.name),
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
        highlightColor: Colors.grey,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}