import 'package:flutter/material.dart';

import '../cardDesign.dart';



class KusBakimi extends StatefulWidget {
  @override
  _KusBakimiState createState() => _KusBakimiState();
}

class _KusBakimiState extends State<KusBakimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:   Text(       'Kuş Bakımı', style: TextStyle(fontSize: 30, color: Colors.grey),),

        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[

        ],

      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                BilgiKart(yazi1: "0-1 Ay", yazi2: "18-21 günlük bir süreden sonra yavru muhabbet kuşları yumurtadan çıkmaya başlayacaktır. İlk civciv yumurtadan çıktıktan 24 saat sonra ikinci yavru yumurtayı kırmaya başlayacaktır. Ve son yavru çıkana kadar böyle devam edecektir. Ama bazı zamanlarda yumurtanın dölsüz olması veya düşük kalitede olması, nedeni ile civcive dönüşmesi mümkün olmamaktadır."),
                BilgiKart(yazi1: "Yemek", yazi2: "Muhabbet kuşları evde besleniyor ise onlara özel hazırlanmış muhabbet kuş yemlerinden yemelidir. Ancak doğal ortamlarında muhabbet kuşları genellikle tohumlarla, çiçeklerle ve meyvelerle beslenirler. Muhabbet kuşları insanların da tükettiği gıdalar ile beslenebilirler. Ödül olarak insanları yedikleri yiyeceklerden verilebilir. Ancak fazla tatlı ve tuzlu yiyeceklerin verilmesi sakıncalıdır."),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
