import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/workorder_detail_provider.dart';
import '../../utils/themes.dart';

class AddDocumantSheet extends StatefulWidget {
  const AddDocumantSheet({super.key});

  @override
  State<AddDocumantSheet> createState() => _AddDocumantSheetState();
}

class _AddDocumantSheetState extends State<AddDocumantSheet> {
  final String _hintDescription = 'Açıklama giriniz';
  final String _pickDocumant = 'Doküman seç';

  @override
  Widget build(BuildContext context) {
    final WoDetailViewProvider woDetailViewProvider = Provider.of<WoDetailViewProvider>(context, listen: true);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _pickDoc(woDetailViewProvider),
            woDetailViewProvider.isDocumantPicked ? Image.asset('assets/images/pdf.png', height: 80, width: 80) : const SizedBox(),
            _descriptionTextField(woDetailViewProvider),
            _buttons(woDetailViewProvider),
          ],
        ),
      ),
    );
  }

  SizedBox _pickDoc(WoDetailViewProvider woDetailViewProvider) {
    return SizedBox(
      height: 50,
      width: 80.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.blue,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 10,
        ),
        onPressed: () async {
          await woDetailViewProvider.pickDocumant();
          setState(() {});
        },
        child: Text(_pickDocumant),
      ),
    );
  }

  Expanded _buttons(WoDetailViewProvider woDetailViewProvider) {
    return Expanded(
      flex: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CancelDoc(woDetailViewProvider: woDetailViewProvider),
          SizedBox(width: 10.w),
          _SaveDoc(woDetailViewProvider: woDetailViewProvider)
        ],
      ),
    );
  }

  TextField _descriptionTextField(WoDetailViewProvider woDetailViewProvider) {
    return TextField(
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(hintText: _hintDescription),
      onChanged: (value) {
        woDetailViewProvider.setPdfDesc = value.toString();
      },
    );
  }
}

class _CancelDoc extends StatelessWidget {
  const _CancelDoc({
    required this.woDetailViewProvider,
  });

  final String _cancel = 'Vazgeç';
  final WoDetailViewProvider woDetailViewProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.red,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          woDetailViewProvider.setIsDocumantPicked = false;
          Navigator.pop(context);
        },
        child: (Text(_cancel)),
      ),
    );
  }
}

class _SaveDoc extends StatelessWidget {
  const _SaveDoc({
    required this.woDetailViewProvider,
  });
  final String _save = 'Kaydet';

  final WoDetailViewProvider woDetailViewProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: APPColors.Login.blue,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        onPressed: () {
          woDetailViewProvider.setIsDocumantPicked = false;
          woDetailViewProvider.saveDocumant();
          Navigator.pop(context);
        },
        child: (Text(_save)),
      ),
    );
  }
}
