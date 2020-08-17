import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AboutUs extends StatefulWidget {
  String name;

  AboutUs({@required this.name});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool one = false;
  bool two = false;
  bool three = false;
  bool xyz = false;
  bool five = false;

  var top = 0.0;

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
          body: ListView(children: <Widget>[
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR0uMsaM0S_9-Z8sM1dZDBmJf_QylPYsUJ4aonX-pJ5xMkpLRJP&usqp=CAU",
                          height: 200,
                          width:
                              MediaQuery.of(context).copyWith().size.width / 2 -
                                  20,
                        ),
                      ),
                      SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width / 2 -
                                20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: <Widget>[
                              Text('Vision',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                  ),
                              ),
                              Text(
                                  "Donate today to save someone's tomorrow ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRNCoQV29O_i2yEq7zocBIX22QW_qZEO3a1WapkJh8ujK6L1m1z&usqp=CAU",
                          height: 200,
                          width:
                              MediaQuery.of(context).copyWith().size.width / 2 -
                                  20,
                        ),
                      ),
                      SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width / 2 -
                                20,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            children: <Widget>[
                              Text('Mission',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text("As a matter of humanity, we provide ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Frequently Asked Questions\n',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      //1
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            if (one == false) {
                              one = true;
                            } else {
                              one = false;
                            }
                          });
                        },
                        color: Colors.black.withOpacity(0.00),
                        child: Text(
                          "1.    Answers for FAQs on Donating Blood In which situations do people generally donate blood?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        textColor: Colors.red,
                        //highlightColor:  Colors.grey,
                      ),
                      one
                          ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "There are three types of blood donors:" +
                                    "(1) PROFESSIONAL DONORS – They sell their blood, which can be infectious and can transmit very dangerous diseases to the recipient. It is illegal to take blood from any professional donor.\n" +
                                    "(2) REPLACEMENT DONATION – Healthy relatives and friends of the patient give their blood, of any group, to the blood bank. In exchange, the required number of units in the required blood group is given.\n" +
                                    "(3) VOLUNTARY DONATION- Here a donor donates blood voluntarily. The blood can be used for any patient even without divulging the identity of the donor. This is the best type of blood donation " +
                                    "where a motivated human being gives blood in an act of selfless service.",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : SizedBox(),

                      //2
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            if (two == false) {
                              two = true;
                            } else {
                              two = false;
                            }
                          });
                        },
                        color: Colors.black.withOpacity(0.00),
                        child: Text(
                          "2.    Are there any other benefits of blood donation?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        textColor: Colors.red,
                        //highlightColor:  Colors.grey,
                      ),
                      two
                          ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Yes, blood donation is a noble, selfless service! It gives the donor a feeling of joy and contentment." +
                                    " Also this is an expression of love for Mankind, as blood knows no caste, color, creed, religion or race, country, continent or sex.",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : SizedBox(),

                      //3

                      FlatButton(
                        onPressed: () {
                          setState(() {
                            three = three == true ? false : true;
                          });
                        },
                        color: Colors.black.withOpacity(0.00),
                        child: Text(
                          "3.    Answers for FAQs on Transfusion In which situations do patients need blood transfusion?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        textColor: Colors.red,
                        //highlightColor:  Colors.grey,
                      ),
                      three
                          ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "There are many situations in which patients need blood to stay alive:" +
                                    "· A patient needs blood after a major accident in which there is loss of blood.\n" +
                                    "· No major surgery is performed without blood as there is bound to be blood loss.\n" +
                                    "· On an average, for every open heart surgery about 6 units of blood is required.\n" +
                                    "· In miscarriage or childbirth, cases the patient may need large amount of blood to be transfused for saving her life and also the child’s.",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : SizedBox(),

                      //4

                      FlatButton(
                          onPressed: () {
                            setState(() {
                              xyz = xyz == true ? false : true;
                            });
                          },
                          color: Colors.black.withOpacity(0.00),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              "4.Can a donor work after donating blood?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.red),
                            ),
                          )
                          //highlightColor:  Colors.grey,
                          ),
                      xyz
                          ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Of course! Routine work is absolutely fine after the initial rest. Rigorous physical work should be avoided for a few hours.",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : SizedBox(),
                      //5
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              five = five == true ? false : true;
                            });
                          },
                          color: Colors.black.withOpacity(0.00),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              "5.Do you test all the collected blood?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.red),
                            ),
                          )
                          //highlightColor:  Colors.grey,
                          ),
                      five
                          ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Yes. ALL the blood in the blood bank is tested for following, using the latest technology\n" +
                                    "· Hepatitis B C\n" +
                                    "· Malarial parasite\n" +
                                    "· HIV I II (AIDS)\n· Venereal disease (Syphilis)\n· Blood Group",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
