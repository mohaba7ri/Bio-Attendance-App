import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../controllers/pdf_controller.dart';
import '../../../../helper/date_converter.dart';

//EmpReportsController employeeReport = EmpReportsController();

class PdfAllBranch {
  // final start;
  // final allPrecens;
//  final end;
  // PdfEmpReport(
  //     {required this.start, required this.end});
  static late Font arFont;
  static init() async {
    arFont =
        Font.ttf(await rootBundle.load("assets/fonts/cairo/Cairo-Bold.ttf"));
  }

  Future<File> generate() async {
    final arabicFont =
        await rootBundle.load("assets/fonts/Tajawal/Tajawal-Medium.ttf");
    final ttf = Font.ttf(arabicFont);

    final pdf = Document();

    pdf.addPage(MultiPage(
      theme: ThemeData.withFont(base: arFont),
      textDirection: TextDirection.rtl,
      build: (context) => [
        buildHeader(),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildTitle(),
        SizedBox(height: 5 * PdfPageFormat.mm),
        buildAttendance(ttf),
        Divider(),
        buildTotal(),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfController.saveDocument(name: 'branch.pdf', pdf: pdf);
  }

  static Widget buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  'أسم الشركة :',
                ),
                SizedBox(width: 8),
                Text(
                  'Lean Code',
                ),
              ]),
            ],
          ),
          Row(children: [
            Text(
              'العنوان :',
            ),
            SizedBox(width: 8),
            Text(
              'AL Zobairy Street ',
            ),
          ]),
          Row(children: [
            Text(
              'رقم الهاتف :',
            ),
            SizedBox(width: 8),
            Text('+967 7777845788 ',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildEmployee(),
              buildInvoiceInfo(),
            ],
          ),
        ],
      );

  static Widget buildEmployee() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Employee Name: ${employeeReport.user['name']}',
          //     style: TextStyle(fontWeight: FontWeight.bold)),
          Text('أسم الفرع: الزبيري'),
        ],
      );

  static Widget buildInvoiceInfo() {
    final titles = <String>[
      'تأريخ التقرير :${DateConverter.estimatedDate(DateTime.now())}',
    ];
//  final data = <String>[
//       info.number,
//       Utils.formatDate(info.date),
//       paymentTerms,
//       Utils.formatDate(info.dueDate),
//     ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        //   final value = data[index];

        return buildText(title: title, value: '', width: 200);
      }),
    );
  }

  Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(children: [
          //   SizedBox(width: 30 * PdfPageFormat.mm),
          //   Text('Date From : '),
          //   Text('${DateFormat("M/d/yyyy").format(start)}',
          //       style: TextStyle(fontWeight: FontWeight.bold)),
          //   SizedBox(width: 15 * PdfPageFormat.mm),
          //   Text('Date To : '),
          //   Text('${DateFormat("M/d/yyyy").format(end)}',
          //       style: TextStyle(fontWeight: FontWeight.bold)),
          // ]),
        ],
      );

  Widget buildAttendance(ttf) {
    final headers = [
      'أسم الفرع',
      'العنوان',
      'الهاتف',
      'عدد الموظفين',
    ];
    final List<List<dynamic>> data = [
      ['فرع  عطان  المركز  الرئيسي', 'عطان صنعاء', '730073350', '11'],
      ['فرع  عطان  المركز  الرئيسي', 'عطان صنعاء', '730073350', '11'],
      ['فرع  عطان  المركز  الرئيسي', 'عطان صنعاء', '730073350', '11'],
      ['فرع  عطان  المركز  الرئيسي', 'عطان صنعاء', '730073350', '11'],
    ];
// Load a custom Arabic font

    return Table.fromTextArray(
      headers: headers,
      data: data,
      cellStyle: TextStyle(font: ttf),
      border: TableBorder.all(width: 1.0, color: PdfColors.black),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal() {
    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Salary',
                  value: '120000',
                  unite: true,
                ),
                buildText(
                  title: 'Total Hours Work',
                  value: '120',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
          )),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
