import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BloodStock extends StatefulWidget {
  @override
  _BloodStockState createState() => _BloodStockState();
}

class _BloodStockState extends State<BloodStock> {
  var top = 0.0;
  Map<String, dynamic> bloodgroup = {
    'A+': 0,
    'A-': 0,
    'AB+': 0,
    'AB-': 0,
    'B+': 0,
    'B-': 0,
    'O+': 0,
    'O-': 0
  };

  void fetchdata() {
    bloodgroup['A+'] = 0;
    bloodgroup['A-'] = 0;
    bloodgroup['AB+'] = 0;
    bloodgroup['AB-'] = 0;
    bloodgroup['B+'] = 0;
    bloodgroup['B-'] = 0;
    bloodgroup['O+'] = 0;
    bloodgroup['O-'] = 0;

    List<Map<String, dynamic>> listFetchData = [];
    Map<String, dynamic> result;
    http
        .get('https://lifesource-da676.firebaseio.com/donor.json')
        .then((http.Response response) {
      result = jsonDecode(response.body);
      setState(() {
        result.forEach((String ID, dynamic data) {
          if (data['status'] == 'ELIGIBLE') {
            bloodgroup[data['bloodgroup']] = bloodgroup[data['bloodgroup']] + 1;
          }
          final fdata = {
            'status': data['status'],
            'bloodgroup': data['bloodgroup'],
          };

          listFetchData.add(fdata);
        });
      });
//      print(listFetchData);
    });
  }

  List<Map<String, Object>> get groupTransactions {
    return List.generate(
      8,
      (index) {
        List<String> bg = ['A+', 'A-', 'AB+', 'AB-', 'B+', 'B-', 'O+', 'O-'];
        double totalSum = 0;

        int val = bloodgroup[bg[index]];
        for (int i = 0; i < bg.length; i++) {
          totalSum = totalSum + bloodgroup[bg[i]];
        }
        double percent = (val == 0 && totalSum == 0) ? 0 : (val / totalSum);

        return {
          'day': bg[index],
          'percent': percent,
          'val': val,
        };
      },
    ).toList();
  }

  initState() {
    fetchdata();
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
                      fetchdata();
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
                  title: Text("Blood Stock"),
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
        body: Column(
          children: <Widget>[
            Container(
              child: Card(
                elevation: 6,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: groupTransactions.map((data) {
//          Text(data['day'].toString() +' : ' + data['amount'].toString(),)
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 20,
                            child: FittedBox(
                              child: Text('${data['val']}'),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 80,
                            width: 10,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    color: Color.fromRGBO(220, 220, 220, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                FractionallySizedBox(
                                  heightFactor: (data['percent']),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 20,
                            child: FittedBox(
                              child: Text('${data['day']}'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    ));
  }
}
