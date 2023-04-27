import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../models/issue_filter.modal.dart';
import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';
import '../customInfoNotFound.dart';

class IssueFilterModal extends StatefulWidget {
  String? moduleCode;
  IssueFilterModal({super.key, this.moduleCode});

  @override
  // ignore: library_private_types_in_public_api
  _IssueFilterModalState createState() => _IssueFilterModalState();
}

class _IssueFilterModalState extends State<IssueFilterModal> {
  final textInput = TextEditingController();
  bool _myIssues = false;
  bool _status = false;
  bool _build = false;
  bool _floor = false;
  bool _wing = false;

  bool _isNotDone = false;
  String? _activityCode;
  String? _description;

  List<DropdownMenuItem<IssueFilterModel>> dropdownItems =
      []; //* you can make nullable if you want, I'm doing it to force having String.
  String selectedCurrency = 'USD';

  String? _mySelection;
  List<Map> _myJson = [];
  @override
  void initState() {
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.issueFilterStatusCodes.clear();
    exampleList.getIssueOpenStatusCodes();
    exampleList.getSpaceBfwByType('BUILDING');
    exampleList.getSpaceBfwByType('FLOOR');
    exampleList.getSpaceBfwByType('WING');

    print('building' + exampleList.issueFilterBuildCodes.toString());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedFruit;

    final exampleList = Provider.of<ListViewProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: APPColors.Modal.blue),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shadowColor: APPColors.Main.grey,
                              elevation: 5,
                              backgroundColor: exampleList.assigne != ''
                                  ? APPColors.Secondary.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            children: [
                              Text(
                                'Üzerime Atanan Vakalar',
                                style: TextStyle(
                                    color: exampleList.assigne != ''
                                        ? APPColors.Main.black
                                        : APPColors.Modal.white),
                              ),
                            ],
                          ),
                          onPressed: () => setState(() => {
                                exampleList.exampleListView.clear(),
                                exampleList.assigne == ''
                                    ? {
                                        exampleList.setassigne = 'sgnm1040',
                                        exampleList.loadData(
                                            1, widget.moduleCode),
                                      }
                                    : {
                                        exampleList.setassigne = '',
                                        exampleList.loadData(
                                            1, widget.moduleCode),
                                      }
                              })
                          // Navigator.pop(
                          //     context),
                          ),
                    ),
                    DropdownButton(
                        value: selectedFruit,
                        isExpanded: true,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Icon(Icons.arrow_drop_down,
                              color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                exampleList.exampleListView.clear(),
                                exampleList.setstatusCode = newValue.toString(),
                                exampleList.loadData(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            exampleList.statusName.toString() == ''
                                ? 'Durum'
                                : exampleList.statusName.toString(),
                            style: TextStyle(
                                color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: exampleList.issueFilterStatusCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {
                              exampleList.setstatusName =
                                  data.STATUSNAME.toString()
                            },
                            value: data.CODE.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data.STATUSNAME.toString(),
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
                              color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                exampleList.exampleListView.clear(),
                                exampleList.setbuildCode = newValue.toString(),
                                exampleList.loadData(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            exampleList.buildName.toString() == ''
                                ? 'Bina'
                                : exampleList.buildName.toString(),
                            style: TextStyle(
                                color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: exampleList.issueFilterBuildCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {
                              exampleList.setbuildName = data.NAME.toString()
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
                              color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                exampleList.exampleListView.clear(),
                                exampleList.setfloor = newValue.toString(),
                                exampleList.loadData(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            exampleList.floor.toString() == ''
                                ? 'Kat'
                                : exampleList.floor.toString(),
                            style: TextStyle(
                                color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: exampleList.issueFilterFloorCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {
                              exampleList.setfloor = data.NAME.toString()
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
                              color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                exampleList.exampleListView.clear(),
                                exampleList.setwing = newValue.toString(),
                                exampleList.loadData(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            exampleList.wing.toString() == ''
                                ? 'Kanat'
                                : exampleList.wing.toString(),
                            style: TextStyle(
                                color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: exampleList.issueFilterWingCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {
                              exampleList.setwing = data.NAME.toString()
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            exampleList.assigne != ''
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: APPColors.Main.white),
                                    child: GestureDetector(
                                        onTap: () {
                                          exampleList.exampleListView.clear();
                                          exampleList.setassigne = '';
                                          exampleList.loadData(
                                              1, widget.moduleCode);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              exampleList.assigne.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: APPColors.Modal.blue),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: APPColors.Modal.blue,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(),
                            exampleList.statusName != ''
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: APPColors.Main.white),
                                    child: GestureDetector(
                                        onTap: () {
                                          exampleList.exampleListView.clear();
                                          exampleList.setstatusName = '';
                                          exampleList.setstatusCode = '';
                                          exampleList.loadData(
                                              1, widget.moduleCode);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              exampleList.statusName.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: APPColors.Modal.blue),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: APPColors.Modal.blue,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(),
                            exampleList.buildCode != ''
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: APPColors.Main.white),
                                    child: GestureDetector(
                                        onTap: () {
                                          exampleList.exampleListView.clear();
                                          exampleList.setbuildCode = '';
                                          exampleList.setbuildName = '';
                                          exampleList.loadData(
                                              1, widget.moduleCode);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              exampleList.buildName.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: APPColors.Modal.blue),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: APPColors.Modal.blue,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(),
                                exampleList.floor != ''
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: APPColors.Main.white),
                                    child: GestureDetector(
                                        onTap: () {
                                          exampleList.exampleListView.clear();
                                          exampleList.setfloor = '';
                                          exampleList.loadData(
                                              1, widget.moduleCode);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              exampleList.floor.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: APPColors.Modal.blue),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: APPColors.Modal.blue,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(),
                                exampleList.wing != ''
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: APPColors.Main.white),
                                    child: GestureDetector(
                                        onTap: () {
                                          exampleList.exampleListView.clear();
                                          exampleList.setwing = '';
                                          exampleList.loadData(
                                              1, widget.moduleCode);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              exampleList.wing.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: APPColors.Modal.blue),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: APPColors.Modal.blue,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}