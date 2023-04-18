import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/list_view_provider.dart';
import '../../utils/themes.dart';

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

  @override
  void initState() {
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.issueFilterStatusCodes.clear();
    exampleList.getIssueOpenStatusCodes();

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

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 3,
      color: APPColors.Modal.blue,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shadowColor: APPColors.Main.grey,
                              elevation: 5,
                              backgroundColor: _status
                                  ? APPColors.Secondary.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Durum',
                                style: TextStyle(
                                    color: _status
                                        ? APPColors.Main.black
                                        : APPColors.Modal.white),
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                          onPressed: () => setState(() => {
                                _status = !_status,
                                _activityCode = 'AR00000001187',
                                exampleList.issueFilterStatusCodes.clear(),
                                exampleList.getIssueOpenStatusCodes(),
                              })
                          // Navigator.pop(
                          //     context),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shadowColor: APPColors.Main.grey,
                              elevation: 5,
                              backgroundColor: _build
                                  ? APPColors.Secondary.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bina',
                                style: TextStyle(
                                    color: _build
                                        ? APPColors.Main.black
                                        : APPColors.Modal.white),
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                          onPressed: () => setState(() => {
                                _build = !_build,
                                exampleList.issueFilterStatusCodes.clear(),
                                exampleList.getSpaceBfwByType('BUILDING'),
                              })
                          ),
                    ),
                    _build ? Text(exampleList.issueFilterStatusCodes.toString()) : Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shadowColor: APPColors.Main.grey,
                              elevation: 5,
                              backgroundColor: _floor
                                  ? APPColors.Secondary.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kat',
                                style: TextStyle(
                                    color: _floor
                                        ? APPColors.Main.black
                                        : APPColors.Modal.white),
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                          onPressed: () => setState(() => {
                                _floor = !_floor,
                                _activityCode = 'AR00000001187'
                              })
                          // Navigator.pop(
                          //     context),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              shadowColor: APPColors.Main.grey,
                              elevation: 5,
                              backgroundColor: _wing
                                  ? APPColors.Secondary.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kanat',
                                style: TextStyle(
                                    color: _wing
                                        ? APPColors.Main.black
                                        : APPColors.Modal.white),
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                          onPressed: () => setState(() =>
                              {_wing = !_wing, _activityCode = 'AR00000001187'})
                          // Navigator.pop(
                          //     context),
                          ),
                    ),
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
