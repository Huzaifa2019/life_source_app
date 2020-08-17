import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'AdminSrc/EditDonor.dart';

class ViewDonors extends StatefulWidget {
  String name;

  ViewDonors({
    @required this.name,
  });

  @override
  _ViewDonorsState createState() => _ViewDonorsState();
}

class _ViewDonorsState extends State<ViewDonors> {
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

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  var top = 0.0;

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
          Navigator.of(context).pop();
          lFetchData = fetchdata();
        });
      });
    });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Donor ID is incorrect! Please try again.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
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

  var ValidateKey = GlobalKey<FormState>();
  String newDonorId = '';

  void edit(BuildContext ctx) {
    setState(() {
      showModalBottomSheet(
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
              child: Form(
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
                                    "Enter Donor ID\n(To Update Data)",
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
                                      labelText: 'Enter ID',
                                    ),
                                    onChanged: (String val) {
                                      newDonorId = val;
                                    },
                                    validator: (String val) {
                                      if (val.isEmpty)
                                        return 'Please Enter ID';
                                      else
                                        return null;
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
                                        bool check = false;
                                        if (ValidateKey.currentState
                                            .validate()) {
                                          for (int i = 0;
                                              i < lFetchData.length;
                                              i++)
                                            if (lFetchData[i]['id'] ==
                                                newDonorId) {
                                              check = true;
                                              updateTransaction(
                                                ctx,
                                                id: lFetchData[i]['id'],
                                                name: lFetchData[i]['name'],
                                                email: lFetchData[i]['email'],
                                                gender: lFetchData[i]['gender'],
                                                dob: lFetchData[i]['dob'],
                                                cnic: lFetchData[i]['cnic'],
                                                contact: lFetchData[i]
                                                    ['contact'],
                                                city: lFetchData[i]['city'],
                                                history: lFetchData[i]
                                                    ['history'],
                                                status: lFetchData[i]['status'],
                                                bloodgroup: lFetchData[i]
                                                    ['bloodgroup'],
                                              );
                                              break;
                                            }
                                          if (check == false) {
                                            showAlertDialog(context);
                                          }
                                        }
                                      });
                                    },
                                    child: Text(
                                      '     EDIT     ',
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
              ),
            ),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
    });
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
          body: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
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
                  title: Text('${lFetchData[index]['name']}'),
                  subtitle: Text(
                    '${lFetchData[index]['status']}',
                  ),
//                          trailing: IconButton(
//                            icon: Icon(Icons.delete),
//                            onPressed: () {
//                            },
//                          ),
                ),
              );
            },
            itemCount: lFetchData.length,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
          ),
          onPressed: () {
            edit(context);
          },
        ),
      ),

      //Listview
    );
  }
}
