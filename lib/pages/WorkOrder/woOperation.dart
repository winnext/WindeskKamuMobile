// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/WorkOrder/wo_personals.dart';

import '../../providers/workorder_detail_provider.dart';
import '../../utils/themes.dart';
import 'woEforts.dart';
import 'woSpareParts.dart';

class WoOperation extends StatefulWidget {
  final woCode;
  const WoOperation({
    required this.woCode,
    super.key,
  });

  @override
  State<WoOperation> createState() => _WoOperationState();
}

class _WoOperationState extends State<WoOperation> {
  final String _personals = 'Personeller';
  final String _documantsPhotos = 'Dökümanlar ve Fotoğraflar';
  final String _addPictures = 'Fotoğraf Ekle';
  final String _addDocuments = 'Döküman Ekle';
  final String _addNewPersonals = 'Yeni Personel Ekle';
  final String _instructions = 'Talimatlar';

  @override
  void initState() {
    final woDetailViewProvider = Provider.of<WoDetailViewProvider>(context, listen: false);
    woDetailViewProvider.setEforlarArray = [];
    woDetailViewProvider.getWorkOrderWorklogs(widget.woCode);

    woDetailViewProvider.loadAllPersonalsDetailed();

    super.initState();
  }

  final _headerStyle = const TextStyle(color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  String _dropdownvalueSureSeciniz = 'Lütfen Süre Seçiniz';

  @override
  Widget build(BuildContext context) {
    final woDetailViewProvider = Provider.of<WoDetailViewProvider>(context, listen: true);
    return Sizer(builder: (context, Orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: APPColors.Login.blue,
              leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
              header: Text('Eforlar', style: _headerStyle),
              contentBorderColor: const Color(0xffffffff),
              headerBackgroundColorOpened: Colors.black,
              content: Accordion(
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                children: [
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.add, color: Colors.white),
                    headerBackgroundColor: Colors.green,
                    headerBackgroundColorOpened: Colors.black,
                    header: Text('Efor Ekle', style: _headerStyle),
                    content: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () {
                        setState(() {
                          _dropdownvalueSureSeciniz = 'Lütfen Süre Seçiniz';
                        });

                        showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          isScrollControlled: true,
                          // context and builder are
                          // required properties in this widget
                          context: context,
                          builder: (BuildContext context) {
                            // we set up a container inside which
                            // we create center column and display text

                            // Returning SizedBox instead of a Container
                            return WoEforts(
                              woCode: widget.woCode,
                            );
                          },
                        );
                      },
                      child: const Text('Yeni Efor Ekle'),
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderColor: Colors.black54,
                  ),
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
                    header: Text('Eforlar', style: _headerStyle),
                    headerBackgroundColor: APPColors.Login.blue,
                    headerBackgroundColorOpened: Colors.black,
                    contentBorderColor: Colors.black54,
                    content: DataTable(
                      sortAscending: true,
                      sortColumnIndex: 1,
                      dataRowHeight: 40,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(label: Text('Kullanıcı', style: _contentStyleHeader), numeric: false),
                        DataColumn(label: Text('Süre', style: _contentStyleHeader)),
                        DataColumn(
                          label: Text('Sil', style: _contentStyleHeader),
                        ),
                      ],
                      rows: [
                        for (var i = 0; i < woDetailViewProvider.eforlarArray[1].length; i++)
                          DataRow(
                            cells: [
                              DataCell(Text(woDetailViewProvider.eforlarArray[1][i], style: _contentStyle, textAlign: TextAlign.right)),
                              DataCell(Text(woDetailViewProvider.eforlarArray[2][i], style: _contentStyle)),
                              DataCell(GestureDetector(
                                onTap: () {
                                  woDetailViewProvider.deleteEffort(context, woDetailViewProvider.eforlarArray[0][i], widget.woCode);
                                },
                                child: const Icon(Icons.delete, color: Colors.red),
                              ))
                            ],
                          ),
                        //  TextButton(onPressed: (){woDetailViewProvider.deleteEffort(context,woDetailViewProvider.eforlarArray[0][i],widget.woCode );  }, child: Center(child: Text('X',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AccordionSection(
              isOpen: false,
              headerBackgroundColor: APPColors.Login.blue,
              leftIcon: const Icon(Icons.warehouse, color: Colors.white),
              header: Text('Malzemeler', style: _headerStyle),
              contentBorderColor: const Color(0xffffffff),
              headerBackgroundColorOpened: Colors.black,
              content: Accordion(
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                children: [
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.add, color: Colors.white),
                    headerBackgroundColor: Colors.green,
                    headerBackgroundColorOpened: Colors.black,
                    header: Text('Malzeme Ekle', style: _headerStyle),
                    content: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () async {
                        await woDetailViewProvider.getStore();

                        showModalBottomSheet<void>(
                          // context and builder are
                          // required properties in this widget
                          context: context,
                          builder: (BuildContext context) {
                            // we set up a container inside which
                            // we create center column and display text

                            // Returning SizedBox instead of a Container
                            return WoSpareParts(
                              woCode: widget.woCode,
                            );
                          },
                        );
                      },
                      child: const Text('Yeni Malzeme Ekle'),
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderColor: Colors.black54,
                  ),
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.warehouse, color: Colors.white),
                    header: Text('Malzemeler', style: _headerStyle),
                    headerBackgroundColor: APPColors.Login.blue,
                    headerBackgroundColorOpened: Colors.black,
                    contentBorderColor: Colors.black54,
                    content: DataTable(
                      sortAscending: true,
                      sortColumnIndex: 1,
                      dataRowHeight: 40,
                      showBottomBorder: true,
                      columns: [
                        DataColumn(label: Text('Kullanıcı', style: _contentStyleHeader), numeric: false),
                        DataColumn(label: Text('Süre', style: _contentStyleHeader)),
                        DataColumn(
                          label: Text('Sil', style: _contentStyleHeader),
                        ),
                      ],
                      rows: [
                        for (var i = 0; i < woDetailViewProvider.eforlarArray[1].length; i++)
                          DataRow(
                            cells: [
                              DataCell(Text(woDetailViewProvider.eforlarArray[1][i], style: _contentStyle, textAlign: TextAlign.right)),
                              DataCell(Text(woDetailViewProvider.eforlarArray[2][i], style: _contentStyle)),
                              DataCell(GestureDetector(
                                onTap: () {
                                  woDetailViewProvider.deleteEffort(context, woDetailViewProvider.eforlarArray[0][i], widget.woCode);
                                },
                                child: const Icon(Icons.delete, color: Colors.red),
                              ))
                            ],
                          ),
                        //  TextButton(onPressed: (){woDetailViewProvider.deleteEffort(context,woDetailViewProvider.eforlarArray[0][i],widget.woCode );  }, child: Center(child: Text('X',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _personalsAccordionSection(woDetailViewProvider, context),
            _documantsPhotosAccordionSection(woDetailViewProvider, context),
            AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.contact_page, color: Colors.white),
              header: Text(_instructions, style: _headerStyle),
              content: Wrap(
                children: List.generate(30, (index) => const Icon(Icons.contact_page, size: 30, color: Color(0xff999999))),
              ),
            ),
          ],
        ),
      );
    });
  }

  AccordionSection _documantsPhotosAccordionSection(WoDetailViewProvider woDetailViewProvider, BuildContext context) {
    return AccordionSection(
      isOpen: false,
      leftIcon: const Icon(Icons.photo_album, color: Colors.white),
      header: Text(_documantsPhotos, style: _headerStyle),
      headerBackgroundColor: APPColors.Login.blue,
      headerBackgroundColorOpened: Colors.black,
      content: Accordion(
        headerBackgroundColorOpened: Colors.black54,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: [
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.camera, color: Colors.white),
            headerBackgroundColor: Colors.green,
            headerBackgroundColorOpened: Colors.black,
            header: Text(_addPictures, style: _headerStyle),
            content: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {},
              child: Text(_addPictures),
            ),
            contentHorizontalPadding: 20,
            contentBorderColor: Colors.black54,
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.edit_document, color: Colors.white),
            header: Text(_addDocuments, style: _headerStyle),
            headerBackgroundColor: APPColors.Login.blue,
            headerBackgroundColorOpened: Colors.black,
            contentBorderColor: Colors.black54,
            content: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {},
              child: Text(_addDocuments),
            ),
          ),
        ],
      ),
    );
  }

  AccordionSection _personalsAccordionSection(WoDetailViewProvider woDetailViewProvider, BuildContext context) {
    return AccordionSection(
      isOpen: false,
      leftIcon: const Icon(Icons.person, color: Colors.white),
      header: Text(_personals, style: _headerStyle),
      headerBackgroundColor: APPColors.Login.blue,
      headerBackgroundColorOpened: Colors.black,
      content: Accordion(
        headerBackgroundColorOpened: Colors.black54,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: [
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.add, color: Colors.white),
            headerBackgroundColor: Colors.green,
            headerBackgroundColorOpened: Colors.black,
            header: Text(_addNewPersonals, style: _headerStyle),
            content: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {
                await woDetailViewProvider.loadShiftings();
                await woDetailViewProvider.loadAllPersonals();

                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return WoPersonals(
                      woCode: widget.woCode,
                      shiftings: woDetailViewProvider.shiftings,
                      personals: woDetailViewProvider.workOrderPersonals,
                    );
                  },
                ).then((value) => {if (woDetailViewProvider.isNewPersonalAdded) woDetailViewProvider.loadAllPersonalsDetailed()});
              },
              child: Text(_addNewPersonals),
            ),
            contentHorizontalPadding: 20,
            contentBorderColor: Colors.black54,
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.people, color: Colors.white),
            header: Text(_personals, style: _headerStyle),
            headerBackgroundColor: APPColors.Login.blue,
            headerBackgroundColorOpened: Colors.black,
            contentBorderColor: Colors.black54,
            content: DataTable(
              sortAscending: true,
              sortColumnIndex: 1,
              dataRowHeight: 60,
              showBottomBorder: true,
              columns: [
                DataColumn(label: Text('Kullanıcı', style: _contentStyleHeader), numeric: false),
                DataColumn(label: Text('Süre', style: _contentStyleHeader)),
                DataColumn(label: Text('Sil', style: _contentStyleHeader)),
              ],
              rows: [
                for (var i = 0; i < woDetailViewProvider.workOrderPersonalsDetailed.length; i++)
                  DataRow(
                    cells: [
                      DataCell(
                        Text(woDetailViewProvider.workOrderPersonalsDetailed[i].name.toString(), style: _contentStyle, textAlign: TextAlign.left),
                      ),
                      DataCell(Text(woDetailViewProvider.workOrderPersonalsDetailed[i].vardiya.toString(), style: _contentStyle)),
                      DataCell(Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            woDetailViewProvider.deleteWorkOrderPersonal(woDetailViewProvider.workOrderPersonalsDetailed[i].modulecode.toString());
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ))
                    ],
                  ),
                //  TextButton(onPressed: (){woDetailViewProvider.deleteEffort(context,woDetailViewProvider.eforlarArray[0][i],widget.woCode );  }, child: Center(child: Text('X',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Data {
  final String title;
  final String value;

  Data(this.title, this.value);
}
