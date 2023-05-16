import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_kamu/providers/issueaction_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/providers/new_notif_provider.dart';
import 'package:win_kamu/widgets/issueWidgets/changeCfgScreen.dart';

import '../../pages/full_screen_modal/full_screen_modal.dart';
import '../../providers/detail_view_provider.dart';
import '../../providers/issueaction_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
import '../dialogWidgets/customSimpleDialog.dart';
import '../issueWidgets/addActivityScreen.dart';
import '../issueWidgets/takeOverIssueScreen.dart';

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
  bool _cameraOn = false;
  bool _isNotDone = false;

  @override
  void initState() {
    // final listViewProvider =
    //     Provider.of<ListViewProvider>(context, listen: false);
    // final issueActionProvider =
    //     Provider.of<IssueActionProvider>(context, listen: false);
    // issueActionProvider.setactivityCode = '';
    // issueActionProvider.setactivityName = '';
    // listViewProvider.getIssueOperations(widget.code, widget.xusercode);
    // issueActionProvider.getAvailableActivities(widget.code);
    // issueActionProvider.getLiveSelectAsgGroups(widget.code);
    // issueActionProvider
    //     .getLiveSelectAsgUser(issueActionProvider.liveSelectGroupCode);
    // print('widget.code' + issueActionProvider.activityListView[0].ACTIVITYID.toString());
    // //issueActionProvider.getLiveSelectAsgGroups(widget.code);
    // super.initState();
    final newNotifProvider =
        Provider.of<NewNotifProvider>(context, listen: false);
    newNotifProvider.setlocCode = '';
    newNotifProvider.setserialNumber= '';
    newNotifProvider.setentityCode = '';
    newNotifProvider.setrfid= '';

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic _showModal(BuildContext context) async {
      // show the modal dialog and pass some data to it
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;
      final results = await Navigator.of(context)
          .push(new MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return new TakePictureScreen(
          camera: firstCamera,
          sayfa: 'Yeni İş Emri',
        );
      }));
    }

    Size size = MediaQuery.of(context).size;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final issueActionProvider = Provider.of<IssueActionProvider>(context);

    final operations = listViewProvider.issueOperationList.toString();

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              _isPhoto ? _showModal(context) : Container(),
              listViewProvider.issueOperationList[0].IS_PHOTO == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isPhoto
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Fotoğraf Ekle',
                                  style: TextStyle(
                                    color: _isPhoto
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isPhoto
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isPhoto
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isPhoto = !_isPhoto,
                                  _isTakeOver = false,
                                  _isActivity = false,
                                  _isChangeCFG = false,
                                  _isSparepart = false,
                                  _isPlannedCancel = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
              listViewProvider.issueOperationList[0].IS_ACTIVITY == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isActivity
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Aktivite Ekle',
                                  style: TextStyle(
                                    color: _isActivity
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isActivity
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isActivity
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isActivity = !_isActivity,
                                  _isTakeOver = false,
                                  _isPhoto = false,
                                  _isChangeCFG = false,
                                  _isSparepart = false,
                                  _isPlannedCancel = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
              _isActivity
                  ? AddActivityScreen(
                      issueCode: widget.code,
                    )
                  : Container(),
              listViewProvider.issueOperationList[0].IS_CHANGE_CFG == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isChangeCFG
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Varlık Değiştir',
                                  style: TextStyle(
                                    color: _isChangeCFG
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isChangeCFG
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isChangeCFG
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isChangeCFG = !_isChangeCFG,
                                  _isTakeOver = false,
                                  _isActivity = false,
                                  _isPhoto = false,
                                  _isSparepart = false,
                                  _isPlannedCancel = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
              _isChangeCFG
                  ? ChangeCfgScreen(
                      issueCode: widget.code,
                    )
                  : Container(),
              listViewProvider.issueOperationList[0].IS_TAKE_OVER == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isTakeOver
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Üzerine Al',
                                  style: TextStyle(
                                    color: _isTakeOver
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isTakeOver
                                    ? Icons.handshake_outlined
                                    : Icons.arrow_drop_down_rounded,
                                color: _isTakeOver
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isTakeOver = !_isTakeOver,
                                  _isPhoto = false,
                                  _isActivity = false,
                                  _isChangeCFG = false,
                                  _isSparepart = false,
                                  _isPlannedCancel = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
              _isTakeOver
                  ? TakeOverIssue(
                      onConfirm: () {
                        issueActionProvider.takeOverIssue(
                            widget.code, widget.xusercode);
                        listViewProvider.getIssueOperations(
                            widget.code, widget.xusercode);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          String snackBarText =
                              issueActionProvider.takeOverMessage.toString();
                          String takeOverSuccess =
                              issueActionProvider.takeOverResult.toString();

                          Navigator.pop(context);
                          snackBar(
                              context,
                              takeOverSuccess == 'success'
                                  ? '$snackBarText'
                                  : '$snackBarText',
                              takeOverSuccess);
                        });
                      },
                      title: 'Üzerine Al',
                      text:
                          'Bu vakayı üzerinize almak istediğinizden emin misiniz?',
                      success: true,
                      confirmButtonText: 'Tamam')
                  : Container(),
              listViewProvider.issueOperationList[0].IS_PLANNED_CANCEL == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isPlannedCancel
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Randevu İptal',
                                  style: TextStyle(
                                    color: _isPlannedCancel
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isPlannedCancel
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isPlannedCancel
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isPlannedCancel = !_isPlannedCancel,
                                  _isTakeOver = false,
                                  _isActivity = false,
                                  _isChangeCFG = false,
                                  _isSparepart = false,
                                  _isPhoto = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
              listViewProvider.issueOperationList[0].IS_SPAREPART == true
                  ? Container(
                      width: size.width / 1.09,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shadowColor: APPColors.Main.black,
                              elevation: 10,
                              backgroundColor: _isSparepart
                                  ? APPColors.Main.white
                                  : APPColors.Modal.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Yedek Parça Gerekiyor',
                                  style: TextStyle(
                                    color: _isSparepart
                                        ? APPColors.Main.black
                                        : APPColors.Main.white,
                                  ),
                                ),
                              ),
                              Icon(
                                _isSparepart
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isSparepart
                                    ? APPColors.Main.black
                                    : APPColors.Main.white,
                              )
                            ],
                          ),
                          onPressed: () async {
                            setState(() => {
                                  _isSparepart = !_isSparepart,
                                  _isTakeOver = false,
                                  _isActivity = false,
                                  _isChangeCFG = false,
                                  _isPhoto = false,
                                  _isPlannedCancel = false,
                                });
                          }
                          // Navigator.pop(
                          //     context),
                          ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
