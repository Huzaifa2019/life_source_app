import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'AddHospital.dart';
import 'dart:convert';

import 'EditHospital.dart';

class AdminHospitals extends StatefulWidget {
  @override
  _AdminHospitalsState createState() => _AdminHospitalsState();
}

class _AdminHospitalsState extends State<AdminHospitals> {
  var top = 0.0;

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

  void deletedata(int index) {
    final String val = lFetchData[index]['id'];
    lFetchData.removeAt(index);
    http
        .delete('https://lifesource-da676.firebaseio.com/hospitals/${val}.json')
        .then((http.Response response) {
      print(response.body);
    });
  }

  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/hospitals.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'name': data['name'],
            'address': data['address'],
            'contact': data['contact'],
          };

          listFetchData.add(fdata);
        });
      });
    });
    return listFetchData;
  }

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  void updateTransaction(
    BuildContext ctx, {
    @required id,
    @required name,
    @required address,
    @required contact,
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
              child: EditHospital(
                id: id,
                name: name,
                address: address,
                contact: contact,
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

  void addTransaction(
      BuildContext ctx) {
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
              child: AddHospital(),
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
                    title: Text("Hospitals"),
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
          body: Align(
            alignment: Alignment.topLeft,
            child: ListView.builder(
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

                      title: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${lFetchData[index]['name']}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${lFetchData[index]['address']}',
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
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          updateTransaction(
                            context,
                            id: lFetchData[index]['id'],
                            name: lFetchData[index]['name'],
                            address: lFetchData[index]['address'],
                            contact: lFetchData[index]['contact'],
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
          setState(() {
            addTransaction(context);
          });
          },
        ),
      ),
    );
  }
}
