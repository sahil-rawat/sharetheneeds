import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hacknu/screens/log_in.dart';
import 'package:hacknu/screens/event.dart';
import 'package:hacknu/task_list.dart';
import 'package:hacknu/screens/ourvision.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hacknu/task_data.dart';
import 'package:hacknu/taskclothes_list.dart';
import 'package:hacknu/taskfood_list.dart';
import 'package:hacknu/taskmedicine_list.dart';
import 'package:hacknu/taskwater_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:translator/translator.dart';

class MainScreen extends StatefulWidget {
  static const String id = "MainScreen";
  MainScreen({
    Key key,
    this.Sign_out_google,
    this.user,
    this.name,
    this.email,
    this.Sign_out_phone,
    this.logout,
    this.Longitude,
    this.Latitude,
    this.users,
  }) : super(key: key);
  final Function Sign_out_google;
  final bool logout;
  final Function Sign_out_phone;
  final String email;
  final String name;
  final FirebaseUser user;
  final double Latitude;
  final double Longitude;
  final int users;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _firestore = Firestore.instance;
  TaskData t = new TaskData();
  String SelectedItem = 'recent';
  String food='food';
  String water='water';
  String clothes='clothes';
  String medicine='medicine';
  String recent='recent';

  void main() async {
    final translator = new GoogleTranslator();
    translator.translate(recent, from: 'en', to: 'hi').then((output) {
      print(output);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodStream();
    clothesStream();
    medicineStream();
    waterStream();
  }

  void foodStream() async {
    await for (var snapshot in _firestore.collection('food').snapshots()) {
      for (var message in snapshot.documents) {
        Provider.of<TaskData>(context, listen: false).addFoodEvent(
            name: message.data['name'],
            Address: message.data['address'],
            City: message.data['city'],
            items: message.data['item'],
            Phoneno: message.data['phone'].toString());
      }
    }
  }

  void clothesStream() async {
    await for (var snapshot in _firestore.collection('clothes').snapshots()) {
      for (var message in snapshot.documents) {
        Provider.of<TaskData>(context, listen: false).addClothesEvent(
            name: message.data['name'],
            Address: message.data['address'],
            City: message.data['city'],
            items: message.data['item'],
            Phoneno: message.data['phone'].toString());
      }
    }
  }

  void waterStream() async {
    await for (var snapshot in _firestore.collection('water').snapshots()) {
      for (var message in snapshot.documents) {
        Provider.of<TaskData>(context, listen: false).addWaterEvent(
            name: message.data['name'],
            Address: message.data['address'],
            City: message.data['city'],
            items: message.data['item'],
            Phoneno: message.data['phone'].toString());
      }
    }
  }

  void medicineStream() async {
    await for (var snapshot in _firestore.collection('medicine').snapshots()) {
      for (var message in snapshot.documents) {
        Provider.of<TaskData>(context, listen: false).addMedicineEvent(
            name: message.data['name'],
            Address: message.data['address'],
            City: message.data['city'],
            items: message.data['item'],
            Phoneno: message.data['phone'].toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownMenuItem(
            child: DropdownButton<String>(
              value: SelectedItem,
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        MaterialCommunityIcons.food,
                        color: Colors.brown,
                      ),
                      SizedBox(width: 20,),
                      Text('Food (खाना)')
                    ],
                  ),
                  value: 'food',
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        MaterialCommunityIcons.tshirt_crew_outline,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 20,),
                      Text('Clothes (वस्त्र)')
                    ],
                  ),
                  value: 'clothes',
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Ionicons.ios_water,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 20,),
                      Text('Water (पानी)'),
                    ],
                  ),
                  value: 'water',
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Ionicons.ios_medkit,
                        color: Colors.red,
                      ),
                      SizedBox(width: 20,),
                      Text('Medic (दवाइयाँ)'),
                    ],
                  ),
                  value: 'medicine',
                ),
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(Feather.arrow_down_circle),
                      SizedBox(width: 20,),
                      Text('Recent (हाल का)'),
                    ],
                  ),
                  value: 'recent',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  SelectedItem = value;
                });
              },
            ),
          )
        ],
        elevation: debugDefaultTargetPlatformOverride == TargetPlatform.android
            ? 5.0
            : 0.0,
      ),
      body: (SelectedItem == 'food')
          ? FoodList()
          : (SelectedItem == 'water')
              ? WaterList()
              : (SelectedItem == 'clothes')
                  ? ClothesList()
                  : (SelectedItem == 'medicine') ? MedicineList() : EventList(),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
              child: UserAccountsDrawerHeader(
                accountName: Text(widget.name),
                accountEmail: widget.logout ? Text(widget.email) : null,
                currentAccountPicture: new CircleAvatar(
                  child: Text(widget.name[0].toUpperCase()),
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  //
                },
                title: new Text('Profile'),
                leading: Icon(Icons.info),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, OurVision.id);
                },
                title: new Text('Our Vision  (हमारी दृष्टि)'),
                leading: Icon(Icons.visibility),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => AddEvent(),
                  );
                },
                title: new Text('Add Essentials'),
                leading: Icon(Icons.playlist_add),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: new Text('Profile'),
                leading: Icon(FontAwesomeIcons.info),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            new Divider(
              thickness: 4,
              color: Colors.redAccent,
            ),
            widget.logout
                ? ListTile(
                    title: Text('Log Out'),
                    onTap: () {
                      widget.Sign_out_google();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content: Text("Google Account Logged out"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.pushNamed(context, LogIn.id);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  )
                : ListTile(
                    title: Text("Logout Phone"),
                    onTap: () {
                      // ignore: unnecessary_statements
                      widget.Sign_out_phone;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alert"),
                            content: Text("Phone account Logged out"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.pushNamed(context, LogIn.id);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
