// ignore_for_file: use_build_context_synchronously, deprecated_member_use, file_names, non_constant_identifier_names

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
<<<<<<< HEAD
import 'package:win_kamu/pages/WorkOrder/woEforts.dart';
import 'package:win_kamu/utils/themes.dart';
=======
import 'package:win_kamu/pages/WorkOrder/get_photo_sheet.dart';
import 'package:win_kamu/pages/WorkOrder/wo_personals.dart';
import 'package:win_kamu/widgets/dialogWidgets/image_dialog.dart';
import 'package:win_kamu/widgets/dialogWidgets/pdf_dialog.dart';
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e

import '../../providers/workorder_detail_provider.dart';
import '../../utils/themes.dart';
import 'add_documant_sheet.dart';
import 'woEforts.dart';
import 'woSpareParts.dart';

class WoOperation extends StatefulWidget {
  final String woCode;
  const WoOperation({required this.woCode, super.key});

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
  final String _fileIdLabel = 'Belge numarası';
  final String _delete = 'Sil';
  final String _files = 'Dosyalar';

  @override
  void initState() {
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: false);
    woDetailViewProvider.setEforlarArray = [];
    woDetailViewProvider.setMalzemelerArray = [];

    woDetailViewProvider.getWorkOrderWorklogs(widget.woCode);
    woDetailViewProvider.getWorkorderSpareParts(widget.woCode);
    woDetailViewProvider.fetchFiles();
    woDetailViewProvider.loadAllPersonalsDetailed();

    super.initState();
  }

  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: true);
    return Sizer(builder: (context, Orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.all(35.0),
        child: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black54,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            _efortsAccordionSection(context, woDetailViewProvider),
            _materialsAccordionSection(woDetailViewProvider, context),
            _personalsAccordionSection(woDetailViewProvider, context),
            _documantsPhotosAccordionSection(woDetailViewProvider, context),
            _instructionsAccordionSection(),
          ],
        ),
      );
    });
  }

