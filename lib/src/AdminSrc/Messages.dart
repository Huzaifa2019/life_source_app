import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
        .delete('https://lifesource-da676.firebaseio.com/messages/${val}.json')
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

  List<Map<String, dynamic>> lFetchData;

  List<Map<String, dynamic>> fetchdata() {
    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/messages.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          final fdata = {
            'id': ID,
            'name': data['name'],
            'email': data['email'],
            'subject': data['subject'],
            'message': data['message'],
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          errorColor: Colors.redAccent,
//          iconTheme: IconThemeData(color: Colors.redAccent),
        ),
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                      title: Text("Messages"),
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
                    key: ObjectKey(lFetchData[lFetchData.length - index - 1]),
                    onDismissed: (direction) {
                      showAlertDialog(context, lFetchData.length - index - 1);
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
                                    '${lFetchData[lFetchData.length - index - 1]['name']}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${lFetchData[lFetchData.length - index - 1]['email']}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    '${lFetchData[lFetchData.length - index - 1]['subject']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    '${lFetchData[lFetchData.length - index - 1]['message']}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: lFetchData.length,
              ),
            ),
          ),
        ));
  }
}
