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
      {super.key,
      this.onPressed,
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
      this.disable = false});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          emptyBuilder: (context, searchEntry) => const Center(child: Text('Herhangi bir veri bulunamadı.', style: TextStyle(color: Colors.black))),
          showAsSuffixIcons: false,
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
          onChanged: widget.onChanged),
    );
  }

  Widget _customDropDownAddress(BuildContext context, String? itemDesignation) {
    return TextField(
      controller: widget.controller,
      enabled: false,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelStyle: TextStyle(color: !widget.disable ? Colors.black : APPColors.Main.black),
        labelText: widget.header,
      ),
    );
  }
}
