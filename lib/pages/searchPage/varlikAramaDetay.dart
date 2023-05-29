import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/detail_view_provider.dart';
import '../../providers/main_page_view_provider.dart';
import '../../providers/search_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
import '../WorkOrder/woTracingList.dart';
import '../issue/issueSummary.dart';

class VarlikAramaDetay extends StatefulWidget {
  final String code;
  


  
  const VarlikAramaDetay({super.key,required this.code, });

  @override
  State<VarlikAramaDetay> createState() => _VarlikAramaDetayState();
}

class _VarlikAramaDetayState extends State<VarlikAramaDetay> {
  Map summary = {};
  List sla = [];
  List bakim_is_emri = [];
  List anlik_is_emri = [];
  cek() async{
       Map summary_Data = await apirepository.mahalAramaVarlikDetaySummaryApi(widget.code);
       List sla_Data = await apirepository.mahalAramaVarlikDetaySlaApi(widget.code);
       List bakim_is_emri_Data = await apirepository.mahalAraVarlikDetayBakimIsEmri(widget.code);
       List anlik_is_emri_Data = await apirepository.mahalAraVarlikDetayAnlikIsEmri(widget.code);

       setState(() {
         summary = summary_Data;
         sla = sla_Data;
         bakim_is_emri = bakim_is_emri_Data;
         anlik_is_emri = anlik_is_emri_Data;

       });
  }

  @override
  void initState() {
    // TODO: implement initState
    cek();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    print(summary);
    print(summary);
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
          body: summary.length > 0 ? 
          Container(
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
                                            child: Text(summary['CODE'],  maxLines: 6,
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
                                            child: Text(summary['CMDB_NAME'],style: TextStyle(color: Colors.white,))
                                            )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Statü : ',style: TextStyle(color: Colors.white,)),
                                          Text(summary['STATUS'] == null ? 'Veri Yok' : summary['STATUS'],style: TextStyle(color: Colors.white,)  )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Kategori : ',style: TextStyle(color: Colors.white,)),
                                          Container(
                                            width: 50.w,
                                            child: Text(summary['CATEGORY'] == null ? 'Veri Yok' : summary['CATEGORY'],style: TextStyle(color: Colors.white,))
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
          
          for (int i = 0; i < sla.length; i++)

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
        print(sla[i]['BM_CODE']);
         detailViewProvider.setIssueCode = '';
        detailViewProvider.setIssueCode = sla[i]['BM_CODE'];
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
                    Text(sla[i]['BM_CODE']+' - '+sla[i]['BM_STATUSNAME']),
                    Text(sla[i]['TARGET_FDATE']),
                  ],
                ),
                )
              )
                     ),
           ),
           sla.length > 0 ? 
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
          
          for (int i = 0; i < bakim_is_emri.length; i++)

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
                    Text(bakim_is_emri[i]['WO_CODE']+' - '+bakim_is_emri[i]['WO_STATUS']),
                    Text(bakim_is_emri[i]['WO_NAME']),
                    Text('Planlanan Bitiş Tarihi : '+bakim_is_emri[i]['PLANNED_ENDDATE']),
                  ],
                ),
                )
              )
                     ),
           ),
           bakim_is_emri.length > 0 ? 
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
          
          for (int i = 0; i < anlik_is_emri.length; i++)

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
                    Text(anlik_is_emri[i]['WO_CODE']+' - '+anlik_is_emri[i]['WO_STATUS']),
                    Text(anlik_is_emri[i]['WO_NAME']),
                  ],
                ),
                )
              )
                     ),
           ),
           anlik_is_emri.length > 0 ? 
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
                            Text(widget.code+'-'+summary['STATUS'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                            Text(''),
                            Text(summary['CMDB_NAME'],style: TextStyle(color: Colors.black,fontSize: 15),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ) : 
          loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)

      )
    );
  }
  );
  }
}