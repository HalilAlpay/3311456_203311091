import 'package:flutter/material.dart';
import '../cardDesign.dart';

class KopekBakimi extends StatefulWidget {
  @override
  _KopekBakimiState createState() => _KopekBakimiState();
}

class _KopekBakimiState extends State<KopekBakimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Köpek Bakımı',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[],
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                BilgiKart(
                    yazi1: "1 Aylık",
                    yazi2:
                        "Birinci ayını dolduran yavru köpek, yavaş yavaş anne sütünden kesilerek katı mamalara aşamalı bir şekilde geçebilir. Doğal bağışıklık sistemlerini ve tam gelişmemiş sindirim sistemlerini destekleyecek, bağırsaklardaki yararlı bakterilerin oluşumunu hızlandıracak bir beslenmeye ihtiyaç duyarlar."),
                BilgiKart(
                    yazi1: "2-4 Aylık",
                    yazi2:
                        "Bu aşamada odak noktası, yavru köpeğinizin iskelet yapısının gelişimini özenli bir şekilde düzenlenmiş miktarlarda kalsiyum, fosfor ve D vitamini ile desteklemektir."),
                BilgiKart(
                    yazi1: "4-7 Aylık",
                    yazi2:
                        "Yavru köpeğiniz bu aylarda hedef yetişkin ağırlığına ulaşmaya başlar ve yüksek sindirilebilir özellikli, kaliteli proteinler içeren bir beslenmeye ihtiyaç duyar."),
              BilgiKart(yazi1: "10 Ay-Yetişkinlik", yazi2: "Yavru köpekler yetişkinliğe yaklaştıkça özellikle dev ırklarda güçlü kas ve iskelet sisteminin gelişimi ve ağırlıklarının eklemlere uyguladığı baskı göz önünde bulundurularak özel beslenme ihtiyaçları göz önünde bulundurulmalıdır.")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
