import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/models/shiftings_model.dart';

import '../../models/work_order_personals.dart';
import '../../providers/workorder_detail_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';

class WoPersonals extends StatefulWidget {
  const WoPersonals({super.key, required this.woCode, required this.shiftings, required this.personals});
  final List<ShiftingsModel> shiftings;
  final List<WorkOrderPersonals> personals;
  final woCode;

  @override
  State<WoPersonals> createState() => _WoPersonalsState();
}

class _WoPersonalsState extends State<WoPersonals> {
  final dataListSure = ["Lütfen vardiya seçiniz"];
  final names = ["Personal ismi seçiniz"];
  final String _clear = "Temi̇zle";

  void _initLists() {
    for (var element in widget.shiftings) {
      dataListSure.add(element.name ?? '');
    }
    for (var element in widget.personals) {
      names.add(element.fullname ?? '');
    }
  }

  @override
  void initState() {
    _initLists();
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
          woDetailViewProvider.setisNewPersonalAdded = false;
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
          if (woDetailViewProvider.pickedPersonalName == 'Personal ismi seçiniz' && woDetailViewProvider.pickShifting == 'Lütfen vardiya seçiniz') {
            return;
          } else {
            woDetailViewProvider.addWorkOrderPersonal();
            woDetailViewProvider.setPickedPersonalName = 'Personal ismi seçiniz';
            woDetailViewProvider.setSureDegeri = 'Lütfen vardiya seçiniz';
          }
          setState(() {});
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
          woDetailViewProvider.setisNewPersonalAdded = false;
          Navigator.pop(context);
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
