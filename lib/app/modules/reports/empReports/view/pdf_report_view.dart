import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:presence/app/controllers/pdf_controller.dart';

import '../controller/emp_reports_controller.dart';

class PdfEmpReport {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final employeeReport = EmpReportsController();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfController.saveDocument(
        name: '${employeeReport.employeeName['name'] + 'Report'}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
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
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildEmployee(),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildEmployee() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Name: امين الجلوة',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Branch Name: Tech Now'),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Report Date :${info.date}',
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text('Date From : ${invoice.info.date}'),
            Text('Date To:${invoice.info.date}')
          ])
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Date',
      'Check In ',
      'Check Out',
      'In Area',
      'Status',
      'Hours Work',
    ];
    final List<List<dynamic>> data = [
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
      ['2/28/2023', '8:00 AM', '2:00 PM', 'In Area', 'On Time', '8'],
    ];

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
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

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent;
    final total = netTotal + vat;

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

  static Widget buildFooter(Invoice invoice) => Column(
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

class Invoice {
  final InvoiceInfo info;

  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final String date;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
