import 'package:flutter/material.dart';
class BilgiKart extends StatelessWidget {
  BilgiKart({required this.yazi1, required this.yazi2});

  String yazi1;
  String yazi2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.greenAccent[100],
      child: SizedBox(


        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                yazi1,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green[900],
                  fontWeight: FontWeight.w500,
                ),
              ), //Text
              SizedBox(
                height: 10,
              ),
              Text(
                yazi2,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
