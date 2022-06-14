import 'package:flutter/material.dart';
import 'package:yuvamolsun/cardDesign.dart';

class KediBakimi extends StatefulWidget {
  @override
  _KediBakimiState createState() => _KediBakimiState();
}

class _KediBakimiState extends State<KediBakimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Kedi Bakımı',
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
                BilgiKart(yazi1: "1 Aylık", yazi2: "Yavru henüz kendi kendine yiyemeyecek kadar küçükse, beslenmesi için biberon ve anne sütünün yerine geçen bir ürün kullanmanız gerekecektir"),
                BilgiKart(yazi1: "2 Aylık", yazi2: "2. ayı dolana kadar formül sütlerle beslenen kediler, kademeli olarak katı mamalara geçiş yapmalıdır. Yavru kediler 2. aydan sonra yeni bir gelişim evresine adım atsa da 4 aylık olana kadar bebek olarak nitelendirilir. 2. aydan sonra yavaş yavaş katı mamayla tanışan bebek kediler için bebek kedi maması tercih etmelisiniz. Süt tozu ile yapılan sıvı mamalardan katı mamaya geçiş sürecinde yaş mama ile başlayıp sonrasında karıştırarak kuru mamaya geçmeniz önerilir."),
                BilgiKart(yazi1: "3 Aylık", yazi2: "2. ayını doldurup annesinden yavaş yavaş ayrılan yavru kediler 3. aydan sonra çok daha hızlı bir şekilde gelişmeye başlayacaktır. Doğduğu anda gözlerini bile açamayan yavru kedilerin zamanla gözleri ve kulakları açılır, dişleri çıkmaya başlar. 3 aylık olduğunda ise fiziksel birçok özelliğini tam anlamıyla kazanmış olur."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}