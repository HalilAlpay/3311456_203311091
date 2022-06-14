import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yuvamolsun/mainhome.dart';

import 'anasayfa.dart';

class PageGetStared extends StatefulWidget {
  @override
  _PageGetStaredState createState() => _PageGetStaredState();
}

class _PageGetStaredState extends State<PageGetStared> {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PageCategories()));
        });
      } else {
        print('object');
      }
    } catch (e) {
      print(e);
    }
  }

  final _auth = FirebaseAuth.instance;
  String email = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String password = '';

  @override
  Widget build(BuildContext context) {
    void _showDialog(String exception) {
      // flutter defined function
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(exception),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Giriş Yap',
          style: TextStyle(fontSize: 30, color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 10)
                  ],
                ),
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                margin: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.person_outline),
                          labelText: "EPOSTA",
                          border: InputBorder.none,
                          labelStyle: TextStyle(fontSize: 20)),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline),
                          labelText: "SIFRE",
                          border: InputBorder.none,
                          labelStyle: TextStyle(fontSize: 20)),
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: MaterialButton(
                  color: Color(0xFFFF6969),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Route route = MaterialPageRoute(
                            builder: (context) => PageCategories());
                        Navigator.push(context, route);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          duration: Duration(milliseconds: 1200),
                        ),
                      );
                    }

                    //Navigator.pushReplacementNamed(context, "/PageHome");
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("GIRIS YAP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NeusaNextPro',
                                  fontWeight: FontWeight.bold)),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.chevron_right,
                              color: Color(0xFFFF6969)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: MaterialButton(
                  color: Color(0xFFFF6969),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: ()async{
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Route route = MaterialPageRoute(
                            builder: (context) => PageCategories());
                        Navigator.push(context, route);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          duration: Duration(milliseconds: 1200),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("KAYIT OL",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NeusaNextPro',
                                  fontWeight: FontWeight.bold)),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.chevron_right,
                              color: Color(0xFFFF6969)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
