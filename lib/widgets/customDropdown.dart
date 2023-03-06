import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../utils/themes.dart';

class CustomDropdown extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget Function(BuildContext, String?)? dropdownBuilder;
  final List<String?>? items;
  final int listHeight;
  bool? isDisable;
  final String selectedItem;
  final IconData icons;
  final bool disable;
  final bool disableClear;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final String header;
  final String? Function(String?)? validator;
  final Future<List<String?>> Function(String?)? onFind;

  CustomDropdown(
      {this.onPressed,
      this.items,
      required this.controller,
      required this.onChanged,
      required this.header,
      this.onFind,
      this.isDisable = false,
      this.validator,
      required this.listHeight,
      this.selectedItem = "",
      this.dropdownBuilder,
      this.disableClear = false,
      this.icons = Icons.date_range,
      this.disable = false})
      : super();

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 17),
          child: DropdownSearch<String?>(
              enabled: !widget.disable,
              onSaved: (newValue) => {},
              maxHeight: 75 + (50 * widget.listHeight).toDouble(),
              selectedItem: widget.selectedItem,
              key: widget.key,
              onBeforeChange: (a, b) {
                if (b == null) {
                  AlertDialog alert = AlertDialog(
                    title: const Text("Seçim temizlenecektir."),
                    content: const Text("Emin misiniz?"),
                    actions: [
                      TextButton(
                        child: const Text("Tamam"),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            widget.controller.clear();
                            widget.isDisable = true;
                          });
                        },
                      ),
                      TextButton(
                        child: const Text("Vazgeç"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                  return showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      });
                }

                return Future.value(true);
              },
              emptyBuilder: (context, searchEntry) => Center(
                  child: Text('Herhangi bir veri bulunamadı.',
                      style: TextStyle(color: Colors.black))),
              showAsSuffixIcons: true,
              validator: widget.validator,
              isFilteredOnline: widget.onFind == null ? false : true,
              onFind: widget.onFind,
              showClearButton: widget.disableClear
                  ? false
                  : widget.controller.text == ""
                      ? false
                      : true,
              dropdownSearchDecoration: InputDecoration(
                errorStyle: TextStyle(color: APPColors.Main.red),
                border: InputBorder.none,
              ),
              mode: Mode.DIALOG,
              items: widget.items,
              showSearchBox: true,
              dropdownBuilder: widget.dropdownBuilder ?? _customDropDownAddress,
              onChanged: widget.onChanged)),
    );
  }

  Widget _customDropDownAddress(BuildContext context, String? itemDesignation) {
    return TextField(
      style: TextStyle(
          color: !widget.disable ? APPColors.Main.black : APPColors.Main.grey),
      readOnly: true,
      controller: widget.controller,
      enabled: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icons,
          size: MediaQuery.of(context).size.height / 30,
          color: widget.controller.text != ""
              ? APPColors.Main.blue
              : APPColors.Main.grey,
        ),
        labelStyle: TextStyle(
            color:
                !widget.disable ? APPColors.Main.black : APPColors.Main.grey),
        labelText: widget.header,
      ),
    );
  }
}
