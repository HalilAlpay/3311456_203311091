import 'package:flutter/material.dart';



class Msjlar extends StatefulWidget {
  @override
  _MsjlarState createState() => _MsjlarState();
}

class _MsjlarState extends State<Msjlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:   Text('Mesajlar', style: TextStyle(fontSize: 30, color: Colors.grey),),

        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[

            Center(
              child: Text("Mesajlar Özelliğimiz \nÇok Yakında Aktif Olacaktır",
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
            ),
          ],
        ),
      ),
    );
  }
}
