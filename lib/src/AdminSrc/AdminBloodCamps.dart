import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AddBloodCamp.dart';
import 'EditBloodCamp.dart';

class AdminBloodCamps extends StatefulWidget {
  @override
  _AdminBloodCampsState createState() => _AdminBloodCampsState();
}

class _AdminBloodCampsState extends State<AdminBloodCamps> {
  var top = 0.0;
  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/bloodcamps.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'venue': data['venue'],
            "city": data['city'],
            "contact": data['contact'],
            "email": data['email'],
            "fromdate": data['fromdate'],
            "fromtime": data['fromtime'],
            "todate": data['todate'],
            'totime': data['totime'],
          };
          listFetchData.add(fdata);
        });
      });
    });
    return listFetchData;
  }

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
        .delete(
            'https://lifesource-da676.firebaseio.com/bloodcamps/${val}.json')
        .then((http.Response response) {
      print(response.body);
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

  void updateTransaction(
      BuildContext ctx, {
        @required id,
        @required city,
        @required venue,
        @required contact,
        @required email,
        @required fromtime,
        @required totime,
        @required fromdate,
        @required todate,
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
              child: EditBloodCamp(
                id: id,
                city: city,
                venue: venue,
                email: email,
                fromdate: fromdate,
                totime: totime,
                todate: todate,
                fromtime: fromtime,
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
              child: AddBloodCamp(),
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


  initState() {
    lFetchData = fetchdata();
    super.initState();
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
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: Text("Blood Camps"),
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
                child: Container(
                  child: Card(
                    shape: new RoundedRectangleBorder(
                      side: new BorderSide(
                          color: Color.fromRGBO(239, 83, 73, 0.2), width: 1.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
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
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
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
                                          'VENUE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '${lFetchData[index]['venue']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
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
                                          'FROM DATE',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '${lFetchData[index]['fromdate']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                          'TO DATE',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '${lFetchData[index]['todate']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'FROM TIME',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '${lFetchData[index]['fromtime']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'TO TIME',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          '${lFetchData[index]['totime']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
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
                            city: lFetchData[index]['city'],
                            venue: lFetchData[index]['venue'],
                            email: lFetchData[index]['email'],
                            fromdate: lFetchData[index]['fromdate'],
                            totime: lFetchData[index]['totime'],
                            todate: lFetchData[index]['todate'],
                            fromtime: lFetchData[index]['fromtime'],
                            contact: lFetchData[index]['contact'],
                          );
                        },
                      ),
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
              addTransaction(context);
            });
          },
        ),
      ),
    );
  }
}
