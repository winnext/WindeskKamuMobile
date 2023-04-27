import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';

import '../../providers/detail_view_provider.dart';
import '../../utils/themes.dart';

class IssueActionButton extends StatefulWidget {
  String? code;
  String? xusercode;

  IssueActionButton({super.key, this.code, this.xusercode});
  @override
  // ignore: library_private_types_in_public_api
  _IssueActionButtonState createState() => _IssueActionButtonState();
}

class _IssueActionButtonState extends State<IssueActionButton> {
  final textInput = TextEditingController();
  bool _isDone = false;
  bool _isNotDone = false;
  String? _activityCode;
  String? _description;

  @override
  void initState() {
    final listViewProvider =
        Provider.of<ListViewProvider>(context, listen: false);
    listViewProvider.issueOperationList.clear();
    listViewProvider.getIssueOperations(widget.code, widget.xusercode);
    print('dataActivitiesxx' + listViewProvider.issueOperationList.toString());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final listViewProvider =
        Provider.of<ListViewProvider>(context);
    final operations = listViewProvider.issueOperationList.toString();

    return Container(
      height: size.height / 3,
      color: APPColors.Modal.blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isDone
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Talep Yerine Getirildi',
                        style: TextStyle(
                            color: _isDone
                                ? APPColors.Main.black
                                : APPColors.Modal.white),
                      ),
                      onPressed: () => setState(() => {
                            _isNotDone = false,
                            _isDone = !_isDone,
                            _activityCode = 'AR00000001187'
                          })
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isNotDone
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Talep Yerine Getirilmedi',
                        style: TextStyle(
                            color: _isNotDone
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                            _isDone = false,
                            _isNotDone = !_isNotDone,
                            _activityCode = 'AR00000001336'
                          })

                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
