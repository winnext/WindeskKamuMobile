import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/utils.dart';

import '../../pages/full_screen_modal/full_screen_modal.dart';
import '../../providers/detail_view_provider.dart';
import '../../providers/issueaction_provider.dart';
import '../../providers/list_view_provider.dart';
import '../../providers/new_notif_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';

class AddActivityScreen extends StatefulWidget {
  VoidCallback? onConfirm;
  String? title;
  String? text;
  bool? success;
  String? confirmButtonText;
  String? issueCode;

  AddActivityScreen({this.onConfirm, this.title, this.text, this.success, this.confirmButtonText, this.issueCode, super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  String? selectedFruit;
  String? addTimeTextInput;
  String? spaceTextInput;
  String _textInput = '';
  String spaceCode = '';
  String _addTimeTextInput = '';

  @override
  void initState() {
    final issueActionProvider = Provider.of<IssueActionProvider>(context, listen: false);
    final newNotifProvider = Provider.of<NewNotifProvider>(context, listen: false);
    issueActionProvider.setliveSelectGroupCode = '';
    issueActionProvider.setliveSelectGroupName = '';
    issueActionProvider.setliveSelectUserCode = '';
    issueActionProvider.setliveSelectUserName = '';

    super.initState();
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
      final results = await Navigator.of(context).push(MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return TakePictureScreen(
          camera: firstCamera,
          sayfa: 'addPhoto',
        );
      }));
    }

    Size size = MediaQuery.of(context).size;

    final issueActionProvider = Provider.of<IssueActionProvider>(context, listen: true);
    final newNotifProvider = Provider.of<NewNotifProvider>(context, listen: true);
    final nProvider = Provider.of<NewNotifProvider>(context, listen: true);
    final mainPageProvider = Provider.of<MainPageViewProvider>(context, listen: false);
    final listViewProvider = Provider.of<ListViewProvider>(context, listen: false);
    final detailViewProvider = Provider.of<DetailViewProvider>(context, listen: true);
    final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

