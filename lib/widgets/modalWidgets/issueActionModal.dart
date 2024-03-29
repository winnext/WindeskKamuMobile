// ignore_for_file: avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:win_kamu/providers/issueaction_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/providers/new_notif_provider.dart';
import 'package:win_kamu/widgets/issueWidgets/changeCfgScreen.dart';

import '../../pages/full_screen_modal/full_screen_modal.dart';
import '../../pages/issue/issueSummary.dart';
import '../../providers/detail_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
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
  bool _isLoading = false;
  String _textInput = '';
  String _spaceTextInput = '';
  String _asgGroupValue = '';
  String _asgUserValue = '';
  @override
  void initState() {
    final issueActionProvider =
        Provider.of<IssueActionProvider>(context, listen: false);
    final newNotifProvider =
        Provider.of<NewNotifProvider>(context, listen: false);

    issueActionProvider.activityListView.clear();
    issueActionProvider.getAvailableActivities(widget.code);

    newNotifProvider.setlocCode = '';
    newNotifProvider.setserialNumber = '';
    newNotifProvider.setentityCode = '';
    newNotifProvider.setrfid = '';
    print('photoAdressinitial ::  ${newNotifProvider.imagePath}');
  }

  @override
  void dispose() {
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
          .push(MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return new TakePictureScreen(
          camera: firstCamera,
          sayfa: 'addPhoto',
        );
      }));
    }

    Size size = MediaQuery.of(context).size;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
    final issueActionProvider = Provider.of<IssueActionProvider>(context);
    final nProvider = Provider.of<NewNotifProvider>(context, listen: true);
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
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
              _isPhoto
                  ? SingleChildScrollView(
                      child: Container(
                        color: APPColors.Main.white,
                        width: size.width / 1.09,
                        child: Column(
                          children: [
                            nProvider.imagePath.toString() != ''
                                ? Container(
                                    height: size.width / 4,
                                    width: size.width / 4,
                                    child: Image.file(
                                      File(nProvider.imagePath.toString()),
                                    ))
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _textInput = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Açıklama Giriniz',
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showModal(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          size.width / 10),
                                      color: APPColors.Clear.blue,
                                    ),
                                    width: size.width / 5,
                                    height: size.width / 5,
                                    padding: const EdgeInsets.all(8),
                                    child:
                                        const Icon(Icons.camera_alt_outlined)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        nProvider.setimagePath = '';
                                        nProvider.setbase64 = '';
                                        _isPhoto = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: APPColors.Clear.red,
                                      ),
                                      width: size.width / 3,
                                      height: size.width / 10,
                                      padding: const EdgeInsets.all(8),
                                      // Change button text when light changes state.
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Vazgeç',
                                          style: TextStyle(
                                              color: APPColors.Main.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RoundedLoadingButton(
                                      width: size.width / 3,
                                      height: size.width / 10,
                                      borderRadius: 10,
                                      successColor: Colors.amber,
                                      controller: _btnController,
                                      onPressed: () async {
                                        issueActionProvider
                                            .setisPhotoAddSuccess = '';
                                        nProvider.base64 != ''
                                            ? issueActionProvider
                                                .addAttachmentMethod(
                                                    widget.xusercode,
                                                    widget.code,
                                                    'issue',
                                                    _textInput,
                                                    nProvider.base64)
                                            : null;
                                        Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                          _btnController.success();
                                          _btnController.reset();
<<<<<<< HEAD
                                          final photoResult =
                                              issueActionProvider
                                                  .isPhotoAddSuccess
                                                  .toString();
=======
                                          final photoResult = issueActionProvider.isPhotoAddSuccess.toString();

                                          print('photoo$photoResult');
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e
                                          Navigator.pop(context);
                                          snackBar(
                                              context,
                                              photoResult == 'success'
                                                  ? 'Fotoğraf Ekleme Başarılı'
                                                  : 'Fotoğraf Ekleme Başarısız',
                                              photoResult);
                                        });
                                      },
                                      valueColor: Colors.white,
                                      child: const Text('Kaydet',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
              listViewProvider.issueOperationList[0].IS_ACTIVITY == true
                  ? SizedBox(
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
                  ? SizedBox(
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
                  ? SizedBox(
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
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          listViewProvider.getIssueOperations(
                              widget.code, widget.xusercode);

                          detailViewProvider.loadData(widget.code.toString(), widget.xusercode.toString());

                          String snackBarText = issueActionProvider.takeOverMessage.toString();
                          String takeOverSuccess = issueActionProvider.takeOverResult.toString();

                          snackBar(context, takeOverSuccess == 'success' ? '$snackBarText' : '$snackBarText', takeOverSuccess);

<<<<<<< HEAD
                          snackBar(
                              context,
                              takeOverSuccess == 'success'
                                  ? '$snackBarText'
                                  : '$snackBarText',
                              takeOverSuccess);

=======
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e
                          Navigator.pop(context);
                        });
                      },
                      title: 'Üzerine Al',
                      text:
                          'Bu vakayı üzerinize almak istediğinizden emin misiniz?',
                      success: true,
                      confirmButtonText: 'Tamam')
                  : Container(),
              listViewProvider.issueOperationList[0].IS_PLANNED_CANCEL == true
                  ? SizedBox(
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
              _isPlannedCancel
                  ? TakeOverIssue(
                      onConfirm: () {
                        issueActionProvider.cancelIssuePlanned(
                            widget.code, widget.xusercode);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          listViewProvider.getIssueOperations(
                              widget.code, widget.xusercode);
                          String snackBarText =
                              issueActionProvider.cancelIssueMessage.toString();
                          String isSuccess =
                              issueActionProvider.cancelIssueResult.toString();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const IssueSummary(),
                            ),
                          );
                          snackBar(
                              context,
                              isSuccess == 'success'
                                  ? 'Randevu İptal Başarılı'
                                  : 'Randevu İptal Başarısız',
                              isSuccess);
                        });
                      },
                      title: 'Randevu Talebi',
                      text:
                          'Bu talebin randevusunu iptal etmek istediğinize emin misiniz?',
                      success: true,
                      confirmButtonText: 'Tamam')
                  : Container(),
              listViewProvider.issueOperationList[0].IS_SPAREPART == true
                  ? SizedBox(
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
              _isSparepart
                  ? TakeOverIssue(
                      onConfirm: () {
                        issueActionProvider.createSparepartIssue(
                            widget.code, widget.xusercode);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          listViewProvider.getIssueOperations(
                              widget.code, widget.xusercode);
                          String snackBarText = issueActionProvider
                              .createSparepartIssueMessage
                              .toString();
                          String isSuccess = issueActionProvider
                              .createSparepartIssueResult
                              .toString();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const IssueSummary(),
                            ),
                          );
                          snackBar(
                              context,
                              isSuccess == 'success'
                                  ? snackBarText
                                  : snackBarText,
                              isSuccess);
                        });
                      },
                      title: 'Yedek Parça Talebi',
                      text: 'Bu işleme devam etmek istediğinize emin misiniz?',
                      success: true,
                      confirmButtonText: 'Tamam')
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
