import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Donate.dart';
import 'EditDonor.dart';
import 'package:http/http.dart' as http;

class AdminDonors extends StatefulWidget {
  @override
  _AdminDonorsState createState() => _AdminDonorsState();
}

class _AdminDonorsState extends State<AdminDonors> {
  showAlertDialog(BuildContext context, int index) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Do you really want to delete this data?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("YES"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              setState(() {
                deletedata(index);
              });
            });
          },
        ),
        FlatButton(
          child: Text("NO"),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              lFetchData = fetchdata();
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

  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/donor.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'name': data['name'],
            'email': data['email'],
            'gender': data['gender'],
            'dob': data['dob'],
            'cnic': data['cnic'],
            'contact': data['contact'],
            'city': data['city'],
            'history': data['history'],
            'status': data['status'],
            'bloodgroup': data['bloodgroup'],
          };

          listFetchData.add(fdata);
        });
      });
    });
    return listFetchData;
  }

  void deletedata(int index) {
    final String val = lFetchData[index]['id'];
    lFetchData.removeAt(index);
    http
        .delete('https://lifesource-da676.firebaseio.com/donor/${val}.json')
        .then((http.Response response) {
      print(response.body);
    });
  }

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  void updateTransaction(
    BuildContext ctx, {
    @required id,
    @required name,
    @required email,
    @required gender,
    @required dob,
    @required cnic,
    @required contact,
    @required city,
    @required history,
    @required status,
    @required bloodgroup,
  }) {
    setState(() {
      Future<void> future = showModalBottomSheet(
        context: ctx,
        isDismissible: true,
//      isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: MediaQuery.of(context).viewInsets,
//            color: Color(0xFF737373),
              child: EditDonor(
                id: id,
                name: name,
                email: email,
                gender: gender,
                dob: dob,
                cnic: cnic,
                contact: contact,
                city: city,
                history: history,
                status: status,
                bloodgroup: bloodgroup,
              ),
            ),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
      future.then((_) {
        setState(() {
          lFetchData = fetchdata();
        });
      });
    });

  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        errorColor: Colors.red,
      ),
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.red,
                expandedHeight: 200.0,
                floating: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        lFetchData = fetchdata();
                      });
                    },
                  ),
                ],
//              leading:
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  // print('constraints=' + constraints.toString());
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text('Donors'),
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
          body: ListView.builder(
            itemBuilder: (ctx, index) {
              return Dismissible(
                background: stackBehindDismiss(),
                key: ObjectKey(lFetchData[index]),
                onDismissed: (direction) {
                  showAlertDialog(context, index);
                },
                child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    //list tile is another option instad of card, leading is the first thing,
//                  circle avatar is the round widget, mostly used for image

                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
                      foregroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('${lFetchData[index]['bloodgroup']}'),
                        ),
                      ),
                    ),
                    title: Container(
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
//                              name
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'NAME',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['name']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              email
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'EMAIL',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['email']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              gender
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'GENDER',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['gender']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              dob
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'DATE OF BIRTH',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['dob']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              contact
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'CONTACT',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['contact']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              cnic
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'CNIC',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['cnic']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              city
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Text(
                                        'CITY',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['city']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              status
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'STATUS',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['status']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
//                              history
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'HISTORY',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[index]['history']}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        updateTransaction(
                          context,
                          id: lFetchData[index]['id'],
                          name: lFetchData[index]['name'],
                          email: lFetchData[index]['email'],
                          gender: lFetchData[index]['gender'],
                          dob: lFetchData[index]['dob'],
                          cnic: lFetchData[index]['cnic'],
                          contact: lFetchData[index]['contact'],
                          city: lFetchData[index]['city'],
                          history: lFetchData[index]['history'],
                          status: lFetchData[index]['status'],
                          bloodgroup: lFetchData[index]['bloodgroup'],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: lFetchData.length,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            setState(() {
              Future<void> future = Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Donate(
                    name: "Donor Registration Form",
                  ),
                ),
              );
              future.then((_) {
                lFetchData = fetchdata();
              });
            });
          },
        ),
      ),

      //Listview
    );
  }
}
