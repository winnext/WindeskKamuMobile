// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:win_kamu/models/http_response.model.dart';
import 'package:win_kamu/models/user.model.dart';
import 'package:win_kamu/widgets/dialogWidgets/customAlertDialog.dart';
import 'package:intl/intl.dart';

import '../api/api_repository.dart';
import '../l10n/locale_keys.g.dart';
import '../models/list_view.model.dart';
import '../utils/api_urls.dart';
import '../widgets/dialogWidgets/customDialogOnlyConfirm.dart';

class CrudViewProvider extends ChangeNotifier {
  final apirepository = APIRepository();

  GlobalKey<FormState> _crudFormKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _descriptionDateController = TextEditingController();
  TextEditingController _descriptionReadedController = TextEditingController();

  int? _formId;
  bool _iskurumTuruEmpty = false;
  bool _isUpdateActivated = false;

  bool get iskurumTuruEmpty => _iskurumTuruEmpty;
  bool get isUpdateActivated => _isUpdateActivated;
  int? get formId => _formId;

  TextEditingController get descriptionController => _descriptionController;

  GlobalKey<FormState> get crudFormKey => _crudFormKey;

  PageController? _pageController;
  PageController? get pageController => _pageController;

  set setFormId(int formId) {
    _formId = formId;
    notifyListeners();
  }

  set setIsUpdateActivated(bool isUpdateActivated) {
    _isUpdateActivated = isUpdateActivated;
    notifyListeners();
  }

  set setpageController(PageController pageController) {
    _pageController = pageController;
    notifyListeners();
  }

  set setIsKurumTuruEmpty(bool kurumTuru) {
    _iskurumTuruEmpty = kurumTuru;
    notifyListeners();
  }

  set setdescriptionController(String descriptionController) {
    _descriptionController.text = descriptionController;
    notifyListeners();
  }

  TextEditingController get descriptionDateController =>
      _descriptionDateController;

  set setdescriptionDateController(String descriptionDateController) {
    _descriptionDateController.text = descriptionDateController;
    notifyListeners();
  }

  TextEditingController get descriptionReadedController =>
      _descriptionReadedController;

  set setdescriptionReadedController(String descriptionReadedController) {
    _descriptionReadedController.text = descriptionReadedController;
    notifyListeners();
  }

  clearForm() {
    if (_descriptionController.text.isNotEmpty ||
        _descriptionDateController.text.isNotEmpty ||
        _descriptionReadedController.text.isNotEmpty) {
      _descriptionController.clear();
      _descriptionDateController.clear();
      _descriptionReadedController.clear();
      if (_descriptionReadedController.text.isEmpty) {
        _iskurumTuruEmpty = false;
      }
      _isUpdateActivated = false;
      _formId = 0;
      notifyListeners();
    }
  }

  addOrUpdateForm(BuildContext context) {
    if (!isUpdateActivated) {
      addForm(context);
    } else {
      _iskurumTuruEmpty = false;
      setIsKurumTuruEmpty = false;
      updateForm(context);
      notifyListeners();
    }
  }

  initForm([ListViewModel? listViewModel]) {
    if (listViewModel != null) {
      print(listViewModel);
    }
    _iskurumTuruEmpty = false;
  }

  void fillForm(BuildContext context, ListViewModel listElements,
      PageController pageController) {
    _formId = listElements.id;
    _isUpdateActivated = true;
    _pageController = pageController;
    _pageController!.jumpToPage(2);
    _descriptionController.text = listElements.description!;
    DateTime dateTime = DateTime.parse(listElements.notificationDate!);
    String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
    _descriptionDateController.text = formattedDate;
    _descriptionReadedController.text = listElements.isRead == true
        ? LocaleKeys.evet.tr()
        : LocaleKeys.hayir.tr();
  }

  void addForm(BuildContext context) async {
    if (_crudFormKey.currentState!.validate() && !iskurumTuruEmpty) {
      DateTime date = DateFormat("dd/MM/yyyy - HH:mm")
          .parse(_descriptionDateController.text);
      var utc = date.toIso8601String();

      Map<String, dynamic> queryParameters = {
        "id": 0,
        "customerId": 1,
        "description": _descriptionController.text,
        "notificationType": 1,
        "referenceId": "23123",
        "notificationDate": utc,
        "isRead": _descriptionReadedController.text == LocaleKeys.evet.tr()
            ? true
            : false,
        "isDelete": false
      };

      httpSonucModel apiResponse = await apirepository.post(
          controller: addNotification, data: queryParameters);
      if (apiResponse.success == true) {
        clearForm();
        CustomAlertDialogOnlyConfirm(
          context,
          () {
            Navigator.pop(context);
          },
          LocaleKeys.basarili.tr(),
          LocaleKeys.kayitBasariIleEklendi.tr(),
          ArtSweetAlertType.success,
          LocaleKeys.tamam.tr(),
        );
      } else {
        CustomAlertDialogOnlyConfirm(context, () {
          Navigator.pop(context);
        },
            LocaleKeys.uyari.tr(),
            LocaleKeys.kayitSirasindaHataOlustu.tr() +
                " " +
                LocaleKeys.hataMesaji.tr() +
                "${apiResponse.message}.",
            ArtSweetAlertType.warning,
            LocaleKeys.tamam.tr());
      }
    } else {
      if (_descriptionReadedController.text.isEmpty) {
        _iskurumTuruEmpty = true;
      }

      notifyListeners();
    }
  }

  void updateForm(BuildContext context) async {
    if (_crudFormKey.currentState!.validate() && !iskurumTuruEmpty) {
      DateTime date;
      if (_descriptionDateController.text.contains('-')) {
        date = DateFormat("dd/MM/yyyy - HH:mm")
            .parse(_descriptionDateController.text);
      } else {
        date = DateFormat("dd/MM/yyyy").parse(_descriptionDateController.text);
      }

      var utc = date.toIso8601String();

      Map<String, dynamic> queryParameters = {
        "id": _formId,
        "customerId": 1,
        "description": _descriptionController.text,
        "notificationType": 1,
        "referenceId": "23123",
        "notificationDate": utc,
        "isRead": _descriptionReadedController.text == LocaleKeys.evet.tr()
            ? true
            : false,
        "isDelete": false
      };
      print(queryParameters);

      httpSonucModel apiResponse = await apirepository.post(
          controller: updateNotication, data: queryParameters);
      if (apiResponse.success == true) {
        clearForm();
        CustomAlertDialogOnlyConfirm(
          context,
          () {
            Navigator.pop(context);
          },
          LocaleKeys.basarili.tr(),
          LocaleKeys.kayitBasariIleEklendi.tr(),
          ArtSweetAlertType.success,
          LocaleKeys.tamam.tr(),
        );
      } else {
        CustomAlertDialogOnlyConfirm(context, () {
          Navigator.pop(context);
        },
            LocaleKeys.uyari.tr(),
            LocaleKeys.kayitSirasindaHataOlustu.tr() +
                LocaleKeys.hataMesaji.tr() +
                apiResponse.message.toString(),
            ArtSweetAlertType.warning,
            LocaleKeys.tamam.tr());
      }
    } else {
      if (_descriptionReadedController.text.isEmpty) {
        _iskurumTuruEmpty = true;
      }

      notifyListeners();
    }
  }
}
