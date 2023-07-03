import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/workorder_provider.dart';
import 'woFilterBox.dart';

import '../../models/issue_filter.modal.dart';
import '../../utils/themes.dart';

class WorkOrderFilter extends StatefulWidget {
  String? moduleCode;
  WorkOrderFilter({super.key, this.moduleCode});

  @override
  // ignore: library_private_types_in_public_api
  _WorkOrderFilterState createState() => _WorkOrderFilterState();
}

class _WorkOrderFilterState extends State<WorkOrderFilter> {
  final textInput = TextEditingController();

  List<DropdownMenuItem<IssueFilterModel>> dropdownItems = []; //* you can make nullable if you want, I'm doing it to force having String.

  @override
  void initState() {
    final woList = Provider.of<WorkOrderProvider>(context, listen: false);
    woList.woFilterStatusCodes.clear();
    woList.getIssueOpenStatusCodes();
    woList.getSpaceBfwByType('BUILDING');
    woList.getSpaceBfwByType('FLOOR');
    woList.getSpaceBfwByType('WING');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedFruit;

    final woList = Provider.of<WorkOrderProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: APPColors.Modal.blue),
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
                              backgroundColor: woList.assigne != '' ? APPColors.Secondary.white : APPColors.Modal.blue),
                          child: Row(
                            children: [
                              Text(
                                'Üzerime Atanan Vakalar',
                                style: TextStyle(color: woList.assigne != '' ? APPColors.Main.black : APPColors.Modal.white),
                              ),
                            ],
                          ),
                          onPressed: () => setState(() => {
                                woList.woListView.clear(),
                                woList.assigne == ''
                                    ? {
                                        woList.setassigne = 'sgnm1040',
                                        woList.getListWorkOrders(1, widget.moduleCode),
                                      }
                                    : {
                                        woList.setassigne = '',
                                        woList.getListWorkOrders(1, widget.moduleCode),
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
                          child: Icon(Icons.arrow_drop_down, color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                woList.woListView.clear(),
                                woList.setstatusCode = newValue.toString(),
                                woList.getListWorkOrders(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            woList.statusName.toString() == '' ? 'Durum' : woList.statusName.toString(),
                            style: TextStyle(color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: woList.woFilterStatusCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {woList.setstatusName = data.STATUSNAME.toString()},
                            value: data.CODE.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data.STATUSNAME.toString(),
                                style: const TextStyle(
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
                          child: Icon(Icons.arrow_drop_down, color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                woList.woListView.clear(),
                                woList.setbuildCode = newValue.toString(),
                                woList.getListWorkOrders(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            woList.buildName.toString() == '' ? 'Bina' : woList.buildName.toString(),
                            style: TextStyle(color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: woList.woFilterBuildCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {woList.setbuildName = data.NAME.toString()},
                            value: data.CODE.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data.NAME.toString(),
                                style: const TextStyle(
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
                          child: Icon(Icons.arrow_drop_down, color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                woList.woListView.clear(),
                                woList.setfloor = newValue.toString(),
                                woList.getListWorkOrders(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            woList.floor.toString() == '' ? 'Kat' : woList.floor.toString(),
                            style: TextStyle(color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: woList.woFilterFloorCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {woList.setfloor = data.NAME.toString()},
                            value: data.CODE.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data.NAME.toString(),
                                style: const TextStyle(
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
                          child: Icon(Icons.arrow_drop_down, color: APPColors.Main.white),
                        ),
                        iconSize: 25,
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          setState(() => {
                                woList.woListView.clear(),
                                woList.setwing = newValue.toString(),
                                woList.getListWorkOrders(1, widget.moduleCode),
                                selectedFruit = newValue.toString()
                              });
                        },
                        hint: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            woList.wing.toString() == '' ? 'Kanat' : woList.wing.toString(),
                            style: TextStyle(color: APPColors.Main.white, fontSize: 15),
                          ),
                        ),
                        items: woList.woFilterWingCodes.map((data) {
                          return DropdownMenuItem(
                            onTap: () => {woList.setwing = data.NAME.toString()},
                            value: data.CODE.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                data.NAME.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                    WoFilterBox(moduleCode: widget.moduleCode),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(APPColors.Clear.blue)),
                          child: const Text('Temizle'),
                          onPressed: () {
                            woList.woListView.clear();
                            woList.setwing = '';
                            woList.setassigne = '';
                            woList.setbuildCode = '';
                            woList.setbuildName = '';
                            woList.setfloor = '';
                            woList.setstatusCode = '';
                            woList.setstatusName = '';
                            woList.getListWorkOrders(1, widget.moduleCode);
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(APPColors.Filter.blue)),
                          child: const Text('Filtrele', style: TextStyle(color: Color.fromARGB(255, 26, 20, 20))),
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
