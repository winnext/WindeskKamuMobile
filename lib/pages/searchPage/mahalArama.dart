import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/closedRequests/closedRequests.dart';
import 'package:win_kamu/pages/searchPage/mahalAramaListe.dart';
import 'package:win_kamu/providers/search_view_provider.dart';
import 'package:win_kamu/utils/global_utils.dart';

import '../../providers/login_provider.dart';
import '../../utils/themes.dart';

class mahalArama extends StatefulWidget {
  const mahalArama({super.key});


  @override
  State<mahalArama> createState() => _mahalAramaState();
}

class _mahalAramaState extends State<mahalArama> {
    final globalKey = new GlobalKey();
      cek() async{
           var load = true;
            final searchProvider = Provider.of<SearchViewProvider>(context,listen: false);

            await searchProvider.mahalAramaKampusFetchData();
             List <String> kampus = searchProvider.mahalAraKampusArray[0];
            List kampusDatasi = searchProvider.mahalAraKampusArray;   
            String dropdownvalueKampus = kampusDatasi[0].indexOf(searchProvider.mahalAraKampusValue) != -1 ? searchProvider.mahalAraKampusValue  : kampus[0];    
            var secilen_deger_kampus = kampusDatasi[1][kampusDatasi[0].indexOf(dropdownvalueKampus)];
            
            await searchProvider.mahalAramaBinaFetchData(secilen_deger_kampus);
             List binaDatasi = searchProvider.mahalAraBinaArray;
             List <String> bina = searchProvider.mahalAraBinaArray[0];
             String dropdownvalueBina= binaDatasi[0].indexOf(searchProvider.mahalAraBinaValue) != -1 ? searchProvider.mahalAraBinaValue  : bina[0];   
             var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBina)];


            await searchProvider.mahalAramaKatFetchData(secilen_deger_bina);
                List <String>  kat = searchProvider.mahalAraKatArray[0];
                List katDatasi = searchProvider.mahalAraKatArray;


                String dropdownvalueKat= katDatasi[0].indexOf(searchProvider.mahalAraKatValue) != -1 ? searchProvider.mahalAraKatValue  : kat[0];   

                var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKat)];


            await searchProvider.mahalAramaKanatFetchData(secilen_deger_kat);
            await searchProvider.mahalAramaSinifFetchData('');
            await searchProvider.mahalAramaGrupFetchData();
            load = false;
    }

  

   
  @override
  void initState() { 
    
    super.initState();
    print('İNİT STATE');
 

  cek();

    
  }
    


    
    

  

  @override
  Widget build(BuildContext context) {
      

        final searchProvider = Provider.of<SearchViewProvider>(context,listen: true);
    //searchProvider.mahalAramaKampusFetchData();
     TextEditingController vakaNoController = TextEditingController();
  var vakaNo  = 0;

  print('girdi build1');

    //print(_scrollController);
    ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       KAMPUS     ////////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////
    List <String> kampus = searchProvider.mahalAraKampusArray[0];
    //print(searchProvider.mahalAraKampusArray);
    List kampusDatasi = searchProvider.mahalAraKampusArray;
  

            String dropdownvalueKampus = kampusDatasi[0].indexOf(searchProvider.mahalAraKampusValue) != -1 ? searchProvider.mahalAraKampusValue  : kampus[0];    

    var secilen_deger_kampus = kampusDatasi[1][kampusDatasi[0].indexOf(dropdownvalueKampus)];

    print(kampus);
    print(dropdownvalueKampus);

    print('-----------------');


    //searchProvider.mahalAramaBinaFetchData(secilen_deger_kampus);
    //print(searchProvider.mahalAraBinaArray);


      ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       BINA       ////////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////
    List binaDatasi = searchProvider.mahalAraBinaArray;
    List <String> bina = searchProvider.mahalAraBinaArray[0];


    String dropdownvalueBina= binaDatasi[0].indexOf(searchProvider.mahalAraBinaValue) != -1 ? searchProvider.mahalAraBinaValue  : bina[0];   
    var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBina)];
    print(bina);
    print(dropdownvalueBina);
      print('-----------------');

    //print(searchProvider.mahalAraKatArray[0]);

      ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       KAT        ////////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////

     List <String>  kat = searchProvider.mahalAraKatArray[0];
    List katDatasi = searchProvider.mahalAraKatArray;

    String dropdownvalueKat= katDatasi[0].indexOf(searchProvider.mahalAraKatValue) != -1 ? searchProvider.mahalAraKatValue  : kat[0];   

        var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKat)];
  print(kat);
  print(dropdownvalueKat);
    print('-----------------');

    ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       KANAT      /////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////




    List <String>  kanat = searchProvider.mahalAraKanatArray[0];
    List kanatDatasi = searchProvider.mahalAraKanatArray;


    String dropdownvalueKanat= kanatDatasi[0].indexOf(searchProvider.mahalAraKanatValue) != -1 ? searchProvider.mahalAraKanatValue  : kanat[0];   
    var secilen_deger_kanat = kanatDatasi[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];

     print(kanat);
  print(dropdownvalueKanat);
    print('-----------------');

      ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       SINIF     ////////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////

     //searchProvider.mahalAramaSinifFetchData(secilen_deger_kanat);
       List <String>  sinif = searchProvider.mahalAraSinifArray[0];
          print(sinif);

    List sinifDatasi = searchProvider.mahalAraSinifArray;


    String dropdownvalueSinif= searchProvider.mahalAraSinifValue;   
    var secilen_deger_sinif = sinifDatasi[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];

  print(dropdownvalueSinif);
    print('-----------------');



     ///////////////////////////////////////////////////////
    //////////////////////////////        ///////////////////////
    ///////////////////////       GRUP     ////////////////////////
    //////////////////////////           ///////////////////////
    //////////////////////////////////////////////////////////

     //searchProvider.mahalAramaSinifFetchData(secilen_deger_kanat);
       List <String>  grup = searchProvider.mahalAraGrupArray[0];