<<<<<<< HEAD
                leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                header: Text('Eforlar', style: _headerStyle),
                contentBorderColor: const Color(0xffffffff),
                headerBackgroundColorOpened: Colors.black,
                content: Accordion(
                  maxOpenSections: 1,
                  headerBackgroundColorOpened: Colors.black54,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  children: [
                    AccordionSection(
                      isOpen: false,
                      
                      leftIcon:
                          const Icon(Icons.add, color: Colors.white),
                      headerBackgroundColor: Colors.green,
                      headerBackgroundColorOpened: Colors.black,
                      header: Text('Efor Ekle', style: _headerStyle),
                      content:    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                      
                          ),
                        ),
                        onPressed: () {
                         setState(() {
                  dropdownvalueSureSeciniz = 'Lütfen Süre Seçiniz';
                });
=======
  AccordionSection _instructionsAccordionSection() {
    return AccordionSection(
      isOpen: false,
      leftIcon: const Icon(Icons.contact_page, color: Colors.white),
      header: Text(_instructions, style: _headerStyle),
      content: Wrap(
        children: List.generate(
            30,
            (index) => const Icon(Icons.contact_page,
                size: 30, color: Color(0xff999999))),
      ),
    );
  }
>>>>>>> 7c825ae1c3be870afca98609aae6bca89bc40b8e

  AccordionSection _materialsAccordionSection(
      WoDetailViewProvider woDetailViewProvider, BuildContext context) {
    return AccordionSection(
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {
                await woDetailViewProvider.getStore();

                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
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
              dataRowHeight: 70,
              showBottomBorder: true,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                    label: Text('Ürün', style: _contentStyleHeader),
                    numeric: false),
                DataColumn(label: Text('Adet', style: _contentStyleHeader)),
                DataColumn(label: Text(_delete, style: _contentStyleHeader)),
              ],
              rows: [
                for (var i = 0;
                    i < woDetailViewProvider.malzemelerArray[1].length;
                    i++)
                  DataRow(
                    cells: [
                      DataCell(Text(woDetailViewProvider.malzemelerArray[1][i],
                          style: _contentStyle, textAlign: TextAlign.left)),
                      DataCell(Text(woDetailViewProvider.malzemelerArray[2][i],
                          style: _contentStyle)),
                      DataCell(GestureDetector(
                        onTap: () {
                          woDetailViewProvider.deleteSpareParts(
                            context,
                            woDetailViewProvider.malzemelerArray[0][i],
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ))
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AccordionSection _efortsAccordionSection(
      BuildContext context, WoDetailViewProvider woDetailViewProvider) {
    return AccordionSection(
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () {
                setState(() {});
                woDetailViewProvider.setSureDegeri = 'Lütfen Süre Seçiniz';
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return WoEforts(woCode: widget.woCode);
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
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                horizontalMargin: 0,
                sortAscending: true,
                sortColumnIndex: 1,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                      label: Text('Kullanıcı', style: _contentStyleHeader),
                      numeric: false),
                  DataColumn(label: Text('Süre', style: _contentStyleHeader)),
                  DataColumn(label: Text(_delete, style: _contentStyleHeader)),
                ],
                rows: [
                  for (var i = 0;
                      i < woDetailViewProvider.eforlarArray[1].length;
                      i++)
                    DataRow(
                      cells: [
                        DataCell(Text(woDetailViewProvider.eforlarArray[1][i],
                            style: _contentStyle, textAlign: TextAlign.left)),
                        DataCell(Text(woDetailViewProvider.eforlarArray[2][i],
                            style: _contentStyle)),
                        DataCell(GestureDetector(
                          onTap: () {
                            woDetailViewProvider.deleteEffort(
                                context,
                                woDetailViewProvider.eforlarArray[0][i],
                                widget.woCode);
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ))
                      ],
                    )

                  //  TextButton(onPressed: (){woDetailViewProvider.deleteEffort(context,woDetailViewProvider.eforlarArray[0][i],widget.woCode );  }, child: Center(child: Text('X',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AccordionSection _documantsPhotosAccordionSection(
      WoDetailViewProvider woDetailViewProvider, BuildContext context) {
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {
                showModalBottomSheet<void>(
                  // give radius to the created modal
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const GetPhotoSheet();
                  },
                ).then((value) {
                  woDetailViewProvider.fetchFiles();
                });
              },
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {
                showModalBottomSheet<void>(
                  // give radius to the created modal
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const AddDocumantSheet();
                  },
                ).then((value) {
                  woDetailViewProvider.fetchFiles();
                  woDetailViewProvider.setIsDocumantPicked = false;
                });
              },
              child: Text(_addDocuments),
            ),
          ),
          AccordionSection(
            isOpen: false,
            leftIcon: const Icon(Icons.document_scanner, color: Colors.white),
            header: Text(_files, style: _headerStyle),
            headerBackgroundColor: APPColors.Login.blue,
            headerBackgroundColorOpened: Colors.black,
            contentBorderColor: Colors.black54,
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortAscending: true,
                sortColumnIndex: 1,
                showBottomBorder: true,
                horizontalMargin: 0,
                columns: [
                  DataColumn(
                      label: Text(_fileIdLabel,
                          style: _contentStyleHeader,
                          textAlign: TextAlign.left),
                      numeric: false),
                  DataColumn(label: Text(_delete, style: _contentStyleHeader)),
                ],
                rows: [
                  for (var i = 0;
                      i < woDetailViewProvider.documants.length;
                      i++)
                    DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: InkWell(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => ImageDialog(
                                    imageUrl: woDetailViewProvider.getFilePath(
                                        woDetailViewProvider.documants[i].id
                                            .toString()),
                                  ),
                                );
                              },
                              child: Text(
                                  '${woDetailViewProvider.documants[i].id} li belge',
                                  style: _contentStyle,
                                  textAlign: TextAlign.left),
                            ),
                          ),
                        ),
                        const DataCell(
                          InkWell(
                            child: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AccordionSection _personalsAccordionSection(
      WoDetailViewProvider woDetailViewProvider, BuildContext context) {
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () async {
                await woDetailViewProvider.loadShiftings();
                await woDetailViewProvider.loadAllPersonals();

                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return WoPersonals(
                      woCode: widget.woCode,
                      shiftings: woDetailViewProvider.shiftings,
                      personals: woDetailViewProvider.workOrderPersonals,
                    );
                  },
                ).then((value) => {
                      if (woDetailViewProvider.isNewPersonalAdded)
                        woDetailViewProvider.loadAllPersonalsDetailed()
                    });
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
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortAscending: true,
                sortColumnIndex: 1,
                showBottomBorder: true,
                horizontalMargin: 0,
                columns: [
                  DataColumn(
                      label: Text('Kullanıcı', style: _contentStyleHeader),
                      numeric: false),
                  DataColumn(label: Text('Süre', style: _contentStyleHeader)),
                  DataColumn(label: Text('Sil', style: _contentStyleHeader)),
                ],
                rows: [
                  for (var i = 0;
                      i <
                          woDetailViewProvider
                              .workOrderPersonalsDetailed.length;
                      i++)
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                              woDetailViewProvider
                                  .workOrderPersonalsDetailed[i].name
                                  .toString(),
                              style: _contentStyle,
                              textAlign: TextAlign.left),
                        ),
                        DataCell(
                          Text(
                            '${woDetailViewProvider.workOrderPersonalsDetailed[i].vardiya!.split('-')[1]} - ${woDetailViewProvider.workOrderPersonalsDetailed[i].vardiya!.split('-')[2]}',
                            style: _contentStyle,
                          ),
                        ),
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                woDetailViewProvider.deleteWorkOrderPersonal(
                                    context,
                                    woDetailViewProvider
                                        .workOrderPersonalsDetailed[i]
                                        .modulecode
                                        .toString());
                              },
                              child:
                                  const Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
