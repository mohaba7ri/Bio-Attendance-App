import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../controllers/pdf_controller.dart';
import '../../../../helper/date_converter.dart';

class PdfEmpReport extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    start;
  }

  final start;
  final allPrecens;
  final end;
  final double totalSalary;
  final company;
  final user;
  final branch;
  PdfEmpReport(
      {required this.company,
      required this.start,
      required this.branch,
      required this.allPrecens,
      required this.end,
      required this.user,
      required this.totalSalary});
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
        name: '${user['name'] + 'Report'}.pdf', pdf: pdf);
  }

  Widget buildHeader() => Column(
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
                Text('${company['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ],
          ),
          Row(children: [
            Text('Address :', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('${company['address']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          Row(children: [
            Text('Phone :', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('${company['phone']} ',
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

  Widget buildEmployee() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Name: ${user['name']}',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Branch Name: ${branch['name']}'),
        ],
      );

  static Widget buildInvoiceInfo() {
    final titles = <String>[
      'Report Date :${DateConverter.estimatedDate(DateTime.now())}',
    ];

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
      'Timing',
      'Status',
      'Hours Work',
    ];

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

  Widget buildTotal() {
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
                  value: '${totalSalary}',
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
