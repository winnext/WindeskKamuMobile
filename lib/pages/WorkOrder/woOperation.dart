import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/WorkOrder/woEforts.dart';
import 'package:win_kamu/utils/themes.dart';

import '../../providers/workorder_detail_provider.dart';

class WoOperation extends StatefulWidget {
  final woCode;
  const WoOperation({required this.woCode,  super.key,  });

  @override
  State<WoOperation> createState() => _WoOperationState();
}

class _WoOperationState extends State<WoOperation> {

  @override
  void initState() {
    final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: false);
        woDetailViewProvider.setEforlarArray = [];
    woDetailViewProvider.getWorkOrderWorklogs(widget.woCode);

    super.initState();
  }

   final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  @override
  Widget build(BuildContext context) {

     final woDetailViewProvider =
        Provider.of<WoDetailViewProvider>(context, listen: true);
      print(woDetailViewProvider.secilenSure);

    final dataListSure = [
      "Lütfen Süre Seçiniz","15 dk","30 dk","45 dk","1 sa","2 sa","6 sa","Serbest Seçim"
        ];
  String dropdownvalueSureSeciniz = 'Lütfen Süre Seçiniz';


  String? selectedName;
    return Sizer ( builder: (context, Orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          
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

                         showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget
            context: context,
            builder: (BuildContext context) {
              // we set up a container inside which
              // we create center column and display text
 
              // Returning SizedBox instead of a Container
              return WoEforts(woCode: widget.woCode,);
            },
          );
          
                        },
                        child: Text('Yeni Efor Ekle'),
                                          ),
                      contentHorizontalPadding: 20,
                      contentBorderColor: Colors.black54,
                    ),
                    AccordionSection(
                      isOpen: false,
                      leftIcon:
                          const Icon(Icons.compare_rounded, color: Colors.white),
                      header: Text('Eforlar', style: _headerStyle),
                      headerBackgroundColor: APPColors.Login.blue,
                      headerBackgroundColorOpened: Colors.black,
                      contentBorderColor: Colors.black54,
                      content:  DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowHeight: 40,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                        label: Text('Kullanıcı', style: _contentStyleHeader),
                        numeric: false),
                    DataColumn(
                        label: Text('Süre', style: _contentStyleHeader)),
                    DataColumn(
                        label: Text('Sil', style: _contentStyleHeader),
                        numeric: true),
                  ],
                  rows: [
                    for(var i = 0; i< woDetailViewProvider.eforlarArray[1].length; i++)
                      


                        
                      DataRow(
                        cells: [
                          DataCell(Text(woDetailViewProvider.eforlarArray[1][i],
                              style: _contentStyle, textAlign: TextAlign.right)),
                          DataCell(Text( woDetailViewProvider.eforlarArray[2][i], style: _contentStyle)),
                          DataCell(TextButton(onPressed: (){}, child: Center(child: Text('X',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))))
                        ],
                      ),
                   
                  ],
                ),
                    ),
                  ],
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.food_bank, color: Colors.white),
                header: Text('Company Info', style: _headerStyle),
                content: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 1,
                  dataRowHeight: 40,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(
                        label: Text('ID', style: _contentStyleHeader),
                        numeric: true),
                    DataColumn(
                        label: Text('Description', style: _contentStyleHeader)),
                    DataColumn(
                        label: Text('Price', style: _contentStyleHeader),
                        numeric: true),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('1',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Fancy Product', style: _contentStyle)),
                        DataCell(Text(r'$ 199.99',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('2',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Another Product', style: _contentStyle)),
                        DataCell(Text(r'$ 79.00',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('3',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(Text('Really Cool Stuff', style: _contentStyle)),
                        DataCell(Text(r'$ 9.99',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('4',
                            style: _contentStyle, textAlign: TextAlign.right)),
                        DataCell(
                            Text('Last Product goes here', style: _contentStyle)),
                        DataCell(Text(r'$ 19.99',
                            style: _contentStyle, textAlign: TextAlign.right))
                      ],
                    ),
                  ],
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.contact_page, color: Colors.white),
                header: Text('Contact', style: _headerStyle),
                content: Wrap(
                  children: List.generate(
                      30,
                      (index) => const Icon(Icons.contact_page,
                          size: 30, color: Color(0xff999999))),
                ),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.computer, color: Colors.white),
                header: Text('Jobs', style: _headerStyle),
                content: const Icon(Icons.computer,
                    size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.movie, color: Colors.white),
                header: Text('Culture', style: _headerStyle),
                content:
                    const Icon(Icons.movie, size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.people, color: Colors.white),
                header: Text('Community', style: _headerStyle),
                content:
                    const Icon(Icons.people, size: 200, color: Color(0xff999999)),
              ),
              AccordionSection(
                isOpen: false,
                leftIcon: const Icon(Icons.map, color: Colors.white),
                header: Text('Map', style: _headerStyle),
                content:
                    const Icon(Icons.map, size: 200, color: Color(0xff999999)),
              ),
            ],
          ),
        ),
      );
    }
    );
  }
}
class Data {
  final String title;
  final String value;

  Data(this.title, this.value);
}