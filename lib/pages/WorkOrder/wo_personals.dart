import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/workorder_detail_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';

class WoPersonals extends StatefulWidget {
  const WoPersonals({super.key, required this.woCode});
  final woCode;

  @override
  State<WoPersonals> createState() => _WoPersonalsState();
}

class _WoPersonalsState extends State<WoPersonals> {
  final dataListSure = ["Lütfen vardiya seçiniz", "15 dk", "30 dk", "45 dk", "1 sa", "2 sa", "6 sa", "Serbest Seçim"];
  final names = ["Personal ismi seçiniz", "mert", "akif", "murat"];
  final String _clear = "Temi̇zle";

  @override
  void initState() {
    print("hello world");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final woDetailViewProvider = Provider.of<WoDetailViewProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            _personNameDropdown(woDetailViewProvider),
            _dateDropdown(woDetailViewProvider),
            _buttons(woDetailViewProvider),
            const Spacer(flex: 30),
          ],
        ),
      ),
    );
  }

  Expanded _buttons(WoDetailViewProvider woDetailViewProvider) {
    return Expanded(
      flex: 50,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
            width: 60.w,
            height: 5.h,
            child: Column(
              children: [
                _clearButton(woDetailViewProvider),
                Row(
                  children: [
                    _cancelButton(woDetailViewProvider),
                    _createButton(woDetailViewProvider),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _clearButton(WoDetailViewProvider woDetailViewProvider) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        onPressed: () {
          if (woDetailViewProvider.pickedPersonalName == 'Personal ismi seçiniz' && woDetailViewProvider.pickShifting == 'Lütfen vardiya seçiniz') {
            return;
          } else {
            woDetailViewProvider.setPickedPersonalName = 'Personal ismi seçiniz';
            woDetailViewProvider.setSureDegeri = 'Lütfen vardiya seçiniz';
          }
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(_clear),
      ),
    );
  }

  SizedBox _createButton(WoDetailViewProvider woDetailViewProvider) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
        ),
        onPressed: () {
          String workPeriod = '';
          if (woDetailViewProvider.secilenSure == 'Lütfen Süre Seçiniz') {
            snackBar(context, 'Süre seçmeden efor oluşturamazsınız', 'info');
          } else {
            if (woDetailViewProvider.secilenSure == 'Serbest Seçim') {
              String dayValue = '';
              String saatValue = '';
              String dakikaValue = '';
              //Gun degeri
              if (woDetailViewProvider.secilenGun.length == 1) {
                dayValue = '00${woDetailViewProvider.secilenGun}';
              } else if (woDetailViewProvider.secilenGun.length == 2) {
                dayValue = '0${woDetailViewProvider.secilenGun}';
              } else if (woDetailViewProvider.secilenGun.length == 3) {
                dayValue = woDetailViewProvider.secilenGun;
              }

              //Saat degeri
              if (woDetailViewProvider.secilenSaat.length == 1) {
                saatValue = '0${woDetailViewProvider.secilenSaat}';
              } else if (woDetailViewProvider.secilenSaat.length == 2) {
                saatValue = woDetailViewProvider.secilenSaat;
              }

              //Dakika degeri
              if (woDetailViewProvider.secilenDakika.length == 1) {
                dakikaValue = '0${woDetailViewProvider.secilenDakika}';
              } else if (woDetailViewProvider.secilenDakika.length == 2) {
                dakikaValue = woDetailViewProvider.secilenDakika;
              }

              workPeriod = '$dayValue$saatValue${dakikaValue}00';
            } else {
              if (woDetailViewProvider.secilenSure == '15 dk') {
                workPeriod = '000001500';
              } else if (woDetailViewProvider.secilenSure == '30 dk') {
                workPeriod = '000003000';
              } else if (woDetailViewProvider.secilenSure == '45 dk') {
                workPeriod = '000004500';
              } else if (woDetailViewProvider.secilenSure == '1 sa') {
                workPeriod = '000010000';
              } else if (woDetailViewProvider.secilenSure == '2 sa') {
                workPeriod = '000020000';
              } else if (woDetailViewProvider.secilenSure == '6 sa') {
                workPeriod = '000060000';
              }
            }
            woDetailViewProvider.addEffort(context, widget.woCode, workPeriod);
          }
        },
        child: const Text('Oluştur'),
      ),
    );
  }

  SizedBox _cancelButton(WoDetailViewProvider woDetailViewProvider) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          ),
        ),
        onPressed: () {
          woDetailViewProvider.setSureDegeri = 'Lütfen Süre Seçiniz';
          woDetailViewProvider.setSecilenGun = '1';
          woDetailViewProvider.setSecilenSaat = '1';
          woDetailViewProvider.setSecilenDakika = '1';
        },
        child: (const Text('Vazgeç')),
      ),
    );
  }

  Widget _personNameDropdown(WoDetailViewProvider woDetailViewProvider) {
    return Expanded(
      flex: 20,
      child: DropdownButtonFormField(
        isExpanded: true,
        value: woDetailViewProvider.pickedPersonalName,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)), labelText: ''),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: names.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          if (newValue != null) {
            woDetailViewProvider.setPickedPersonalName = newValue.toString();
          } else {
            return;
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _dateDropdown(WoDetailViewProvider woDetailViewProvider) {
    return Expanded(
      flex: 20,
      child: DropdownButtonFormField(
        isExpanded: true,
        value: woDetailViewProvider.pickShifting,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)), labelText: ''),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: dataListSure.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          woDetailViewProvider.setPickShifting = newValue.toString();
          setState(() {});
        },
      ),
    );
  }
}
