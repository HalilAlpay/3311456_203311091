import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuvamolsun/loginregister.dart';

import 'package:yuvamolsun/yorumlar.dart';

class HayvanBilgi extends StatefulWidget {
  HayvanBilgi({required this.hayvanId});
  String hayvanId;
  @override
  _HayvanBilgiState createState() => _HayvanBilgiState();
}

class _HayvanBilgiState extends State<HayvanBilgi> {
  @override
  void initState() {
    super.initState();
    print(silButonu);
    getCurrentUser();
    FirebaseFirestore.instance
        .collection('hayvanlar')
        .doc(widget.hayvanId)
        .snapshots()
        .first
        .then((value) {
      if (value.data()!['ekleyen'] == _auth.currentUser!.uid) {
        setState(() {
          silButonu = true;
        });
        print(silButonu);
      }
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print(user.email);
      } else {
        print('object');
      }
    } catch (e) {
      print(e);
    }
  }
  TextEditingController mesajController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool silButonu = false;
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Fotoğraf Yükleniyor"),
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:  Text("İlan Hakkında",
            style: TextStyle(
                color: Color(0xFF515C6F),
                fontSize: 30,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontFamily: 'NeusaNextPro')),
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                children: [

                  Spacer(),
                  silButonu
                      ? MaterialButton(
                          shape: RoundedRectangleBorder(),
                          color: Colors.orange,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('hayvanlar')
                                .doc(widget.hayvanId)
                                .delete()
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Ilani Kaldir',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('hayvanlar')
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index].id ==
                                widget.hayvanId) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 19),
                                      height: 210,
                                      width: 153,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]['foto']),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Türü: ' +
                                          snapshot.data!.docs[index]['turu']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Cinsi: ' +
                                          snapshot.data!.docs[index]['cinsi']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Yaşı: ' +
                                          snapshot.data!.docs[index]['yasi']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Cinsiyeti: ' +
                                          snapshot.data!.docs[index]
                                              ['cinsiyeti']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Aşıları: ' +
                                          snapshot.data!.docs[index]
                                              ['asilari']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Kısırlaştırma: ' +
                                          snapshot.data!.docs[index]
                                              ['kisirlastirma']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Eklenme Tarihi: ' +
                                          snapshot.data!
                                              .docs[index]['eklenmeTarihi']
                                              .toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text('Şehir: ' +
                                          snapshot.data!.docs[index]['konum']),
                                    ),
                                    SizedBox(height: 10,),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(),
                                      color: Colors.orange,
                                      onPressed: ()  {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Yorumlar(hayvanid: widget.hayvanId)));
                                      },
                                      child: Text(
                                        'Iletisime Gec',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          })
                      : Center(
                          child: CupertinoActivityIndicator(),
                        );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