    return Container(
      width: size.width / 1.09,
      height: size.height / 2.5,
      color: APPColors.Main.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton(
                  value: selectedFruit,
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Icon(Icons.arrow_drop_down, color: APPColors.Main.black),
                  ),
                  iconSize: 25,
                  underline: SizedBox(),
                  onChanged: (newValue) {},
                  hint: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      issueActionProvider.activityName.toString() == '' ? 'Durum' : issueActionProvider.activityName.toString(),
                      style: TextStyle(color: APPColors.Main.black, fontSize: 15),
                    ),
                  ),
                  items: issueActionProvider.activityListView.map((data) {
                    return DropdownMenuItem(
                      onTap: () => {
                        issueActionProvider.setassigneeccType = '',
                        issueActionProvider.setactivityName = '',
                        issueActionProvider.setactivityCode = '',
                        issueActionProvider.setbarcodeSpace = '',
                        issueActionProvider.setadditionalTimeInput = '',
                        issueActionProvider.setminDescLength = '',
                        issueActionProvider.setmobilePhoto = '',
                        issueActionProvider.setassigneeccType = data.ASSIGNEECC_TYPE.toString(),
                        issueActionProvider.setactivityName = data.NAME.toString(),
                        issueActionProvider.setactivityCode = data.CODE.toString(),
                        issueActionProvider.setbarcodeSpace = data.BARCODE_SPACE.toString(),
                        issueActionProvider.setadditionalTimeInput = data.ADDITIONALTIME_INPUT.toString(),
                        issueActionProvider.setminDescLength = data.MIN_DESC_LENGTH.toString(),
                        issueActionProvider.setmobilePhoto = data.MOBILE_PHOTO.toString(),
                      },
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
              const Divider(thickness: height_3),
              Text('Bu aktivitenin girilmesi, talebin durumunu ${issueActionProvider.activityName} olarak değiştirecektir.'),
              issueActionProvider.barcodeSpace == 'Y'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (String value) {
                              setState(() {
                                spaceTextInput = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: newNotifProvider.qrCode != '' ? newNotifProvider.qrCode : 'Mahal Kodu',
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                            icon: const Icon(
                              Icons.qr_code_2,
                              size: 40,
                            ),
                            onPressed: () {
                              newNotifProvider.scanQR('spaceCode');
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
              issueActionProvider.additionalTimeInput == 'Y'
                  ? Expanded(
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            _addTimeTextInput = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: _addTimeTextInput != '' ? _addTimeTextInput : 'Ek Süre (Gün)',
                        ),
                      ),
                    )
                  : Container(),
              issueActionProvider.assigneeccType == 'LIVESELECT'
                  ? Column(
                      children: [
                        DropdownButton(
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
                                    issueActionProvider.setliveSelectGroupCode = newValue.toString(),
                                  });
                            },
                            hint: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Text(
                                issueActionProvider.liveSelectGroupName.toString() == ''
                                    ? 'Atama grubu seçiniz...'
                                    : issueActionProvider.liveSelectGroupName.toString(),
                                style: TextStyle(color: APPColors.Main.black, fontSize: 15),
                              ),
                            ),
                            items: issueActionProvider.liveSelectAsgGroups.map((data) {
                              return DropdownMenuItem(
                                onTap: () => {
                                  issueActionProvider.setliveSelectGroupName = data.NAME.toString(),
                                  issueActionProvider.getLiveSelectAsgUser(data.CODE.toString()),
                                },
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
                              child: Icon(Icons.arrow_drop_down, color: APPColors.Main.black),
                            ),
                            iconSize: 25,
                            underline: const SizedBox(),
                            onChanged: (newValue) {
                              setState(() => {
                                    issueActionProvider.setliveSelectUserCode = newValue.toString(),
                                  });
                            },
                            hint: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Text(
                                issueActionProvider.liveSelectUserName.toString() == ''
                                    ? 'Atanan kişi seçimi yapınız...'
                                    : issueActionProvider.liveSelectUserName.toString(),
                                style: TextStyle(color: APPColors.Main.black, fontSize: 15),
                              ),
                            ),
                            items: issueActionProvider.liveSelectAsgUsers.map((data) {
                              return DropdownMenuItem(
                                onTap: () => {
                                  issueActionProvider.setliveSelectUserName = data.FULLNAME.toString(),
                                },
                                value: data.CODE.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    data.FULLNAME.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      ],
                    )
                  : Container(),
              issueActionProvider.minDescLength != '0'
                  ? TextField(
                      onChanged: (text) {
                        setState(() {
                          _textInput = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: _textInput != '' ? _textInput : 'Açıklama Giriniz',
                      ),
                    )
                  : Container(),
              issueActionProvider.mobilePhoto == 'Y'
                  ? Column(
                      children: [
                        nProvider.imagePath.toString() != ''
                            ? SizedBox(
                                height: size.width / 4,
                                width: size.width / 4,
                                child: Image.file(
                                  File(nProvider.imagePath.toString()),
                                ))
                            : Container(),
                        GestureDetector(
                          onTap: () {
                            _showModal(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(size.width / 10),
                                  color: APPColors.Clear.blue,
                                ),
                                width: size.width / 5,
                                height: size.width / 5,
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.camera_alt_outlined)),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nProvider.setimagePath = '';
                          nProvider.setbase64 = '';
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
                            style: TextStyle(color: APPColors.Main.white),
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
                          issueActionProvider.setisPhotoAddSuccess = '';
                          issueActionProvider.addActivityMethod(
                              widget.issueCode,
                              mainPageProvider.kadi,
                              issueActionProvider.activityCode,
                              _textInput.trim(),
                              spaceTextInput.toString().trim(),
                              issueActionProvider.liveSelectGroupCode,
                              issueActionProvider.liveSelectUserCode,
                              addTimeTextInput,
                              'issue',
                              nProvider.base64,
                              '',
                              '',
                              '');
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            _btnController.success();
                            _btnController.reset();

                            final activityResult = issueActionProvider.isActivityAddSuccess.toString();

                            Navigator.pop(context);
                            
                            listViewProvider.getIssueOperations(
                                widget.issueCode, mainPageProvider.kadi);
                            detailViewProvider.loadData(
                                widget.issueCode.toString(),
                                mainPageProvider.kadi.toString());
                            detailViewProvider.loadIssueSummary(
                                widget.issueCode.toString(), mainPageProvider.kadi);
                            listViewProvider.getIssueActivities(mainPageProvider.kadi, detailViewProvider.issueCode);

                            snackBar(
                                context,
                                activityResult == 'true'
                                    ? 'Aktivite girişi başarılı'
                                    : 'Aktivite girişi başarısız',
                                activityResult);
                          });
                        },
                        valueColor: APPColors.Main.white,
                        child: Text('Gönder', style: TextStyle(color: APPColors.Main.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
