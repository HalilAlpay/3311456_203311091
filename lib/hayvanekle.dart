import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuvamolsun/loginregister.dart';

class HayvanEkle extends StatefulWidget {
  @override
  _HayvanEkleState createState() => _HayvanEkleState();
}

class _HayvanEkleState extends State<HayvanEkle> {
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
  final ImagePicker _picker = ImagePicker();

  final _firebaseStorage = FirebaseStorage.instance;

  String? hayvanTuru;
  String? hayvanCinsiyeti;
  String? hayvanYasi;
  String? kisirlikDurumu;
  String? foto;
  String? asilari;
  String? hayvanCinsi;
  String? ilanAciklamasi;
  String? sehir;

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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          children: <Widget>[
            Text("Hayvan Ekle",
                style: TextStyle(
                    color: Color(0xFF515C6F),
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NeusaNextPro')),
            DropdownButton(
              hint:
                  Text('Hayvanın Türünü Seçiniz'), // Not necessary for Option 1
              value: hayvanTuru,
              onChanged: (newValue) {
                setState(() {
                  hayvanTuru = newValue.toString();
                });
              },
              items: [
                "At",
                "Balık",
                "Baykuş",
                "Fare",
                "Güvercin",
                "Hamster",
                "Hindi",
                "Horoz",
                "Kaplumbağa",
                "Karga",
                "Kartal",
                "Keçi",
                "Kedi",
                "Koyun",
                "Köpek",
                "Kurbağa",
                "Kuş",
                "Kuzu",
                "Maymun",
                "Ördek",
                "Papağan",
                "Penguen",
                "Serçe",
                "Tavşan",
                "Tavuk",
                "Tilki"
              ].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                hayvanCinsi = value;
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: "Hayvanın Cinsini Yazınız",
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 19),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
              hint: Text(
                  'Hayvanın Cinsiyetini Seçiniz'), // Not necessary for Option 1
              value: hayvanCinsiyeti,
              onChanged: (newValue) {
                setState(() {
                  hayvanCinsiyeti = newValue.toString();
                });
              },
              items: ['Erkek', 'Dişi'].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
              hint:
                  Text('Hayvanın Yaşını Seçiniz'), // Not necessary for Option 1
              value: hayvanYasi,
              onChanged: (newValue) {
                setState(() {
                  hayvanYasi = newValue.toString();
                });
              },
              items: [
                "0",
                "1",
                "2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
                "11",
                "12",
                "13",
                "14",
                "15",
                "16",
                "17",
                "18",
                "19",
                "20"
              ].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
              hint: Text(
                  'Hayvanın Kısırlık Durumu'), // Not necessary for Option 1
              value: kisirlikDurumu,
              onChanged: (newValue) {
                setState(() {
                  kisirlikDurumu = newValue.toString();
                });
              },
              items: ["Kısırlaştırıldı", "Kısırlaştırılmadı"].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
              hint: Text(
                  'Hayvanın Aşıları Yapıldı Mı'), // Not necessary for Option 1
              value: asilari,
              onChanged: (newValue) {
                setState(() {
                  asilari = newValue.toString();
                });
              },
              items: ["Yapıldı", "Yapılmadı"].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            DropdownButton(
              hint:
                  Text('Bulunduğunuz Şehri Seçiniz'), // Not necessary for Option 1
              value: sehir,
              onChanged: (newValue) {
                setState(() {
                  sehir = newValue.toString();
                });
              },
              items: [
                "Adana",
                "Adıyaman",
                "Afyon",
                "Ağrı",
                "Amasya",
                "Ankara",
                "Antalya",
                "Artvin",
                "Aydın",
                "Balıkesir",
                "Bilecik",
                "Bingöl",
                "Bitlis",
                "Bolu",
                "Burdur",
                "Bursa",
                "Çanakkale",
                "Çankırı",
                "Çorum",
                "Denizli",
                "Diyarbakır",
                "Edirne",
                "Elâzığ",
                "Erzincan",
                "Erzurum",
                "Eskişehir",
                "Gaziantep",
                "Giresun",
                "Gümüşhane",
                "Hakkâri",
                "Hatay",
                "Isparta",
                "Mersin",
                "İstanbul",
                "İzmir",
                "Kars",
                "Kastamonu",
                "Kayseri",
                "Kırklareli",
                "Kırşehir",
                "Kocaeli",
                "Konya",
                "Kütahya",
                "Malatya",
                "Manisa",
                "Kahramanmaraş",
                "Mardin",
                "Muğla",
                "Muş",
                "Nevşehir",
                "Niğde",
                "Ordu",
                "Rize",
                "Sakarya",
                "Samsun",
                "Siirt",
                "Sinop",
                "Sivas",
                "Tekirdağ",
                "Tokat",
                "Trabzon",
                "Tunceli",
                "Şanlıurfa",
                "Uşak",
                "Van",
                "Yozgat",
                "Zonguldak",
                "Aksaray",
                "Bayburt",
                "Karaman",
                "Kırıkkale",
                "Batman",
                "Şırnak",
                "Bartın",
                "Ardahan",
                "Iğdır",
                "Yalova",
                "Karabük",
                "Kilis",
                "Osmaniye",
                "Düzce",
              ].map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            TextField(
              onChanged: (value) {
                ilanAciklamasi = value;
              },
              maxLines: 8,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: "İlan Açıklaması",
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 19),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(),
              color: Colors.orange,
              onPressed: () async {
                final photo = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 40);
                File file = File(photo!.path);
                print(file.path);
                if (file != null) {
                  setState(() {
                    _showDialog();
                  });

                  //Upload to Firebase
                  var snapshot = await _firebaseStorage
                      .ref()
                      .child('images/' + photo.name)
                      .putFile(file);
                  await snapshot.ref.getDownloadURL().then((value) => {
                        setState(() {
                          foto = value;
                          print(value);

                          Navigator.pop(context);
                        })
                      });
                } else {
                  print('No Image Path Received');
                }
              },
              child: Text(
                'Fotoğraf Çek',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(),
              color: Colors.orange,
              onPressed: () async {
                if (hayvanTuru != null &&
                    hayvanCinsi != null &&
                    hayvanYasi != null &&
                    hayvanCinsiyeti != null &&
                    asilari != null &&
                    kisirlikDurumu != null &&
                    foto != null) {
                  Map<String, dynamic> hayvan = {
                    "turu": hayvanTuru,
                    "cinsi": hayvanCinsi,
                    'yasi': hayvanYasi,
                    'cinsiyeti': hayvanCinsiyeti,
                    'asilari': asilari,
                    'kisirlastirma': kisirlikDurumu,
                    'foto': foto,
                    'eklenmeTarihi':  DateFormat('yyyy-MM-dd – hh:mm:ss').format(DateTime.now()),
                    'konum': sehir,
                    'ekleyen':_auth.currentUser!.uid
                  };

                  FirebaseFirestore.instance
                      .collection('hayvanlar')
                      .add(hayvan)
                      .then((docRef) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Center(child: Text('Hayvan Eklendi')),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
              child: Text(
                'Ilani Paylas',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
