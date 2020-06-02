import 'package:flutter/material.dart';

class OurVision extends StatelessWidget {
  static const String id = "OurVision";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 60.0)),
                Center(
                  child: Text(
                    'OUR VISION',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(color: Colors.orangeAccent, fontSize: 35.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Text(
                  "If We Won't who will.",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  '''We at ShareTheNeeds are trying to bridge the gap between the peoples who need help and those who are ready to help. Serving the community is the best way of returning the favour we owe to our mother earth.  Using ShareTheNeeds App  Helping the needy is just a click away, You can organize camps and distribute the essential items to the needy people very easily.''',
                  style: TextStyle(fontSize: 17.0)
                  ,textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  "For the One in Need",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text("As the name suggests sharing the essential items with needy is one of the best thing that a human could do for humanity. If any person is in urgent need of some essential items he could easily look for it. Using ShareTheNeeds we provide a service where the person in need can easily find the camps nearby and the items they are providing. ",
                  style: TextStyle(fontSize: 17.0)
                  ,textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  "For The One Who Wants Help",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text("If you wanted to serve the community. Just organize a camp  and share the details with all the other people in need through ShareTheNeeds",
                  style: TextStyle(fontSize: 17.0)
                  ,textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
