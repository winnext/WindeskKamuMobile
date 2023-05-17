// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/detail_activities.model.dart';
import 'package:win_kamu/models/list_view.model.dart';
import 'package:win_kamu/pages/homePage.dart';
import 'package:win_kamu/pages/mainPage.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/providers/detail_view_provider.dart';
import 'package:win_kamu/providers/list_view_provider.dart';
import 'package:win_kamu/providers/login_provider.dart';
import 'package:win_kamu/providers/main_page_view_provider.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:provider/provider.dart';
import '../../api/api_repository.dart';
import '../../l10n/locale_keys.g.dart';
import '../../utils/global_utils.dart';
import '../../utils/time_Utils.dart';
import '../../widgets/customInfoNotFound.dart';
import '../../widgets/ListWidgets/customIssueListWidget.dart';
import '../homePage.dart';
import 'closeRequestsDetail.dart';

class CloseRequestListScreen extends StatefulWidget {
  static String pageName = 'listPageCloseRequests';

  const CloseRequestListScreen({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  State<CloseRequestListScreen> createState() => _CloseRequestListScreenState();
}

final apirepository = APIRepository();

ListViewProvider? listViewProvider;
DetailViewProvider? detailViewProvider;

class _CloseRequestListScreenState extends State<CloseRequestListScreen> {
  bool _isDone = false;
  bool _isNotDone = false;

  Color primaryColor = APPColors.Modal.blue;
  @override
  void initState() {
    super.initState();
    final exampleList = Provider.of<ListViewProvider>(context, listen: false);
    exampleList.exampleListView.clear();
    exampleList.loadData(1, 'PendingIssuesIsCustomer');
    exampleList.initData(widget.pageController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    detailViewProvider?.dispose();
    listViewProvider?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int l = -1;
    final listViewProvider = Provider.of<ListViewProvider>(context);
    final detailViewProvider = Provider.of<DetailViewProvider>(context);
    int index = listViewProvider.currentPage;

    Size size = MediaQuery.of(context).size;
    print(
        'listViewLength' + listViewProvider.exampleListView.length.toString());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: APPColors.Main.white,
            title: Text(
              'Kapatma Onayı',
              style: TextStyle(fontSize: 20, color: APPColors.Secondary.black),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                 listViewProvider.pageController!.jumpTo(0);
                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  listViewProvider.exampleListView.isNotEmpty
                      ? Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification:
                                listViewProvider.notificationController,
                            child: ListView.builder(
                                itemCount:
                                    listViewProvider.exampleListView.length,
                                itemBuilder: (BuildContext context, int i) {
                                  l++;
                                  if (l == 5) {
                                    l = 0;
                                  }
                                  String formattedDate = "";
                                  ListViewModel listElements =
                                      listViewProvider.exampleListView[i];

                                  final TARGET_FDATE =
                                      timeRecover(listElements.TARGET_FDATE);
                                  final TARGET_RDATE =
                                      timeRecover(listElements.TARGET_RDATE);
                                  final time = DateTime.now();
                                  final String timeNow =
                                      DateFormat('yMMddhhmmss')
                                          .format(time)
                                          .toString();
                                  if (listElements.RESPONDED_IDATE != null &&
                                      listElements.TARGET_FDATE != null) {
                                    print('responsedI');

                                    print(int.parse(listElements.RESPONDED_IDATE
                                            .toString()) -
                                        int.parse(listElements.TARGET_RDATE
                                            .toString()));
                                  }

                                  return Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TaskListWidget(
                                              importanceLevelColor:
                                                  generateColor(l),
                                              code:
                                                  listElements.CODE.toString(),
                                              targetFDate:
                                                  listElements.TARGET_FDATE,
                                              targetRDate:
                                                  listElements.TARGET_RDATE,
                                              taskNo: i.toString(),
                                              description: listElements
                                                  .DESCRIPTION
                                                  .toString(),
                                              sumdesc1: listElements.SUMDESC1
                                                  .toString(),
                                              statusName: listElements.STATUSNAME
                                                  .toString(),
                                              space:
                                                  listElements.SPACE.toString(),
                                              location: listElements.LOCATION
                                                  .toString(),
                                              idate:
                                                  listElements.IDATE.toString(),
                                              statusCode: listElements.STATUSCODE
                                                  .toString(),
                                              planedDate: listElements.PLANNEDDATE
                                                  .toString(),
                                              respondedIDate: listElements
                                                  .RESPONDED_IDATE
                                                  .toString(),
                                              responseTimer: listElements
                                                  .response_timer
                                                  .toString(),
                                              fixedTimer: listElements
                                                  .fixed_timer
                                                  .toString(),
                                              fixedIDate: listElements
                                                  .FIXED_IDATE
                                                  .toString(),
                                              timeInfoNow: timeNow,
                                              isIcon: true,
                                              onPressed: (code) {
                                                detailViewProvider
                                                    .setIssueCode = code;
                                                Navigator.pushNamed(
                                                    context,
                                                    CloseRequestDetail
                                                        .closeRequestDetail);
                                                print('tiklandi' + code);
                                              },
                                              onPressedLong: () {
                                                return showModalBottomSheet<
                                                    void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBottomSheet(
                                                      code: listElements.CODE,
                                                    );
                                                  },
                                                );
                                              }
                                              // extraTitle:
                                              //     listElements.STATUSCODE.toString(),
                                              )
                                            ),
                                    ],
                                  );
                                }),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: const Center(child: AramaSonucBos()),
                        ),
                ],
              ),
              if (listViewProvider.isDataLoading == true) ...[
                loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
              ],
            ],
          )),
    );
  }

  Widget sayfaYenile() {
    return Consumer<ListViewProvider>(
        builder: (context, listViewProvider, child) {
      return InkWell(
        onTap: () {
          setState(() {
            listViewProvider.setisDataLoading = true;
            listViewProvider.exampleListView.clear();
            listViewProvider.setcurrentPage = 1;
            listViewProvider.loadData(
                listViewProvider.currentPage, 'PendingIssuesIsCustomer');
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(height_18),
          child: Icon(Icons.refresh),
        ),
      );
    });
  }
}

class StatefulBottomSheet extends StatefulWidget {
  String? code;
  StatefulBottomSheet({super.key, this.code});
  @override
  // ignore: library_private_types_in_public_api
  _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
}

DetailViewProvider? detailActivities;

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
    // TODO: implement dispose
    detailActivities?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailActivities =
        Provider.of<DetailViewProvider>(context, listen: true);

    final loginProvider =
        Provider.of<MainPageViewProvider>(context, listen: true);

    Size size = MediaQuery.of(context).size;
    print('activitiesCOde' +
        widget.code.toString() +
        ' ' +
        loginProvider.kadi.toString() +
        ' ' +
        this._activityCode.toString() +
        ' ' +
        textInput.text.toString());

    return Container(
      height: size.height / 3,
      color: APPColors.Modal.blue,
      child: Column(
        children: [
          Text(
            widget.code.toString(),
            style: TextStyle(color: Colors.white),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: textInput,
              style: TextStyle(fontSize: 15, color: APPColors.Main.white),
              decoration: InputDecoration(
                filled: true,
                hintText: 'Açıklama giriniz.',
                hintStyle: TextStyle(color: Colors.white),
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
                print('value' + value.toString());
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
                          // final response = detailActivities.sendIssueActivity(
                          //     widget.code.toString(),
                          //     loginProvider.kadi.toString(),
                          //     this._activityCode.toString(),
                          //     textInput.text.toString());
                          // print(
                          //     'activity print ------: ' + response.toString());
                          Navigator.pop(context);
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogExample(
                                code: widget.code.toString(),
                                kadi: loginProvider.kadi.toString(),
                                activityCode: this._activityCode.toString(),
                                input: textInput.text.toString(),
                              );
                            },
                          );
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
                        onPressed: () => setState(
                            () => {_isDone = false, _isNotDone = !_isNotDone})

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

class DialogExample extends StatefulWidget {
  String? code;
  String? kadi;
  String? activityCode;
  String? input;

  DialogExample(
      {super.key, this.activityCode, this.code, this.input, this.kadi});

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  String test = 'Aktivite girişi başarılı';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final detailActivities =
          Provider.of<DetailViewProvider>(context, listen: false);
      final answer = await detailActivities.sendIssueActivity(
          widget.code.toString(),
          widget.kadi.toString(),
          widget.activityCode.toString(),
          widget.input.toString());
      setState(() {
        test = answer.toString();
      });
      print('activityProvider' + test.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print('activityProviderrrr' + test.toString());

    return AlertDialog(
      title: Text(test.toString()),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Çıkış'),
        ),
        TextButton(
          onPressed: () => {
            sayfaYenile(),
            Navigator.pop(context),
          },
          child: Text('Tamam'),
        ),
      ],
    );
  }

  sayfaYenile() {
    final listViewProvider =
        Provider.of<ListViewProvider>(context, listen: false);

    setState(() {
      listViewProvider.setisDataLoading = true;
      listViewProvider.exampleListView.clear();
      listViewProvider.setcurrentPage = 1;
      listViewProvider.loadData(
          listViewProvider.currentPage, 'PendingIssuesIsCustomer');
    });
  }
}
