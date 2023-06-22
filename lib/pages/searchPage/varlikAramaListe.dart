import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:win_kamu/pages/searchPage/mahalAramaDetay.dart';
import 'package:win_kamu/pages/searchPage/varlikAramaDetay.dart';
import 'package:win_kamu/utils/page_titles.dart';
import 'package:win_kamu/widgets/appbar/custom_main_appbar.dart';

import '../../providers/search_view_provider.dart';
import '../../utils/global_utils.dart';
import '../../utils/themes.dart';
import '../issue/issueTracingList.dart';

class VarlikAramaListe extends StatefulWidget {
  const VarlikAramaListe({super.key});

  @override
  State<VarlikAramaListe> createState() => _VarlikAramaListeState();
}

class _VarlikAramaListeState extends State<VarlikAramaListe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewProvider>(context, listen: true);
    var data = searchProvider.varlikAraListeArray;
    print('data');
    print(data);

    List<String> codes = [];
    List<String> locTrees = [];
    List<String> names = [];
    List<String> statuses = [];

    for (var element in data) {
      codes.add(element['CODE']);
      locTrees.add(element['LOCTREE'] == null ? '' : element['LOCTREE']);
      names.add(element['NAME'] == null ? '' : element['NAME']);
      statuses.add(element['STATUS'] == null ? '' : element['STATUS']);
    }

    // loadData(sayfa) {

    //         List binaDatasi = searchProvider.mahalAraBinaArray;
    //         List <String> bina = searchProvider.mahalAraBinaArray[0];
    //         String dropdownvalueBina= binaDatasi[0].indexOf(searchProvider.mahalAraBinaValue) != -1 ? searchProvider.mahalAraBinaValue  : bina[0];
    //         var secilen_deger_bina = binaDatasi[1][binaDatasi[0].indexOf(dropdownvalueBina)];

    //         List <String>  kat = searchProvider.mahalAraKatArray[0];
    //         List katDatasi = searchProvider.mahalAraKatArray;
    //         String dropdownvalueKat= katDatasi[0].indexOf(searchProvider.mahalAraKatValue) != -1 ? searchProvider.mahalAraKatValue  : kat[0];
    //         var secilen_deger_kat = katDatasi[1][katDatasi[0].indexOf(dropdownvalueKat)];

    //         List <String>  kanat = searchProvider.mahalAraKanatArray[0];
    //         List kanatDatasi = searchProvider.mahalAraKanatArray;
    //         String dropdownvalueKanat= kanatDatasi[0].indexOf(searchProvider.mahalAraKanatValue) != -1 ? searchProvider.mahalAraKanatValue  : kanat[0];
    //         var secilen_deger_kanat = kanatDatasi[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];

    //         List <String>  sinif = searchProvider.mahalAraSinifArray[0];
    //         List sinifDatasi = searchProvider.mahalAraSinifArray;
    //         String dropdownvalueSinif= searchProvider.mahalAraSinifValue;
    //         var secilen_deger_sinif = sinifDatasi[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];

    //         List <String>  grup = searchProvider.mahalAraGrupArray[0];
    //         List grupDatasi = searchProvider.mahalAraGrupArray;
    //         String dropdownvalueGrup = searchProvider.mahalAraGrupValue;
    //         var secilen_deger_grup = grupDatasi[1][grupDatasi[0].indexOf(dropdownvalueGrup)];

    //                           var mahalKodu = searchProvider.mahalAramaMahalKodu.text;
    //                           var mahalAdi = searchProvider.mahalAramaMahalAdi.text;

    //                           var binaKodum =  searchProvider.mahalAraBinaArray[1][binaDatasi[0].indexOf(dropdownvalueBina)];
    //                           var binaKodu = binaKodum != 'Bina' ? binaKodum : '';

    //                           var katKodum =  searchProvider.mahalAraKatArray[1][katDatasi[0].indexOf(dropdownvalueKat)];
    //                           var katKodu = katKodum != 'Kat' ? katKodum : '';

    //                           var kanatKodum =  searchProvider.mahalAraKanatArray[1][kanatDatasi[0].indexOf(dropdownvalueKanat)];
    //                           var kanatKodu = kanatKodum != 'Kanat' ? kanatKodum : '';

    //                           var sinifKodum =  searchProvider.mahalAraSinifArray[1][sinifDatasi[0].indexOf(dropdownvalueSinif)];
    //                           var sinifKodu = sinifKodum != 'Sınıf' ? sinifKodum : '';

    //                           var grupKodum =  searchProvider.mahalAraGrupArray[1][grupDatasi[0].indexOf(dropdownvalueGrup)];
    //                           var grupKodu = grupKodum != 'Grup' ? grupKodum : '';

    //     searchProvider.mahalAramaListesi(context,mahalKodu,mahalAdi,binaKodu,katKodu,kanatKodu,sinifKodu,grupKodu,20,sayfa);

    // }

    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: const CustomMainAppbar(title: PageTitles.entitySearchResultTitle, returnBack: true),
            body: Container(
              color: Color.fromARGB(255, 224, 224, 224),
              child: Center(
                  child: codes.length > 0
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int i = 0; i < codes.length; i++)
                                  Center(
                                      child: GestureDetector(
                                    onTap: () async {
                                      // var summary_sonuc = await apirepository.mahalAramaVarlikDetaySummaryApi(codes[i]);
                                      // var sla_sonuc = await apirepository.mahalAramaVarlikDetaySlaApi(codes[i]);
                                      // var bakim_is_emri = await apirepository.mahalAraVarlikDetayBakimIsEmri(codes[i]);
                                      // var anlik_is_emri = await apirepository.mahalAraVarlikDetayAnlikIsEmri(codes[i]);

                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: VarlikAramaDetay(code: codes[i]),
                                        withNavBar: true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 90.w,
                                        height: 19.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                codes[i],
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                              ),
                                              Text(
                                                names[i],
                                                style: TextStyle(fontSize: 19),
                                              ),
                                              Text(''),
                                              Text(
                                                locTrees[i],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                                // data.length == 20 ?
                                //  Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,

                                //   children: [
                                //     Container( margin: EdgeInsets.all(4), child: ElevatedButton(onPressed: (){if(int.parse(searchProvider.sayfa) > 1){searchProvider.setSayfa = (int.parse(searchProvider.sayfa) - 1).toString(); loadData(int.parse(searchProvider.sayfa)); } }, child: Text('<'))),
                                //     Container( margin: EdgeInsets.all(4), child: ElevatedButton(onPressed: (){}, child: Text(searchProvider.sayfa))),
                                //     Container( margin: EdgeInsets.all(4), child: ElevatedButton(onPressed: (){searchProvider.setSayfa = (int.parse(searchProvider.sayfa) + 1).toString(); loadData(int.parse(searchProvider.sayfa)); }, child: Text('>'))),

                                //   ],
                                // )
                                // :
                                // Text('')
                              ],
                            ),
                          ),
                        )
                      : loadingBar(context, APPColors.Accent.grey, APPColors.Main.black)),
            ),
          ));
    });
  }
}
