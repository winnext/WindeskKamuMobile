// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../utils/themes.dart';

class StatefulBottomSheet extends StatefulWidget {
  String? code;
  StatefulBottomSheet({super.key, this.code});
  @override
  // ignore: library_private_types_in_public_api
  _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
}

class _StatefulBottomSheetState extends State<StatefulBottomSheet> {
  final textInput = TextEditingController();
  bool _isDone = false;
  bool _isNotDone = false;
  String? _activityCode;
  String? _description;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   print('activities initialState');
    //   final detailActivities =
    //       Provider.of<DetailViewProvider>(context, listen: false);
    //   //detailActivities.listViewActivities.clear();
    //   detailActivities.listViewActivities.clear();
    //   await detailActivities.loadIssueActivities(widget.code.toString());
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 3,
      color: APPColors.Modal.blue,
      child: Column(
        children: [
          Text(
            widget.code.toString(),
            style: const TextStyle(color: Colors.white),
          ),
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
                          backgroundColor: _isDone ? APPColors.Main.white : APPColors.Modal.blue),
                      child: Text(
                        'Talep Yerine Getirildi',
                        style: TextStyle(color: _isDone ? APPColors.Main.black : APPColors.Modal.white),
                      ),
                      onPressed: () => setState(() => {_isNotDone = false, _isDone = !_isDone, _activityCode = 'AR00000001187'})
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
                          backgroundColor: _isNotDone ? APPColors.Main.white : APPColors.Modal.blue),
                      child: Text(
                        'Talep Yerine Getirilmedi',
                        style: TextStyle(color: _isNotDone ? APPColors.Main.black : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {_isDone = false, _isNotDone = !_isNotDone, _activityCode = 'AR00000001336'})

                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: textInput,
              style: TextStyle(fontSize: 15, color: APPColors.Main.white),
              decoration: InputDecoration(
                filled: true,
                hintText: 'Açıklama giriniz.',
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: APPColors.Main.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: APPColors.Main.white),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                print('value$value');
                setState(() {
                  _description = value;
                });
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
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
                            backgroundColor: APPColors.Modal.blue),
                        child: Text(
                          'Tamam',
                          style: TextStyle(color: APPColors.Modal.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // showDialog<void>(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return DialogExample(
                          //       code: widget.code.toString(),
                          //       kadi: loginProvider.kadi.toString(),
                          //       activityCode: this._activityCode.toString(),
                          //       input: textInput.text.toString(),
                          //     );
                          //   },
                          // );
                        }),
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
                            backgroundColor: APPColors.Modal.blue),
                        child: Text(
                          'Vazgeç',
                          style: TextStyle(color: APPColors.Main.white),
                        ),
                        onPressed: () => setState(() => {_isDone = false, _isNotDone = !_isNotDone})

                        // Navigator.pop(
                        //     context),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
