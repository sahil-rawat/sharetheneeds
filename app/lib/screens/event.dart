import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hacknu/task_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class AddEvent extends StatefulWidget {
  static const String id = "AddEvent";
  AddEvent({
    Key key,
  }) : super(key: key);
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String name;
  String address;
  String phoneno;
  String items = '';
  String city;
  String timing;
  List _myitems;
  String food = 'food';
  String clothes = 'clothes';
  String water = 'water';
  String medicines = 'medicines';
  int count = 0;

  final formKey = new GlobalKey<FormState>();
  final _firestore = Firestore.instance;
  final namecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonenocontroller = TextEditingController();
  final itemscontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final timimgcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myitems = [];
  }

  void item() {
    if (_myitems.contains(food)) {
      _firestore.collection('food').add({
        'name': name,
        'address': address,
        'item': items,
        'phone': int.parse(phoneno),
        'city': city,
      });
    }
    if (_myitems.contains(clothes)) {
      _firestore.collection('clothes').add({
        'name': name,
        'address': address,
        'item': items,
        'phone': int.parse(phoneno),
        'city': city,
      });
    }
    if (_myitems.contains(medicines)) {
      _firestore.collection('medicine').add({
        'name': name,
        'address': address,
        'item': items,
        'phone': int.parse(phoneno),
        'city': city,
      });
    }
    if (_myitems.contains(water)) {
      _firestore.collection('water').add({
        'name': name,
        'address': address,
        'item': items,
        'phone': int.parse(phoneno),
        'city': city,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return MaterialApp(
      home: Material(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: const EdgeInsets.all(30.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Text(
                  'Add Essentials',
                  style:
                      TextStyle(color: hexToColor("#F2A03D"), fontSize: 30.0),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ), // Name
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    phoneno = value;
                  },
                  controller: phonenocontroller,
                  decoration: InputDecoration(
                    labelText: "Phone No",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Phone No cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ), //Phone No
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    address = value;
                  },
                  controller: addresscontroller,
                  decoration: InputDecoration(
                    labelText: "Address (eg: Gandhi park)",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "This field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ), //Address
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  controller: citycontroller,
                  decoration: InputDecoration(
                    labelText: "City (eg: Jaipur)",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "This field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ), //Address
                SizedBox(
                  height: 10,
                ),

                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          autovalidate: false,
                          titleText: 'ITEMS',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Please select one or more options';
                            }
                          },
                          dataSource: [
                            {
                              "display": food,
                              "value": food,
                            },
                            {
                              "display": clothes,
                              "value": clothes,
                            },
                            {
                              "display": medicines,
                              "value": medicines,
                            },
                            {
                              "display": water,
                              "value": water,
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          // required: true,
                          hintText: 'Please choose one or more',
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myitems = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: RaisedButton(
                          child: Text('Save'),
                          onPressed: () {
                            setState(() {
                              count = count + 1;
                              print(_myitems);
                              if (count == 1) {
                                for (int i = 0; i < _myitems.length - 1; i++) {
                                  items = items + _myitems[i] + ",";
                                }
                                items = items + _myitems[_myitems.length - 1];
                                print(items + _myitems[_myitems.length - 1]);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text("Alert"),
                                        content: Text("Save Button Clicked"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                                count = 1;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    timing = value;
                  },
                  controller: timimgcontroller,
                  decoration: InputDecoration(
                    labelText: "Timing (eg: 4PM to 6PM )",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "This field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  color: Colors.green,
                  elevation: 5.0,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    if (count == 1) {
                      namecontroller.clear();
                      phonenocontroller.clear();
                      addresscontroller.clear();
                      citycontroller.clear();
                      itemscontroller.clear();
                      timimgcontroller.clear();
                      item();
                      Provider.of<TaskData>(context, listen: false)
                          .addEvent(name, address, phoneno, items, city);
                      Navigator.pop(context);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text("Alert"),
                              content: Text("Save Button not Clicked"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Text("Submit"),
                ) //Timing
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
