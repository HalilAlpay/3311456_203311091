import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuvamolsun/loginregister.dart';


class Yorumlar extends StatefulWidget {
  Yorumlar({required this.hayvanid});
  String hayvanid;
  @override
  _YorumlarState createState() => _YorumlarState();
}

class _YorumlarState extends State<Yorumlar> {
  @override
  void initState() {
    super.initState();
    print(silButonu);
    getCurrentUser();
    FirebaseFirestore.instance
        .collection('hayvanlar')
        .doc(widget.hayvanid)
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
bottomSheet: BottomAppBar(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
     ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: mesajController,
              maxLines: 4,
              minLines: 1,
              onChanged: (value) {

              },
              style: TextStyle(
                  fontSize: 12,

                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: 'Yorumunuzu Ekleyin...',
                  hintStyle: TextStyle(
                      fontSize: 15,

                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(

            onPressed: () {
              FirebaseFirestore.instance
                  .collection('hayvanlar')
                  .doc(widget.hayvanid)
                  .collection('yorumlar')
                  .add({'yorum': mesajController.text, 'yazar':_auth.currentUser!.uid, 'email':_auth.currentUser!.email, 'tarih':DateTime.now()}).then((value) {
                mesajController.clear();
              });
            },
            child: Text(
              'Yorumu Ekle',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                 ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    ),
  ),
),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:  Text("Yorumlar",
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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hayvanlar')
                  .doc(widget.hayvanid)
                  .collection('yorumlar').orderBy('tarih', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {

                return snapshot.hasData
                    ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {

                      if(snapshot.data!.docs.length != 0){
                        return   Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          child: snapshot.data!.docs[index]['yazar'] == _auth.currentUser!.uid  ? Row(
                            children: [Spacer(),

                              ChatBubble(
                                clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(top: 20),
                              backGroundColor: Colors.orange,
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Text(
                                      snapshot.data!.docs[index]['yorum'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),


                              IconButton(onPressed: (){

                                FirebaseFirestore.instance
                                    .collection('hayvanlar')
                                    .doc(widget.hayvanid)
                                    .collection('yorumlar').doc(snapshot.data!.docs[index].id).delete();

                              }, icon: Icon(Icons.delete), padding: EdgeInsets.zero,),
                            ],
                          ) : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]['email']),

                              ChatBubble(
                                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                backGroundColor: Colors.orange,
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: Text(
                                      snapshot.data!.docs[index]['yorum'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )


                            ],
                          ),
                        );
                      }else{
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
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
    );
  }
}
