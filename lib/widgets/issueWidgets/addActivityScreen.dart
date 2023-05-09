import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../providers/issueaction_provider.dart';
import '../../providers/list_view_provider.dart';
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
    issueActionProvider.getAvailableActivities(widget.issueCode);
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final issueActionProvider =
        Provider.of<IssueActionProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        width: size.width / 1.2,
        color: APPColors.Main.white,
        child: DropdownButton(
            value: selectedFruit,
            isExpanded: true,
            icon: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Icon(Icons.arrow_drop_down, color: APPColors.Main.black),
            ),
            iconSize: 25,
            underline: SizedBox(),
            onChanged: (newValue) {
              setState(() => {
                    issueActionProvider.setactivityCode = newValue.toString(),
                    selectedFruit = newValue.toString()
                  });
            },
            hint: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                issueActionProvider.activityName.toString() == ''
                    ? 'Durum'
                    : issueActionProvider.activityName.toString(),
                style: TextStyle(color: APPColors.Main.black, fontSize: 15),
              ),
            ),
            items: issueActionProvider.activityListView.map((data) {
              return DropdownMenuItem(
                onTap: () => {
                  issueActionProvider.setactivityName = data.NAME.toString()
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
      ),
    );
  }
}
