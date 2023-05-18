import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/detail_view_provider.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/search_view_provider.dart';
import '../../utils/themes.dart';

class MahalAramaDetay extends StatefulWidget {
  final String code;
  final String name;
  final String locTree;
  final Map summary;
  final List sla;
  final List bakim_is_emri;

  
  const MahalAramaDetay({super.key,required this.code, required this.name, required this.locTree, required this.summary, required this.sla, required this.bakim_is_emri});

  @override
  State<MahalAramaDetay> createState() => _MahalAramaDetayState();
}

class _MahalAramaDetayState extends State<MahalAramaDetay> {



  @override
  Widget build(BuildContext context) {
    print(widget.summary);
      final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  
    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Mahal Detayı',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            
            actions: [],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                                            color: APPColors.Filter.blue,
                                              borderRadius: BorderRadius.circular(15),
                                            ),                  
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              height: 35.h,
                              child: Container(
                                
                                 decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Mimari Adı : '),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['LOCTREE'],  maxLines: 6,
                                              overflow:TextOverflow.clip,
                                          ),
                                          )
                                        ],
                                      ),
                                      Row(
                                                      
                                        children: [
                                          Text('Sınıf : '),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['CLASS'])
                                            )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('EK18 Mahal Grubu : '),
                                          Text(widget.summary['EK18GROUP'] == null ? 'Veri Yok' : widget.summary['EK18GROUP']  )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Alan : '),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['AREA'] == null ? 'Veri Yok' : widget.summary['AREA'])
                                            )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Ana Grup : '),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['TYPE'] == null ? 'Veri Yok' : widget.summary['TYPE'])
                                            )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Grup : '),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['TYPE2'] == null ? 'Veri Yok' : widget.summary['TYPE2'])
                                            )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30.h,
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
              leftIcon: const Icon(Icons.apps, color: Colors.white),
              header: Text('SLA', style: _headerStyle),
              content:
                                   SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
       

        children: <Widget>[
          
          for (int i = 0; i < widget.sla.length; i++)

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
              height: 10.h,
              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
              alignment: Alignment.center,
              
              child: Center(
                child: ElevatedButton(onPressed: (){
                  print('Routing issue detail page');
               
    final detailViewProvider =
        Provider.of<DetailViewProvider>(context, listen: false);

        detailViewProvider.setIssueCode = widget.sla[i]['BM_CODE'];
                         
                },
                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.sla[i]['BM_CODE']+' - '+widget.sla[i]['BM_STATUSNAME']),
                    Text(widget.sla[i]['TARGET_FDATE']),
                  ],
                ),)
              )
                     ),
           ),
           widget.sla.length > 0 ? 
           Text('') : Text(' Sonuç Bulunamadı ')
        
        
        ],
      ),
    )

            ),
            AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.people, color: Colors.white),
              header: Text('Bakım İş Emri', style: _headerStyle),
              content:
                  const Icon(Icons.people, size: 200, color: Color(0xff999999)),
            ),
            AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.flag, color: Colors.white),
              header: Text('Anlık İş Emri', style: _headerStyle),
              content:
                  const Icon(Icons.map, size: 200, color: Color(0xff999999)),
            ),
          ],
        ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 14.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                                            color: APPColors.Filter.blue,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.code+'-'+widget.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                            Text(''),
                            Text(widget.locTree,style: TextStyle(color: Colors.black,fontSize: 15),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
      )
    );
  }
  );
  }
}