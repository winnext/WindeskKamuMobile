import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/issue_filter.modal.dart';
import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';
import 'filterBox.dart';

class IssueFilterModal extends StatefulWidget {
  String? moduleCode;
  IssueFilterModal({super.key, this.moduleCode});

  @override
  // ignore: library_private_types_in_public_api
  _IssueFilterModalState createState() => _IssueFilterModalState();
}

class _IssueFilterModalState extends State<IssueFilterModal> {
  final textInput = TextEditingController();

  List<DropdownMenuItem<IssueFilterModel>> dropdownItems =
      []; //* you can make nullable if you want, I'm doing it to force having String.

  @override
  void initState() {
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.issueFilterStatusCodes.clear();
    exampleList.getIssueOpenStatusCodes();
    exampleList.getSpaceBfwByType('BUILDING');
    exampleList.getSpaceBfwByType('FLOOR');
    exampleList.getSpaceBfwByType('WING');
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
                            onTap: () =>
                                {exampleList.setfloor = data.NAME.toString()},
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
                            onTap: () =>
                                {exampleList.setwing = data.NAME.toString()},
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
                    FilterBox(moduleCode: widget.moduleCode),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  APPColors.Clear.blue)),
                          child: const Text('Temizle'),
                          onPressed: () {
                            exampleList.exampleListView.clear();
                            exampleList.setwing = '';
                            exampleList.setassigne = '';
                            exampleList.setbuildCode = '';
                            exampleList.setbuildName = '';
                            exampleList.setfloor = '';
                            exampleList.setstatusCode = '';
                            exampleList.setstatusName = '';
                            exampleList.loadData(1, widget.moduleCode);
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  APPColors.Filter.blue)),
                          child: const Text('Filtrele',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 26, 20, 20))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
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