print(grup);
    List grupDatasi = searchProvider.mahalAraGrupArray;


    String dropdownvalueGrup = searchProvider.mahalAraGrupValue;   
    var secilen_deger_grup = grupDatasi[1][grupDatasi[0].indexOf(dropdownvalueGrup)];

  print(dropdownvalueGrup);
    print('-----------------');


    return Sizer(      builder: (context, orientation, deviceType) {
    
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child:  Scaffold(
        resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Mahal Arama',style: TextStyle(color: Colors.black),),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);

                },
                icon: Icon(Icons.arrow_back, color: APPColors.Main.black)),
            
            actions: [],
          ),
          body: 
          Center(
            child: grup.length > 0 && kampus.length > 0 && bina.length > 0 && kat.length > 0 && kanat.length > 0 && sinif.length > 0 && grup.length > 0 ? SingleChildScrollView(
              child: Container(
              width: 85.w,
              
             
              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
  alignment: Alignment.centerRight,
  children: <Widget>[
   TextField(
                      controller: searchProvider.mahalAramaMahalKodu,
                                decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Mahal Kodu',
                                ),
                                  onChanged: (inputValue){
                    //print(searchProvider.varliKodu.text);
                            if(searchProvider.varliKodu.text == ''){
                              vakaNo = 0;
                            
                              searchProvider.setVakaButonVisible = false;
                              
                            } else{
                              vakaNo =  1;
                          searchProvider.setVakaButonVisible = true;
                             
                              }
                          },
                                 
                               
                              ),
    IconButton(
      icon: Icon(Icons.qr_code_scanner),
      onPressed: () {
        searchProvider.scanBarcodeNormal('setMahalAramaMahalKodu');
        FocusScope.of(context).requestFocus(FocusNode());
        // Your codes...
      },
    ),
  ],
),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                    controller: searchProvider.mahalAramaMahalAdi,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
                labelText: 'Mahal Adı',
              ),
                onChanged: (inputValue){
                  //print(searchProvider.vakaNo.text);
          if(searchProvider.vakaNo.text == ''){
            vakaNo = 0;
          
            searchProvider.setVakaButonVisible = false;
            
          } else{
            vakaNo =  1;
                        searchProvider.setVakaButonVisible = true;
           
            }
        },
               
             
            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKampus,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kampüs',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kampus.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueKampus = newValue!;
                });
                searchProvider.setmahalAraKampusValue = newValue!;
                cek();
              },
            ),
                  ),
                  
                 dropdownvalueKampus != 'Kampüs' ? 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueBina,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Bina',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: bina.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueBina = newValue!;
                });
                  searchProvider.setmahalAraBinaValue = newValue!;

                cek();
              },
            ),
                  ) : Container(),
                  dropdownvalueBina != 'Bina' ? 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKat,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kat',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kat.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  print('newWaluekat : '+newValue!);
                  dropdownvalueKat = newValue!;
                  searchProvider.setMahalAraKatValue = newValue!;

                });
                cek();
              },
            ),
                  ) : 
                  Container(),
                  dropdownvalueKat != 'Kat' ? 

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueKanat,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Kanat',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: kanat.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueKanat = newValue!;
                });
                searchProvider.setMahalAraKanatValue = newValue!;
                cek();
              },
            ),
                  ) : Container(),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueSinif,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Sınıf',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: sinif.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueSinif = newValue!;
                });
                searchProvider.setMahalAraSinifValue = newValue!;
              },
            ),
                  ),

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                     DropdownButtonFormField(
                          isExpanded: true,

              // Initial Value
              value: dropdownvalueGrup,
              decoration: InputDecoration(
                                  
                                  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                                  labelText: 'Grup',
                                ),
              
              
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: grup.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalueGrup = newValue!;
                });
                searchProvider.setMahalAraGrupValue = newValue!;
              },
            ),
                  ),
                  
                 
            searchProvider.mahalAramaMahalKodu.text != '' || searchProvider.mahalAramaMahalAdi.text != '' || dropdownvalueKampus != 'Kampüs' || dropdownvalueBina != 'Bina' || dropdownvalueKat != 'Kat' || dropdownvalueKanat != 'Kanat' || dropdownvalueSinif != 'Sınıf' || dropdownvalueGrup != 'Grup' ?
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                          width: 45.w,
                          height: 8.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Main.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {

                             searchProvider.setmahalAraKampusValue = 'Kampüs';
                             searchProvider.setmahalAraBinaValue = 'Bina';
                             searchProvider.setMahalAraKatValue = 'Kat';
                             searchProvider.setMahalAraKanatValue = 'Kanat';
                             searchProvider.setMahalAraSinifValue = 'Sınıf';
                             searchProvider.setMahalAraGrupValue = 'Grup';
                             searchProvider.setMahalAramaMahalAdi = '';
                             searchProvider.setMahalAramaMahalKodu = '';



                              
                            },
                            child: const Text('Temizle'),
                          ),
                        ),
            )
            
             : Text(''),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                          width: 45.w,
                          height: 8.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: APPColors.Login.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                            ),
                            onPressed: () {

           
            
            List binaDatasi = searchProvider.mahalAraBinaArray;
            List <String> bina = searchProvider.mahalAraBinaArray[0];
            String dropdownvalueBina= binaDatasi[0].indexOf(searchProvider.mahalAraBinaValue) != -1 ? searchProvider.mahalAraBinaValue  : bina[0];   
            var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBina)];

            List <String>  kat = searchProvider.mahalAraKatArray[0];
            List katDatasi = searchProvider.mahalAraKatArray;
            String dropdownvalueKat= katDatasi[0].indexOf(searchProvider.mahalAraKatValue) != -1 ? searchProvider.mahalAraKatValue  : kat[0]; 
            var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKat)];


            List <String>  kanat = searchProvider.mahalAraKanatArray[0];
            List kanatDatasi = searchProvider.mahalAraKanatArray;
            String dropdownvalueKanat= kanatDatasi[0].indexOf(searchProvider.mahalAraKanatValue) != -1 ? searchProvider.mahalAraKanatValue  : kanat[0];   
            var secilen_deger_kanat = kanatDatasi[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];


            List <String>  sinif = searchProvider.mahalAraSinifArray[0];
            List sinifDatasi = searchProvider.mahalAraSinifArray;
            String dropdownvalueSinif= searchProvider.mahalAraSinifValue;   
            var secilen_deger_sinif = sinifDatasi[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];

            List <String>  grup = searchProvider.mahalAraGrupArray[0];
            List grupDatasi = searchProvider.mahalAraGrupArray;
            String dropdownvalueGrup = searchProvider.mahalAraGrupValue;   
            var secilen_deger_grup = grupDatasi[1][grupDatasi[0].indexOf(dropdownvalueGrup)];



                              var mahalKodu = searchProvider.mahalAramaMahalKodu.text;
                              var mahalAdi = searchProvider.mahalAramaMahalAdi.text;

                              var binaKodum =  searchProvider.mahalAraBinaArray[1][binaDatasi[0].indexOf(dropdownvalueBina)];
                              var binaKodu = binaKodum != 'Bina' ? binaKodum : '';

                              var katKodum =  searchProvider.mahalAraKatArray[1][katDatasi[0].indexOf(dropdownvalueKat)];
                              var katKodu = katKodum != 'Kat' ? katKodum : '';

                              var kanatKodum =  searchProvider.mahalAraKanatArray[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];
                              var kanatKodu = kanatKodum != 'Kanat' ? kanatKodum : '';

                              var sinifKodum =  searchProvider.mahalAraSinifArray[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];
                              var sinifKodu = sinifKodum != 'Sınıf' ? sinifKodum : '';

                              var grupKodum =  searchProvider.mahalAraGrupArray[1][grupDatasi[0].indexOf(dropdownvalueGrup)];
                              var grupKodu = grupKodum != 'Grup' ? grupKodum : '';

                              // var kat = dropdownvalueKat != 'Kat' ? dropdownvalueKat : '';
                              // var kanat = dropdownvalueKanat != 'Kanat' ? dropdownvalueKanat : '';
                              // var sinif = dropdownvalueSinif != 'Sınıf' ? dropdownvalueSinif : '';
                              //var grup = dropdownvalueGrup != 'Grup' ? dropdownvalueGrup : '';
                                if(
                                  searchProvider.mahalAramaMahalKodu.text == '' && 
                                  searchProvider.mahalAramaMahalAdi.text == '' &&
                                  dropdownvalueKampus == 'Kampüs' &&
                                  dropdownvalueBina == 'Bina' &&
                                  dropdownvalueKat == 'Kat' && 
                                  dropdownvalueKanat == 'Kanat'
                                  ){
                                    snackBar(context, 'Arama yaparken en az bir kriter seçilmelidir', 'info');
                                  }else{
                                    searchProvider.setSayfa = '1';
                                    searchProvider.mahalAramaListesi(context,mahalKodu,mahalAdi,binaKodu,katKodu,kanatKodu,sinifKodu,grupKodu,20,1);
                                      print('Mahal Arama Sayfası Detayı');
                                         PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MahalAramaListe(
          
          
        ),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
        
    );
                                  }

                              
                            },
                            child: const Text('Ara'),
                          ),
                        ),
            ),
            
                ],
              ),
            ),
            )
            :
            loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)
          )
          
          ),
    );
  }
    );
  }
}