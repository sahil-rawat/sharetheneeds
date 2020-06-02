import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String phoneno;
  final String address;
  final String items;
  final String city;
  final Function onlongpresscallback;

  EventCard(
      {this.items,
      this.name,
      this.city,
      this.phoneno,
      this.address,
      this.onlongpresscallback});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Future<void> _makePhoneCall() async {
    String Phone= 'tel:'+widget.phoneno;
    launch(Phone);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onlongpresscallback,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Stack(children: <Widget>[
            Align(
              child: Stack(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                          ),
                          Text(
                            'NAME(नाम): ${widget.name}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Address(पता) : ${widget.address},${widget.city.toUpperCase()}',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Items(सामग्री): ${widget.items}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'PHONE NUMBER: ${widget.phoneno}',
                            style: TextStyle(fontSize: 23),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.green[900],
                                elevation: 10,
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _makePhoneCall();
                                  });
                                },
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
