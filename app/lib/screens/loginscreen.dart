import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'mainscreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(
      {Key key, this.logout, this.Username, this.Latitude, this.Longitude})
      : super(key: key);
  final bool logout;
  final String Username;
  final double Latitude;
  final double Longitude;
  static const String id = "LogInScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  String CountryCode = '+91 ';
  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  user: user,
                  Sign_out_phone: signOut(),
                  name: widget.Username,
                  Latitude: widget.Latitude,
                  Longitude: widget.Longitude,
                  logout: widget.logout,
                ),
              ),
            );
          } else {
            print("Error");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text("Alert"),
                    content: Text("Error"),
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

          //This callback would get called when verification is done automatically
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("OTP?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(
                                user: user,
                                Sign_out_phone: signOut(),
                                logout: widget.logout,
                                Longitude: widget.Longitude,
                                Latitude: widget.Latitude,
                                name: widget.Username,
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("Alert"),
                                  content: Text("Error"),
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
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: CountryCode,
                  labelText: "Mobile Number",
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
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text("LOGIN"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        final phone =
                            CountryCode + _phoneController.text.trim();
                        loginUser(phone, context);
                        setState(() {
                          startTimer();
                        });
                      },
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Text(
                      'Timer:$_start',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
