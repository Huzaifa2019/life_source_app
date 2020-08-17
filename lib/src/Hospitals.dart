import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewHospitals extends StatefulWidget {
  String name;

  ViewHospitals({@required this.name}) {}

  @override
  _ViewHospitalsState createState() => _ViewHospitalsState();
}

class _ViewHospitalsState extends State<ViewHospitals> {
  var top = 0.0;
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

//  void up() {
//    final fdata = {
//      'name': "SAIFEE HOSPITAL",
//      'address': "St-1, Block F North Nazimabad Town, Karachi, Sindh 74700",
//      'contact': "021-36789400",
//    };
//    http
//        .post('https://lifesource-da676.firebaseio.com/hospitals.json',
//        headers: <String, String>{
//          'Content-Type': 'application/json; charset=UTF-8',
//        },
//        body: jsonEncode(fdata))
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
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
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
        body: Align(
          alignment: Alignment.topLeft,
          child: ListView.builder(
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
      ),
    ));
  }
}
