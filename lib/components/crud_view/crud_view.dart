// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/providers/crud_view_provider.dart';
import 'package:win_kamu/utils/global_utils.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:win_kamu/widgets/buttonWidgets/customIconButton.dart';
import 'package:win_kamu/widgets/commons.dart';
import 'package:win_kamu/widgets/textfieldsWidgets/customTextFormField.dart';
import 'package:provider/provider.dart';

import '../../../l10n/locale_keys.g.dart';
import '../../../models/list_view.model.dart';
import '../../../widgets/customDropdown.dart';

class CrudView extends StatefulWidget {
  const CrudView(
      {super.key, required this.listElements, required this.pageController});

  final ListViewModel listElements;
  final PageController pageController;

  @override
  State<CrudView> createState() => _CrudViewState();
}

class _CrudViewState extends State<CrudView> {
  @override
  void initState() {
    final crudP = Provider.of<CrudViewProvider>(context, listen: false);

    if (widget.listElements.id != 0) {
      crudP.initForm(widget.listElements);
    } else {
      crudP.initForm();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final crudProvider = Provider.of<CrudViewProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(LocaleKeys.ornekKayitEkleme.tr() +
              "/" +
              LocaleKeys.ornekKayitGuncelleme.tr()),
          backgroundColor: APPColors.Main.blue,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: crudProvider.crudFormKey,
            child: Column(
              children: [
                pageCard(
                    context,
                    "${LocaleKeys.ornekKayitPrefix.tr()} ${crudProvider.isUpdateActivated ? LocaleKeys.ornekKayitGuncelleme.tr() : LocaleKeys.ornekKayitEkleme.tr()}",
                    logoHeader()),
                Padding(
                  padding: const EdgeInsets.all(height_14),
                  child: Column(
                    children: [
                      CustomTextFormField(
                          // ignore: sort_child_properties_last
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: mainWhiteColor,
                                  borderRadius:
                                      BorderRadius.circular(radius_size_10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: container_box_shadow,
                                        blurRadius: radius_size_10,
                                        offset: Offset(
                                            radius_size_0, radius_size_10))
                                  ]),
                              child: CustomTextFormFieldContent(
                                  icon: Icons.text_format,
                                  iconColor: APPColors.Secondary.blue,
                                  validator: formBos,
                                  controller:
                                      crudProvider.descriptionController,
                                  name: LocaleKeys.bildirimIsmi.tr()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainWhiteColor,
                                  borderRadius:
                                      BorderRadius.circular(radius_size_10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: container_box_shadow,
                                        blurRadius: radius_size_10,
                                        offset: Offset(
                                            radius_size_0, radius_size_10))
                                  ]),
                              child: CustomTextFormFieldContent(
                                  icon: Icons.date_range,
                                  isSuffix: false,
                                  isDate: true,
                                  validator: formBos,
                                  isTime: true,
                                  controller:
                                      crudProvider.descriptionDateController,
                                  name: LocaleKeys.bildirimTarihi.tr()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: mainWhiteColor,
                                  borderRadius:
                                      BorderRadius.circular(radius_size_10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: container_box_shadow,
                                        blurRadius: radius_size_10,
                                        offset: Offset(
                                            radius_size_0, radius_size_10))
                                  ]),
                              child: Column(
                                children: [
                                  CustomDropdown(
                                    onChanged: (val) {
                                      crudProvider
                                              .setdescriptionReadedController =
                                          val!;
                                      if (crudProvider
                                          .descriptionReadedController
                                          .text
                                          .isNotEmpty) {
                                        crudProvider.setIsKurumTuruEmpty =
                                            false;
                                      } else {
                                        crudProvider.setIsKurumTuruEmpty = true;
                                      }
                                    },
                                    disableClear: true,
                                    icons: Icons.notification_add,
                                    listHeight: 2,
                                    controller: crudProvider
                                        .descriptionReadedController,
                                    header: LocaleKeys.bildirimDurumu.tr(),
                                    items: [
                                      LocaleKeys.evet.tr(),
                                      LocaleKeys.hayir.tr()
                                    ],
                                  ),
                                  crudProvider.iskurumTuruEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      19,
                                                  bottom: 10),
                                              child: Text(
                                                LocaleKeys.buAlanBosOlamaz.tr(),
                                                style: TextStyle(
                                                    color: APPColors.Main.red,
                                                    fontSize: height_12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                          sectionName: ""),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      colors: APPColors.Secondary.red,
                      height: height_18,
                      width: height_3,
                      name: LocaleKeys.temizle.tr(),
                      icons: Icon(
                        Icons.delete,
                        color: APPColors.Main.white,
                      ),
                      onTap: () => crudProvider.clearForm(),
                    ),
                    CustomIconButton(
                      colors: crudProvider.isUpdateActivated
                          ? APPColors.Secondary.orange
                          : APPColors.Main.blue,
                      height: height_18,
                      width: height_3,
                      name: crudProvider.isUpdateActivated
                          ? LocaleKeys.ornekKayitGuncelleme.tr()
                          : LocaleKeys.kaydet.tr(),
                      icons: Icon(
                        Icons.add,
                        color: crudProvider.isUpdateActivated
                            ? APPColors.Secondary.white
                            : APPColors.Main.white,
                      ),
                      onTap: () => crudProvider.addOrUpdateForm(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
