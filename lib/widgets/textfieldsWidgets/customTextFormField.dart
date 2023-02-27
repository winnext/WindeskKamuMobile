// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:win_kamu/utils/themes.dart';
import 'package:win_kamu/utils/utils.dart';
import 'package:intl/intl.dart';

class CustomTextFormField extends StatefulWidget {
  final List<Widget> children;
  final String sectionName;
  const CustomTextFormField(
      {Key? key, required this.children, required this.sectionName})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: widget.children,
    );
  }
}

class CustomTextFormFieldContent extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final bool isDate;
  final bool? obscureText;
  final bool readOnly;
  final IconData icon;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode;
  final bool isBorder;
  final bool isIcon;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final String? placeholder;
  final bool disableFormatDate;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final bool isDropdown;
  final Function(String)? onChanged;
  final int maxLength;
  final VoidCallback? onTap;
  final bool isTime;
  final bool formatDate;
  final String? errorText;
  final bool isSuffix;
  final IconData? suffixIcon;
  final Color? iconColor;
  final VoidCallback? onSuffixTap;
  final bool preventSpecialCharacters;
  const CustomTextFormFieldContent(
      {Key? key,
      required this.controller,
      required this.name,
      this.preventSpecialCharacters = false,
      this.placeholder = "",
      this.validator,
      this.inputType = TextInputType.text,
      this.isDropdown = false,
      this.onTap,
      this.isSuffix = false,
      this.onSuffixTap,
      this.suffixIcon,
      this.obscureText = false,
      this.isDate = false,
      this.readOnly = false,
      this.maxLength = 60,
      this.formatDate = true,
      this.isTime = false,
      this.disableFormatDate = false,
      this.onChanged,
      this.isBorder = false,
      this.errorText,
      this.AutovalidateMode,
      this.icon = Icons.mail,
      this.isIcon = true,
      this.inputFormatters,
      this.hintText = "",
      this.textCapitalization = TextCapitalization.none,
      this.iconColor})
      : super(key: key);

  @override
  State<CustomTextFormFieldContent> createState() =>
      _CustomTextFormFieldContentState();
}

class _CustomTextFormFieldContentState
    extends State<CustomTextFormFieldContent> {
  String displayDateFormat = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 20,
          top: MediaQuery.of(context).size.height / 150,
          bottom: MediaQuery.of(context).size.height / 70),
      child: !widget.isDate
          ? TextFormField(
              autovalidateMode: widget.AutovalidateMode,
              inputFormatters: widget.preventSpecialCharacters
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ]
                  : widget.inputFormatters,
              onChanged: widget.onChanged,
              maxLength: widget.maxLength,
              textInputAction: TextInputAction.next,
              textCapitalization: widget.textCapitalization,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText!,
              keyboardType: widget.inputType,
              style: TextStyle(fontSize: font_size_16),
              validator: widget.validator,
              controller: widget.controller,
              decoration: InputDecoration(
                labelText: widget.name,
                errorText: widget.errorText,
                errorMaxLines: 3,
                hintText: widget.hintText,
                counterText: "",
                isDense: true,
                suffixIcon: widget.isSuffix
                    ? IconButton(
                        icon: Icon(
                          widget.suffixIcon ?? Icons.remove_red_eye_sharp,
                        ),
                        onPressed: widget.onSuffixTap,
                      )
                    : null,
                prefixIcon: widget.isIcon
                    ? Icon(widget.icon,
                        color: widget.iconColor ?? APPColors.Main.blue,
                        size: MediaQuery.of(context).size.height / 30)
                    : null,
                prefixIconColor: APPColors.Main.blue,
                prefixStyle: TextStyle(fontSize: font_size_14),
                errorStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: APPColors.Main.red),
              ),
            )
          : !widget.disableFormatDate
              ? GestureDetector(
                  onTap: () {
                    widget.isTime
                        ? DatePicker.showDateTimePicker(context,
                            locale: LocaleType.tr,
                            showTitleActions: true,
                            minTime: DateTime(1950, 3, 5),
                            maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy - hh:mm').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd - hh:mm').format(date);

                            widget.controller.text = widget.formatDate
                                ? formattedDate.toString()
                                : unformattedDate.toString();
                          }, onChanged: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            widget.controller.text = widget.formatDate
                                ? formattedDate.toString()
                                : unformattedDate.toString();
                          })
                        : DatePicker.showDatePicker(context,
                            locale: LocaleType.tr,
                            showTitleActions: true,
                            minTime: DateTime(1950, 3, 5),
                            maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);

                            widget.controller.text = widget.formatDate
                                ? formattedDate.toString()
                                : unformattedDate.toString();
                          }, onChanged: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            widget.controller.text = widget.formatDate
                                ? formattedDate.toString()
                                : unformattedDate.toString();
                          });
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      obscureText: false,
                      style: TextStyle(fontSize: font_size_16),
                      validator: widget.validator,
                      controller: widget.controller,
                      decoration: InputDecoration(
                        labelText: widget.name,
                        prefixIcon: widget.isIcon
                            ? Icon(
                                widget.icon,
                                size: MediaQuery.of(context).size.height / 30,
                                color: widget.controller.text != ""
                                    ? APPColors.Main.blue
                                    : APPColors.Main.grey,
                              )
                            : null,
                        prefixIconColor: APPColors.Main.blue,
                        errorStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: APPColors.Main.red),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    widget.isTime
                        ? DatePicker.showDateTimePicker(context,
                            locale: LocaleType.tr,
                            showTitleActions: true,
                            minTime: DateTime(1950, 3, 5),
                            maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy - hh:mm').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd - hh:mm').format(date);

                            widget.controller.text =
                                date.toIso8601String().toString();
                            setState(() {
                              displayDateFormat = formattedDate;
                            });
                          }, onChanged: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            widget.controller.text =
                                date.toIso8601String().toString();
                            setState(() {
                              displayDateFormat = formattedDate;
                            });
                          })
                        : DatePicker.showDatePicker(context,
                            locale: LocaleType.tr,
                            showTitleActions: true,
                            minTime: DateTime(1950, 3, 5),
                            maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            setState(() {
                              displayDateFormat = formattedDate;
                            });

                            widget.controller.text =
                                date.toIso8601String().toString();
                          }, onChanged: (date) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            String unformattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            widget.controller.text =
                                date.toIso8601String().toString();
                            setState(() {
                              displayDateFormat = formattedDate;
                            });
                          });
                  },
                  child: AbsorbPointer(
                    child: Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(fontSize: font_size_12),
                        ),
                        Text(
                          widget.controller.text == ''
                              ? widget.placeholder!
                              : displayDateFormat,
                          style: TextStyle(color: APPColors.Main.red),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
