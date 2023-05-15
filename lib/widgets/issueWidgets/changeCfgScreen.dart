import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../../providers/new_notif_provider.dart';
import '../../utils/themes.dart';

class ChangeCfgScreen extends StatefulWidget {
  final String? issueCode;
  const ChangeCfgScreen({this.issueCode, super.key});

  @override
  State<ChangeCfgScreen> createState() => _ChangeCfgScreenState();
}

class _ChangeCfgScreenState extends State<ChangeCfgScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final newNotifProvider =
        Provider.of<NewNotifProvider>(context, listen: true);

    return SingleChildScrollView(
      child: Container(
        width: size.width / 1.09,
        color: APPColors.Main.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            newNotifProvider.setentityCode = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              newNotifProvider.entityCode != '' ? newNotifProvider.entityCode : 'Varlık Kodu',
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_2,
                            size: 40,
                          ),
                          onPressed: () {
                            newNotifProvider.setqrCode = '';
                            newNotifProvider.scanQR('entityCode');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            newNotifProvider.setserialNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              newNotifProvider.serialNumber != '' ? newNotifProvider.serialNumber : 'Seri No',
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_2,
                            size: 40,
                          ),
                          onPressed: () {
                            newNotifProvider.setqrCode = '';
                            newNotifProvider.scanQR('serialNumber');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            newNotifProvider.setrfid = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: newNotifProvider.rfid != '' ? newNotifProvider.rfid : 'RFID',
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_2,
                            size: 40,
                          ),
                          onPressed: () {
                            newNotifProvider.setqrCode = '';
                            newNotifProvider.scanQR('rfid');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            newNotifProvider.setlocCode = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: newNotifProvider.locCode != '' ? newNotifProvider.locCode : 'Mahal',
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_2,
                            size: 40,
                          ),
                          onPressed: () {
                            newNotifProvider.setqrCode = '';
                            newNotifProvider.scanQR('locCode');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle light when tapped.
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: APPColors.Clear.red,
                        ),
                        width: size.width / 3,
                        padding: const EdgeInsets.all(8),
                        // Change button text when light changes state.
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Vazgeç',
                            style: TextStyle(color: APPColors.Main.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Toggle light when tapped.
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: APPColors.Clear.blue,
                        ),
                        width: size.width / 3,
                        padding: const EdgeInsets.all(8),
                        // Change button text when light changes state.
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Gönder',
                                style: TextStyle(
                                  color: APPColors.Main.white,
                                ))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
