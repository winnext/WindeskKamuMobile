import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/detail_view_provider.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/search_view_provider.dart';
import '../../utils/themes.dart';
import '../issue/issueSummary.dart';

class VarlikAramaDetay extends StatefulWidget {
  final String code;
  
  final Map summary;
  final List sla;
  final List bakim_is_emri;
  final List anlik_is_emri;

  
  const VarlikAramaDetay({super.key,required this.code, required this.summary, required this.sla, required this.bakim_is_emri, required this.anlik_is_emri});

  @override
  State<VarlikAramaDetay> createState() => _VarlikAramaDetayState();
}

class _VarlikAramaDetayState extends State<VarlikAramaDetay> {



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
            title: Text('Varlık Detayı',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            
            actions: [],
          ),
          body: Container(
            color: Color.fromARGB(255, 224, 224, 224),
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
                                            color: Color.fromARGB(255, 79, 93, 107),
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
                                  border: Border.all(color: Colors.white)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['CODE'],  maxLines: 6,
                                              overflow:TextOverflow.clip,style: TextStyle(color: Colors.white,)
                                          ),
                                          )
                                        ],
                                      ),
                                      Row(
                                                      
                                        children: [
                                          Text('Adı : ',style: TextStyle(color: Colors.white,)),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['CMDB_NAME'],style: TextStyle(color: Colors.white,))
                                            )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Statü : ',style: TextStyle(color: Colors.white,)),
                                          Text(widget.summary['STATUS'] == null ? 'Veri Yok' : widget.summary['STATUS'],style: TextStyle(color: Colors.white,)  )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Kategori : ',style: TextStyle(color: Colors.white,)),
                                          Container(
                                            width: 50.w,
                                            child: Text(widget.summary['CATEGORY'] == null ? 'Veri Yok' : widget.summary['CATEGORY'],style: TextStyle(color: Colors.white,))
                                            )
                                        ],
                                      ),
                             
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30.h,
                              child: Accordion(
          maxOpenSections: 2,
          headerBackgroundColorOpened: Colors.black,
          headerBackgroundColor: Colors.black54,
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
        print(widget.sla[i]['BM_CODE']);
         detailViewProvider.setIssueCode = '';
        detailViewProvider.setIssueCode = widget.sla[i]['BM_CODE'];
Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const IssueSummary(),
                                              ),
                                            );
                         
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 79, 93, 107),
                ),
                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.sla[i]['BM_CODE']+' - '+widget.sla[i]['BM_STATUSNAME']),
                    Text(widget.sla[i]['TARGET_FDATE']),
                  ],
                ),
                )
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
                    SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
       

        children: <Widget>[
          
          for (int i = 0; i < widget.bakim_is_emri.length; i++)

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
                  print('Routing wo detail page');
               
                  ///////////////////////////////////
                  ///  İŞ EMRİ SAYFASINA GİDECEK ///
                  //////////////////////////////////
                  ///
  
                         
                },
                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.bakim_is_emri[i]['WO_CODE']+' - '+widget.bakim_is_emri[i]['WO_STATUS']),
                    Text(widget.bakim_is_emri[i]['WO_NAME']),
                    Text('Planlanan Bitiş Tarihi : '+widget.bakim_is_emri[i]['PLANNED_ENDDATE']),
                  ],
                ),
                )
              )
                     ),
           ),
           widget.bakim_is_emri.length > 0 ? 
           Text('') : Text(' Sonuç Bulunamadı ')
        
        
        ],
      ),
    )
                  
            ),
            AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.flag, color: Colors.white),
              header: Text('Anlık İş Emri', style: _headerStyle),
              content:
                 SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
       

        children: <Widget>[
          
          for (int i = 0; i < widget.anlik_is_emri.length; i++)

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
                  print('Routing anlik is emri detail page');
               
    // final detailViewProvider =
    //     Provider.of<DetailViewProvider>(context, listen: false);

    //     detailViewProvider.setIssueCode = widget.anlik_is_emri[i]['BM_CODE'];
                         
                },
                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.anlik_is_emri[i]['WO_CODE']+' - '+widget.anlik_is_emri[i]['WO_STATUS']),
                    Text(widget.anlik_is_emri[i]['WO_NAME']),
                  ],
                ),
                )
              )
                     ),
           ),
           widget.anlik_is_emri.length > 0 ? 
           Text('') : Text(' Sonuç Bulunamadı ')
        
        
        ],
      ),
    )
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
                                            color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.code+'-'+widget.summary['STATUS'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                            Text(''),
                            Text(widget.summary['CMDB_NAME'],style: TextStyle(color: Colors.black,fontSize: 15),),
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