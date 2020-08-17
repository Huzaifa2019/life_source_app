import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BloodCamps extends StatefulWidget {
  String name;

  BloodCamps({@required this.name});

  @override
  _BloodCampsState createState() => _BloodCampsState();
}

class _BloodCampsState extends State<BloodCamps> {
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

//  void up() {
//    final fdata = {
//      'venue': "9th Avenue",
//      "city": "KARACHI",
//      "contact": "0300-1234566",
//      "email": "abc@yahoo.com",
//      "fromdate": "01/5/2020",
//      "fromtime": "3:00pm",
//      "todate": "16/5/2020",
//      'totime': '8:00pm',
//    };
//    http
//        .post('https://lifesource-da676.firebaseio.com/bloodcamps.json',
//            headers: <String, String>{
//              'Content-Type': 'application/json; charset=UTF-8',
//            },
//            body: jsonEncode(fdata))
//        .then((http.Response response) {
//      print(jsonDecode(response.body));
//    });
//  }

  initState() {
    lFetchData = fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
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
              return Container(
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
//                          trailing: IconButton(
//                            icon: Icon(Icons.delete),
//                            onPressed: () {
//                            },
//                          ),
                  ),
                ),
              );
            },
            itemCount: lFetchData.length,
          ),
        ),
      ),
    );
  }
}
