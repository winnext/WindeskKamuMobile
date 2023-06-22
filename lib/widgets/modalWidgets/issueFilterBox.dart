import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/issue_filter.modal.dart';
import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';

class FilterBox extends StatefulWidget {
  String? moduleCode;
  FilterBox({super.key, this.moduleCode});

  @override
  // ignore: library_private_types_in_public_api
  _FilterBoxState createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  final textInput = TextEditingController();

  List<DropdownMenuItem<IssueFilterModel>> dropdownItems =
      []; //* you can make nullable if you want, I'm doing it to force having String.
  String selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exampleList = Provider.of<ListViewProvider>(context);

    return Padding(
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
                          exampleList.loadData(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exampleList.assigne.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: APPColors.Modal.blue),
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
                          exampleList.loadData(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exampleList.statusName.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: APPColors.Modal.blue),
                            ),
                            Icon(
                              Icons.clear,
                              color: APPColors.Modal.blue,
                            )
                          ],
                        )),
                  )
                : Container(),
            exampleList.buildName != ''
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
                          exampleList.loadData(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exampleList.buildName.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: APPColors.Modal.blue),
                            ),
                            Icon(
                              Icons.clear,
                              color: APPColors.Modal.blue,
                            )
                          ],
                        )),
                  )
                : Container(),
            exampleList.floorCode != ''
                ? Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          exampleList.exampleListView.clear();
                          exampleList.setfloorCode = '';
                          exampleList.setfloorName = '';
                          exampleList.loadData(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exampleList.floorName.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: APPColors.Modal.blue),
                            ),
                            Icon(
                              Icons.clear,
                              color: APPColors.Modal.blue,
                            )
                          ],
                        )),
                  )
                : Container(),
            exampleList.wingCode != ''
                ? Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          exampleList.exampleListView.clear();
                          exampleList.setwingCode = '';
                          exampleList.setwingName = '';
                          exampleList.loadData(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exampleList.wingName.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: APPColors.Modal.blue),
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
    );
  }
}
