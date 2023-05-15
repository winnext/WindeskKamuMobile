import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../providers/issueaction_provider.dart';
import '../../providers/list_view_provider.dart';
import '../../providers/new_notif_provider.dart';
import '../../utils/themes.dart';

class AddActivityScreen extends StatefulWidget {
  VoidCallback? onConfirm;
  String? title;
  String? text;
  bool? success;
  String? confirmButtonText;
  String? issueCode;

  AddActivityScreen(
      {this.onConfirm,
      this.title,
      this.text,
      this.success,
      this.confirmButtonText,
      this.issueCode,
      super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  String? selectedFruit;

  @override
  void initState() {
    final issueActionProvider =
        Provider.of<IssueActionProvider>(context, listen: false);
    final newNotifProvider =
        Provider.of<NewNotifProvider>(context, listen: false);
    issueActionProvider
        .getLiveSelectAsgUser(issueActionProvider.liveSelectGroupCode);
    issueActionProvider.setliveSelectGroupCode = '';
    issueActionProvider.setliveSelectGroupName = '';
    issueActionProvider.setliveSelectUserCode = '';
    issueActionProvider.setliveSelectUserName = '';

    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String spaceCode = '';

    final issueActionProvider =
        Provider.of<IssueActionProvider>(context, listen: false);
    final newNotifProvider =
        Provider.of<NewNotifProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        width: size.width / 1.09,
        color: APPColors.Main.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButton(
                  value: selectedFruit,
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Icon(Icons.arrow_drop_down,
                        color: APPColors.Main.black),
                  ),
                  iconSize: 25,
                  underline: SizedBox(),
                  onChanged: (newValue) {
                    setState(() => {
                          issueActionProvider.setactivityCode =
                              newValue.toString(),
                          selectedFruit = newValue.toString()
                        });
                  },
                  hint: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      issueActionProvider.activityName.toString() == ''
                          ? 'Durum'
                          : issueActionProvider.activityName.toString(),
                      style:
                          TextStyle(color: APPColors.Main.black, fontSize: 15),
                    ),
                  ),
                  items: issueActionProvider.activityListView.map((data) {
                    return DropdownMenuItem(
                      onTap: () => {
                        issueActionProvider.setactivityName =
                            data.NAME.toString(),
                        issueActionProvider.setbarcodeSpace =
                            data.BARCODE_SPACE.toString(),
                        issueActionProvider.setadditionalTimeInput =
                            data.ADDITIONALTIME_INPUT.toString(),
                        issueActionProvider.setassigneeccType =
                            data.ASSIGNEECC_TYPE.toString(),
                        issueActionProvider.setminDescLength =
                            data.MIN_DESC_LENGTH.toString(),
                        issueActionProvider.setmobilePhoto =
                            data.MOBILE_PHOTO.toString(),
                        print('dataaaa' +
                            issueActionProvider.assigneeccType.toString())
                      },
                      value: data.CODE.toString(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          data.NAME.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList()),
              Divider(
                thickness: height_3,
              ),
              Text(
                  'Bu aktivitenin girilmesi, talebin durumunu ${issueActionProvider.activityName} olarak değiştirecektir.'),
              issueActionProvider.barcodeSpace == 'Y'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (String value) {
                              setState(() {
                                spaceCode = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: newNotifProvider.qrCode != ''
                                  ? newNotifProvider.qrCode
                                  : 'Mahal Kodu',
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
                                newNotifProvider.scanQR('spaceCode');
                                setState(() {
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              issueActionProvider.additionalTimeInput == 'Y'
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ek Süre (Gün)',
                        ),
                      ),
                    )
                  : Container(),
              issueActionProvider.assigneeccType == 'LIVESELECT'
                  ? Column(
                      children: [
                        DropdownButton(
                            value: selectedFruit,
                            isExpanded: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: APPColors.Main.black),
                            ),
                            iconSize: 25,
                            underline: SizedBox(),
                            onChanged: (newValue) {
                              setState(() => {
                                    issueActionProvider.setliveSelectGroupCode =
                                        newValue.toString(),
                                  });
                            },
                            hint: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Text(
                                issueActionProvider.liveSelectGroupName
                                            .toString() ==
                                        ''
                                    ? 'Atama grubu seçiniz...'
                                    : issueActionProvider.liveSelectGroupName
                                        .toString(),
                                style: TextStyle(
                                    color: APPColors.Main.black, fontSize: 15),
                              ),
                            ),
                            items: issueActionProvider.liveSelectAsgGroups
                                .map((data) {
                              return DropdownMenuItem(
                                onTap: () => {
                                  issueActionProvider.setliveSelectGroupName =
                                      data.NAME.toString(),
                                },
                                value: data.CODE.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    data.NAME.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                        DropdownButton(
                            value: selectedFruit,
                            isExpanded: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: APPColors.Main.black),
                            ),
                            iconSize: 25,
                            underline: SizedBox(),
                            onChanged: (newValue) {
                              setState(() => {
                                    issueActionProvider.setliveSelectUserCode =
                                        newValue.toString(),
                                  });
                            },
                            hint: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Text(
                                issueActionProvider.liveSelectUserName
                                            .toString() ==
                                        ''
                                    ? 'Atanan kişi seçimi yapınız...'
                                    : issueActionProvider.liveSelectUserName
                                        .toString(),
                                style: TextStyle(
                                    color: APPColors.Main.black, fontSize: 15),
                              ),
                            ),
                            items: issueActionProvider.liveSelectAsgUsers
                                .map((data) {
                              return DropdownMenuItem(
                                onTap: () => {
                                  issueActionProvider.setliveSelectUserName =
                                      data.FULLNAME.toString(),
                                },
                                value: data.CODE.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    data.FULLNAME.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      ],
                    )
                  : Container(),
              issueActionProvider.minDescLength != '0'
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Açıklama Giriniz',
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
