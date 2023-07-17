// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:invoice_ondgo/item/model/item_model.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pathHelper;
import 'package:flutter/services.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';

class GeneratePdf {
  Future<String> generatePDF({
    required String customerName,
    required String customerNum,
    required String customerAddress,
    required String customerNote,
    required DateTime dueDate,
    required List<int?> quantities,
    required List<ItemListModel> items,
    required buisnessName,
    required phoneNumber,
    required businessLocation,
    required state,
    required accountName,
    required bank,
    required accountNumber,
    required currency,
  }) async {
    final pdf = pdfWidgets.Document();

    // Load the custom font
    final fontData = await rootBundle.load("assets/open-sans.ttf");
    final ttf = pdfWidgets.Font.ttf(fontData);
    final ttfBold = pdfWidgets.Font.ttf(
      fontData,
    );
    print(buisnessName);
    final headers = ['Name', 'Quantity', 'Unit', 'Amount'];

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          final formattedDueDate =
              DateFormat('dd/MM/yyyy').format(dueDate); // Format due date

          return pdfWidgets.Column(
            crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
            children: [
              pdfWidgets.Container(
                color: PdfColors.blue,
                padding: pdfWidgets.EdgeInsets.all(20),
                child: pdfWidgets.Center(
                  child: pdfWidgets.Column(children: [
                    Text(buisnessName,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    Text(businessLocation,
                        style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                        )),
                    Text(phoneNumber,
                        style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                        )),
                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Account Name: ',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$accountName',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          )
                        ]),
                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Account Number: ',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$accountNumber',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          )
                        ]),
                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Bank',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$bank',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          )
                        ]),
                  ]),
                ),
              ),

              SizedBox(height: 20),
              pdfWidgets.Container(
                padding: pdfWidgets.EdgeInsets.all(20),
                child: pdfWidgets.Center(
                  child: pdfWidgets.Column(children: [
                    //kk

                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Customer Name: ',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$customerName',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Customer Number: ',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$customerNum',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pdfWidgets.Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pdfWidgets.Text(
                            'Customer Address: ',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                          pdfWidgets.Text(
                            '$customerAddress',
                            style: pdfWidgets.TextStyle(
                              font: ttf,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    if (dueDate != null)
                      pdfWidgets.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pdfWidgets.Text(
                              'Due Date: ',
                              style: pdfWidgets.TextStyle(
                                font: ttf,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pdfWidgets.Text(
                              '$formattedDueDate',
                              style: pdfWidgets.TextStyle(
                                font: ttf,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                          ]),
                  ]),
                ),
              ),

              SizedBox(height: 20),
              buildItemTable(ttf, ttfBold, items,
                  quantities), // Use the modified buildItemTable function

              pdfWidgets.Column(children: [
                pdfWidgets.Text(
                  ' Note',
                  style: pdfWidgets.TextStyle(
                    font: ttf,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
                pdfWidgets.Text(
                  customerNote,
                  style: pdfWidgets.TextStyle(
                    font: ttf,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ])
            ],
          );
        },
      ),
    );

    final directory = await getExternalStorageDirectory();
    final String filePath =
        pathHelper.join(directory!.path, 'customer_invoice.pdf');
    final file = io.File(filePath);
    print(file);

    await file.writeAsBytes(await pdf.save());

    return filePath;
  }

  Future<void> openPDFFile(String filePath) async {
    OpenFile.open(filePath);
    print('Invoice Generated Successfully!');
  }

  // Modified function to build the item table
  static pdfWidgets.Widget buildItemTable(
    pdfWidgets.Font ttf,
    pdfWidgets.Font ttfBold,
    List<ItemListModel> items,
    List<int?> quantities,
  ) {
    final headers = [
      'Items',
      'Items Desc',
      'Qty',
      'Tax',
      'Unit Price',
      'Amount'
    ];
    double subtotal = 0;
    double total = 0;
    double taxSum = 0; // Variable to store the sum of tax rates

    final data = items.map((item) {
      final quantity = quantities[items.indexOf(item)]!;
      final amount = (quantity * item.unitPrice) +
          (item.taxRate * (quantity * item.unitPrice)) / 100;

      //(quantity * item.unitPrice);
      total = (quantity * item.unitPrice) +
          (item.taxRate * (quantity * item.unitPrice)) / 100;

      subtotal = total - (item.taxRate * (quantity * item.unitPrice)) / 100;
      taxSum += item.taxRate;
      total = total;

      return [
        item.itemName,
        item.description,
        quantity,
        item.taxRate,
        item.unitPrice,
        amount,
      ];
    }).toList();

    return pdfWidgets.Column(children: [
      pdfWidgets.Table.fromTextArray(
        cellHeight: 30,
        cellAlignments: {
          0: pdfWidgets.Alignment.centerLeft,
          1: pdfWidgets.Alignment.centerLeft,
          2: pdfWidgets.Alignment.centerLeft,
          3: pdfWidgets.Alignment.centerLeft,
          4: pdfWidgets.Alignment.centerLeft,
          5: pdfWidgets.Alignment.centerLeft,
        },
        headerDecoration: pdfWidgets.BoxDecoration(color: PdfColors.grey),
        headerStyle: pdfWidgets.TextStyle(
          fontWeight: pdfWidgets.FontWeight.bold,
          font: ttfBold,
        ),
        border: null,
        cellStyle: pdfWidgets.TextStyle(font: ttf),
        headers: headers,
        data: data,
      ),
      pdfWidgets.SizedBox(height: 20),
      pdfWidgets.Row(
        mainAxisAlignment: pdfWidgets.MainAxisAlignment.spaceBetween,
        children: [
          pdfWidgets.SizedBox(height: 2),
          pdfWidgets.Column(
            crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
            children: [
              pdfWidgets.Row(children: [
                pdfWidgets.Text(
                  'SubTotal:',
                  style: pdfWidgets.TextStyle(
                    font: ttf,
                    fontSize: 12,
                    fontWeight: pdfWidgets.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
                pdfWidgets.Text(
                  '\$${subtotal.toStringAsFixed(2)}',
                  style: pdfWidgets.TextStyle(
                    font: ttf,
                    fontSize: 12,
                    fontWeight: pdfWidgets.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ]),
              pdfWidgets.Row(
                children: [
                  pdfWidgets.Text(
                    'Tax:',
                    style: pdfWidgets.TextStyle(
                      font: ttf,
                      fontSize: 12,
                      fontWeight: pdfWidgets.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pdfWidgets.Text(
                    '${taxSum.toStringAsFixed(2)}',
                    style: pdfWidgets.TextStyle(
                      font: ttf,
                      fontSize: 12,
                      fontWeight: pdfWidgets.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pdfWidgets.Row(
                children: [
                  pdfWidgets.Text(
                    'Total',
                    style: pdfWidgets.TextStyle(
                      font: ttf,
                      fontSize: 12,
                      fontWeight: pdfWidgets.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pdfWidgets.Text(
                    total.toStringAsFixed(2),
                    style: pdfWidgets.TextStyle(
                      font: ttf,
                      fontSize: 12,
                      fontWeight: pdfWidgets.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
