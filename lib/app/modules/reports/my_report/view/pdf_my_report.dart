import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../controllers/pdf_controller.dart';
import '../../../../helper/date_converter.dart';
import '../controller/my_report_controller.dart';

MyReportController myReport = MyReportController(sharedPreferences: Get.find());

class PdfMyReport extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    start;
  }

  final start;
  final allPrecens;
  final end;
  PdfMyReport(
      {required this.start, required this.allPrecens, required this.end});
  Future<File> generate() async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildTitle(),
        SizedBox(height: 5 * PdfPageFormat.mm),
        buildAttendance(),
        Divider(),
        buildTotal(),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfController.saveDocument(
        name: '${myReport.userName + 'Report'}.pdf', pdf: pdf);
  }

  static Widget buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text('Company Name :',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('Lean Code',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ],
          ),
          Row(children: [
            Text('Address :', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('AL Zobairy Street ',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          Row(children: [
            Text('Phone :', style: TextStyle(fontWeight: FontWeight.bold)),
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
          Text('Employee Name: ${myReport.userName}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Branch Name: Tech Now'),
        ],
      );

  static Widget buildInvoiceInfo() {
    final titles = <String>[
      'Report Date :${DateConverter.estimatedDate(DateTime.now())}',
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

        return buildText(title: title, value: '555', width: 200);
      }),
    );
  }

  Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: 30 * PdfPageFormat.mm),
            Text('Date From : '),
            Text('${DateFormat("M/d/yyyy").format(start)}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 15 * PdfPageFormat.mm),
            Text('Date To : '),
            Text('${DateFormat("M/d/yyyy").format(end)}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
        ],
      );

  Widget buildAttendance() {
    final headers = [
      'Date',
      'Check In ',
      'Check Out',
      'In Area',
      'Status',
      'Hours Work',
    ];
    // final List<List<dynamic>> data = [
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    //   ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    // ];

    return Table.fromTextArray(
      headers: headers,
      data: allPrecens,
      border: TableBorder.all(width: 1.0, color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
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
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
