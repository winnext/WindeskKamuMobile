import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/providers/workorder_provider.dart';
import '../../models/issue_filter.modal.dart';
import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';

class WoFilterBox extends StatefulWidget {
  String? moduleCode;
  WoFilterBox({super.key, this.moduleCode});

  @override
  // ignore: library_private_types_in_public_api
  _WoFilterBoxState createState() => _WoFilterBoxState();
}

class _WoFilterBoxState extends State<WoFilterBox> {
  List<DropdownMenuItem<IssueFilterModel>> dropdownItems = []; //* you can make nullable if you want, I'm doing it to force having String.

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workOrderProvider = Provider.of<WorkOrderProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            workOrderProvider.assigne != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          workOrderProvider.woListView.clear();
                          workOrderProvider.setassigne = '';
                          workOrderProvider.getListWorkOrders(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              workOrderProvider.assigne.toString(),
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
            workOrderProvider.statusName != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          workOrderProvider.woListView.clear();
                          workOrderProvider.setstatusName = '';
                          workOrderProvider.setstatusCode = '';
                          workOrderProvider.getListWorkOrders(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              workOrderProvider.statusName.toString(),
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
            workOrderProvider.buildCode != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          workOrderProvider.woListView.clear();
                          workOrderProvider.setbuildCode = '';
                          workOrderProvider.setbuildName = '';
                          workOrderProvider.getListWorkOrders(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              workOrderProvider.buildName.toString(),
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
            workOrderProvider.floor != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          workOrderProvider.woListView.clear();
                          workOrderProvider.setfloor = '';
                          workOrderProvider.getListWorkOrders(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              workOrderProvider.floor.toString(),
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
            workOrderProvider.wing != ''
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: APPColors.Main.white),
                    child: GestureDetector(
                        onTap: () {
                          workOrderProvider.woListView.clear();
                          workOrderProvider.setwing = '';
                          workOrderProvider.getListWorkOrders(1, widget.moduleCode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              workOrderProvider.wing.toString(),
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
