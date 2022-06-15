import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuvamolsun/hayvanbilgi.dart';
import 'package:yuvamolsun/hayvanekle.dart';
import 'package:yuvamolsun/loginregister.dart';
import 'package:yuvamolsun/mesajlar111.dart';
import 'package:pay/pay.dart';

import 'hayvanlar/kedi.dart';
import 'hayvanlar/kopek.dart';
import 'hayvanlar/kus.dart';

class PageCategories extends StatefulWidget {
  @override
  _PageCategoriesState createState() => _PageCategoriesState();
}

class _PageCategoriesState extends State<PageCategories> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
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

  final _auth = FirebaseAuth.instance;
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '00.01',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
  }

  void onGooglePayResult(paymentResult) {
    print('PAYMENT SUCCESFULL MU');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HayvanEkle()));
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Hoş Geldiniz ' + _auth.currentUser!.email.toString(),
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Spacer(),
              MaterialButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageGetStared()));
                  });
                },
                child: Text('Çıkış'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Text("Yuvam Olsun",
                    style: TextStyle(
                        color: Color(0xFF515C6F),
                        fontSize: 30,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NeusaNextPro')),
                Spacer(),
                GooglePayButton(
                  onError: (error) {
                    print(error);
                  },
                  paymentConfigurationAsset: 'a.json',
                  paymentItems: _paymentItems,
                  style: GooglePayButtonStyle.flat,
                  type: GooglePayButtonType.donate,
                  width: 150,
                  height: 40,
                  margin: EdgeInsets.zero,
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text("Son Eklenen Dostlar",
                style: TextStyle(
                    color: Color(0xFF515C6F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NeusaNextPro')),
            SizedBox(height: 25),
            Container(
              height: 210,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('hayvanlar')
                    .orderBy('eklenmeTarihi', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HayvanBilgi(
                                        hayvanId:
                                            snapshot.data!.docs[index].id),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 19),
                                height: 210,
                                width: 153,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshot.data!.docs[index]['foto']),
                                    )),
                              ),
                            );
                          })
                      : Center(
                          child: CupertinoActivityIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'YUVAM OLSUN',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: const Text('Anasayfa'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Msjlar()));
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('Bilgi Kartları'),
              trailing: Icon(Icons.arrow_drop_down),
              children: <Widget>[
                ListTile(
                  title: Text('Kedi'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KediBakimi()));
                  },
                ),
                ListTile(
                  title: Text('Köpek'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KopekBakimi()));
                  },
                ),
                ListTile(
                  title: Text('Kuş'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KusBakimi()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}