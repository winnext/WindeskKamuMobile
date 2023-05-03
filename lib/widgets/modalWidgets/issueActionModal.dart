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
  bool _isPhoto = false;
  bool _isTakeOver = false;
  bool _isActivity = false;
  bool _isChangeCFG = false;
  bool _isSparepart = false;
  bool _isPlannedCancel = false;


  bool _isNotDone = false;

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
      height: size.height / 2,
      color: APPColors.Modal.blue,
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 side: BorderSide(color: APPColors.Main.grey),
          //                 shadowColor: APPColors.Main.black,
          //                 elevation: 10,
          //                 backgroundColor: _isDone
          //                     ? APPColors.Main.white
          //                     : APPColors.Modal.blue),
          //             child: Text(
          //               'Talep Yerine Getirildi',
          //               style: TextStyle(
          //                   color: _isDone
          //                       ? APPColors.Main.black
          //                       : APPColors.Modal.white),
          //             ),
          //             onPressed: () => setState(() => {
          //                   _isNotDone = false,
          //                   _isDone = !_isDone,
          //                   _activityCode = 'AR00000001187'
          //                 })
          //             // Navigator.pop(
          //             //     context),
          //             ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(4.0),
          //         child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //                 side: BorderSide(color: APPColors.Main.grey),
          //                 shadowColor: APPColors.Main.black,
          //                 elevation: 10,
          //                 backgroundColor: _isNotDone
          //                     ? APPColors.Main.white
          //                     : APPColors.Modal.blue),
          //             child: Text(
          //               'Talep Yerine Getirilmedi',
          //               style: TextStyle(
          //                   color: _isNotDone
          //                       ? APPColors.Main.black
          //                       : APPColors.Main.white),
          //             ),
          //             onPressed: () => setState(() => {
          //                   _isDone = false,
          //                   _isNotDone = !_isNotDone,
          //                   _activityCode = 'AR00000001336'
          //                 })

          //             // Navigator.pop(
          //             //     context),
          //             ),
          //       ),
          //     ),
             
          //   ],
          // ),
           listViewProvider.issueOperationList[0].IS_PHOTO == true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isPhoto
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Fotoğraf Ekle',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: _isPhoto
                                ? APPColors.Main.black
                                : APPColors.Main.white,
                                ),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = true,
                          _isTakeOver = false,
                          _isActivity = false,
                          _isChangeCFG = false,
                          _isSparepart = false,
                          _isPlannedCancel = false,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),
           listViewProvider.issueOperationList[0].IS_ACTIVITY == true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isActivity
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Aktivite Ekle',
                        style: TextStyle(
                            color: _isActivity
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = false,
                          _isTakeOver = false,
                          _isActivity = true,
                          _isChangeCFG = false,
                          _isSparepart = false,
                          _isPlannedCancel = false,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),
              listViewProvider.issueOperationList[0].IS_CHANGE_CFG== true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isChangeCFG
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Varlık Değiştir',
                        style: TextStyle(
                            color: _isChangeCFG
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = false,
                          _isTakeOver = false,
                          _isActivity = false,
                          _isChangeCFG = true,
                          _isSparepart = false,
                          _isPlannedCancel = false,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),
              listViewProvider.issueOperationList[0].IS_TAKE_OVER== true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isTakeOver
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Üzerine Al',
                        style: TextStyle(
                            color: _isTakeOver
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = false,
                          _isTakeOver = true,
                          _isActivity = false,
                          _isChangeCFG = false,
                          _isSparepart = false,
                          _isPlannedCancel = false,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),
              listViewProvider.issueOperationList[0].IS_PLANNED_CANCEL== true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isPlannedCancel
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Randevu İptal',
                        style: TextStyle(
                            color: _isPlannedCancel
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = false,
                          _isTakeOver = false,
                          _isActivity = false,
                          _isChangeCFG = false,
                          _isSparepart = false,
                          _isPlannedCancel = true,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),
              listViewProvider.issueOperationList[0].IS_SPAREPART== true ?
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size.width/1.09,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: APPColors.Main.grey),
                          shadowColor: APPColors.Main.black,
                          elevation: 10,
                          backgroundColor: _isSparepart
                              ? APPColors.Main.white
                              : APPColors.Modal.blue),
                      child: Text(
                        'Yedek Parça Gerekiyor',
                        style: TextStyle(
                            color: _isSparepart
                                ? APPColors.Main.black
                                : APPColors.Main.white),
                      ),
                      onPressed: () => setState(() => {
                          _isPhoto = false,
                          _isTakeOver = false,
                          _isActivity = false,
                          _isChangeCFG = false,
                          _isSparepart = true,
                          _isPlannedCancel = false,
                          })
                
                      // Navigator.pop(
                      //     context),
                      ),
                ),
              ) : Container(),

        ],
      ),
    );
  }
}
