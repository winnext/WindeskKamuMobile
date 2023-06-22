// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomMainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomMainAppbar({Key? key, required this.title, this.leading, this.returnBack, this.actions}) : super(key: key);

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? returnBack;

  // final double _appbarHeight = 50;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      leading: returnBack == true
          ? IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.black))
          : leading,
      automaticallyImplyLeading: returnBack ?? false,
      actions: actions != null ? actions! : [],
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
