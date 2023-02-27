
import 'package:flutter/material.dart';

class AramaSonucBos extends StatelessWidget {
  const AramaSonucBos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
        child: const ListTile(
          leading: Icon(Icons.info),
          subtitle: Text(
            "Aradığınız Arama Kriterlerine Ait Bilgi Bulunamamıştır.",
          ),
        ));
  }
}
