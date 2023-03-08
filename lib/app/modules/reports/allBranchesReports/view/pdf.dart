import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';


class PdfGenerator extends GetxController {
  static late Font arFont;

  static init() async {
    arFont =
        Font.ttf((await rootBundle.load("assets/fonts/cairo/Cairo-Black.ttf")));
  }

  static createPdf() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File("${path}MY_PDF.pdf");

    Document pdf = Document();
    pdf.addPage(MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        //   pageFormat: PdfPageFormat.roll80,
        build: (context) => [
              Wrap(children: []),
              Center(
                  child: Container(
                      child: Text(
                          maxLines: 4,
                          " أفضل 18 مقدمة تعبير وخاتمة لأي موضوع تعبير، لنا  في الأهمية    التعليمية.")))
            ]));

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    //createImg(file.path);
    await OpenFile.open(file.path);
  }

  static MultiPage _createPage() {
    return MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        pageFormat: PdfPageFormat.roll80,
        build: (context) =>
            [Center(child: Container(child: Text("بسم الله")))]);
  }

  static createImg(String path) {
 //   PdfConverter.convertToImage(path);
  }
}
