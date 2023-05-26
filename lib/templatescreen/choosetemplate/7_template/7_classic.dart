import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> templateClassic7(
    PdfPageFormat format, List<dynamic> data) async {
  final doc = pw.Document(title: 'My Resume');

  // final profileImage = pw.MemoryImage(
  //   (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
  // );

  final pageTheme = await _myPageTheme(format);
  const PdfColor green = PdfColor.fromInt(0x0684e);
  const PdfColor headerGreen = PdfColor.fromInt(0xff26a69a);
  const PdfColor grey = PdfColor.fromInt(0x1f000000);

  doc.addPage(
      pw.MultiPage(
          pageTheme: pageTheme,
          build: (pw.Context context) => [
            pw.Container(
                child:pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Center(
                          child:pw.Column(
                              children: [
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                pw.Text(data[0]["fname"], style:  pw.TextStyle(fontSize: 25,fontWeight: pw.FontWeight.bold,color:PdfColors.grey800)),
                                pw.SizedBox(width: 5,),
                                    pw.Text(data[0]["mname"], style:  pw.TextStyle(fontSize: 25,fontWeight: pw.FontWeight.bold,color:PdfColors.grey800)),
                                    pw.SizedBox(width: 5,),
                                    pw.Text(data[0]["lname"], style:  pw.TextStyle(fontSize: 25,fontWeight: pw.FontWeight.bold,color:PdfColors.grey800)),
                                    pw.SizedBox(width: 5,),
                                  ]
                                ),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(data[0]["flat/house"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      pw.Text(data[0]["area"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                    ]
                                ),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(data[0]["landmark"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      ]
                                ),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(data[0]["city"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      pw.Text(data[0]["state"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      pw.Text(data[0]["pincode"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      ]),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(data[0]["email"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      pw.Text(data[0]["mobile"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  ,  "),
                                      pw.Text(data[0]["socialmedia"],style: const pw.TextStyle(fontSize: 12,color:PdfColors.grey800)),
                                      pw.Text("  .  "),
                                    ]
                                )
                              ]
                          )),
                      pw.SizedBox(height: 50),
                      pw.Partitions(
                          children: [
                            pw.Partition(
                                width: 200,
                                child: pw.Container(
                                  child: pw.Column(
                                      children: [
                                        pw.Column(
                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  //padding: pw.EdgeInsets.only(top:1),
                                                  child:pw.Text("Career Objective", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                              pw.SizedBox(height: 5,),
                                              pw.Divider(
                                                height: 1.5,
                                                color: PdfColors.grey600,
                                              ),
                                              pw.SizedBox(height: 5,),
                                              data[1] != "empty"?
                                              pw.Container(
                                                  padding: pw.EdgeInsets.only(top:2),
                                                  child:pw.Text(data[1], style:  pw.TextStyle(fontSize: 11,color:PdfColors.grey700))):pw.Container(),
                                            ]
                                        ),
                                        pw.SizedBox(height: 20,),
                                        pw.Column(
                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                                padding: pw.EdgeInsets.only(top:10),
                                                child:pw.Text("Education", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                            pw.SizedBox(height: 5,),
                                            pw.Divider(
                                              height: 1.5,
                                              color: PdfColors.grey600,
                                            ),
                                            pw.SizedBox(height: 5,),
                                            data[3] != "empty"?
                                            pw.ListView.builder(
                                                itemCount: data[3].length,
                                                itemBuilder: (context, index) {
                                                  return
                                                    pw.Column(
                                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                                        children: [
                                                          pw.Text(data[3][index]["institute_name"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                          pw.SizedBox(height: 2,),
                                                          pw.Text("${data[3][index]["start_date"]}  -  ${data[3][index]["end_date"]}", style:  pw.TextStyle( color:PdfColors.grey700)),
                                                          pw.SizedBox(height: 8,),
                                                          pw.Text(data[3][index]["degree"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                          pw.SizedBox(height: 2,),
                                                          pw.Text(data[3][index]["grade"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                          pw.SizedBox(height: 2,),
                                                          pw.Text(data[3][index]["comments"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                          pw.SizedBox(height: 2,),
                                                        ]
                                                    );

                                                }
                                            ):pw.Container()
                                          ],
                                        ),
                                        pw.SizedBox(height: 20,),
                                        pw.Column(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                                padding: pw.EdgeInsets.only(top:10),
                                                child:pw.Text("Languages", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                            pw.SizedBox(height: 5,),
                                            pw.Divider(
                                              height: 1.5,
                                              color: PdfColors.grey600,
                                            ),
                                            pw.SizedBox(height: 5,),
                                            data[7] != "empty"?
                                            pw.Wrap(
                                                direction: pw.Axis.horizontal,
                                                children: List.generate(data[7].length, (index){
                                                  return
                                                    pw.Container(
                                                        padding: pw.EdgeInsets.only(left: 5, right: 5),
                                                        child:pw.Text("${data[7][index]},")
                                                    );
                                                })):pw.Container()
                                          ],
                                        ),
                                        pw.SizedBox(height: 20,),
                                        pw.Column(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                                padding: pw.EdgeInsets.only(top:10),
                                                child:pw.Text("Skills", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                            pw.SizedBox(height: 5,),
                                            pw.Divider(
                                              height: 1.5,
                                              color: PdfColors.grey600,
                                            ),
                                            pw.SizedBox(height: 5,),
                                            data[7] != "empty"?
                                            pw.Wrap(
                                                direction: pw.Axis.horizontal,
                                                children: List.generate(data[7].length, (index){
                                                  return
                                                    pw.Container(
                                                        padding: pw.EdgeInsets.only(left: 5, right: 5),
                                                        child:pw.Text("${data[7][index]},")
                                                    );
                                                })):pw.Container()
                                          ],
                                        ),
                                      ]
                                  ),

                                )
                            ),
                            pw.Partition(
                                child: pw.Container(
                                    padding: pw.EdgeInsets.only(left: 20),
                                    child: pw.Column(
                                        children: [
                                          pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                              mainAxisAlignment: pw.MainAxisAlignment.start,
                                              children: [
                                                pw.Container(
                                                    padding: pw.EdgeInsets.only(top:0),
                                                    child:pw.Text("Certifications", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                                pw.SizedBox(height: 5,),
                                                pw.Divider(
                                                  height: 1.5,
                                                  color: PdfColors.grey600,
                                                ),
                                                pw.SizedBox(height: 5,),
                                                data[2] != "empty"?
                                                pw.ListView.builder(
                                                    itemCount: data[2].length,
                                                    itemBuilder: (context, index) {
                                                      return
                                                        pw.Column(
                                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            children: [
                                                              pw.Text(data[2][index]["issue_desc"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                              pw.SizedBox(height: 2,),
                                                              pw.Text(data[2][index]["course_name"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                              pw.SizedBox(height: 2,),
                                                              pw.Text("${data[2][index]["start_date"]}  -  ${data[2][index]["end_date"]}", style:  pw.TextStyle( color:PdfColors.grey700)),
                                                              pw.SizedBox(height: 8,),
                                                              pw.Text(data[2][index]["link"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                              pw.SizedBox(height: 2,),
                                                            ]
                                                        );
                                                    }
                                                ):pw.Container()
                                              ]
                                          ),
                                          pw.Column(
                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  padding: pw.EdgeInsets.only(top:10),
                                                  child:pw.Text("Experience", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                              pw.SizedBox(height: 5,),
                                              pw.Divider(
                                                height: 1.5,
                                                color: PdfColors.grey600,
                                              ),
                                              pw.SizedBox(height: 5,),
                                              data[4] != "empty"?
                                              pw.ListView.builder(
                                                  itemCount: data[4].length,
                                                  itemBuilder: (context, index) {
                                                    return
                                                      pw.Column(
                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                          children: [
                                                            pw.Text(data[4][index]["company_name"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                            pw.SizedBox(height: 2,),
                                                            pw.Text("${data[4][index]["start_date"]}  -  ${data[4][index]["end_date"]}", style:  pw.TextStyle( color:PdfColors.grey700)),
                                                            pw.SizedBox(height: 8,),
                                                            pw.Text(data[4][index]["content"], style:  pw.TextStyle( color:PdfColors.grey600)),
                                                            pw.SizedBox(height: 20,),
                                                          ]
                                                      );
                                                  }
                                              ):pw.Container()
                                            ],
                                          ),
                                          pw.Column(
                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  padding: pw.EdgeInsets.only(top:10),
                                                  child:pw.Text("Project", style:  pw.TextStyle(fontSize: 13,fontWeight: pw.FontWeight.bold, color:PdfColors.teal500))),
                                              pw.SizedBox(height: 5,),
                                              pw.Divider(
                                                height: 1.5,
                                                color: PdfColors.grey600,
                                              ),
                                              pw.SizedBox(height: 5,),
                                              data[6] != "empty"?
                                              pw.ListView.builder(
                                                  itemCount: data[6].length,
                                                  itemBuilder: (context, index) {
                                                    return
                                                      pw.Column(
                                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                          children: [
                                                            pw.Text(data[6][index]["project_role"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                            pw.SizedBox(height: 2,),
                                                            pw.Text(data[6][index]["project_name"], style:  pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold, color:PdfColors.grey800)),
                                                            pw.SizedBox(height: 2,),
                                                            pw.Text("${data[6][index]["start_date"]}  -  ${data[6][index]["end_date"]}", style:  pw.TextStyle( color:PdfColors.grey700)),
                                                            pw.SizedBox(height: 5,),
                                                            pw.Text(data[6][index]["description"], style:  pw.TextStyle( color:PdfColors.grey600)),
                                                            pw.SizedBox(height: 10,),

                                                          ]
                                                      );
                                                  }
                                              ):pw.Container()
                                            ],
                                          ),
                                        ]
                                    )
                                )
                            )
                          ]
                      )
                    ]
                )
            )
          ]
      )
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format,) async {
  final bgShape = await rootBundle.loadString('assets/imgTemp7.svg');
  final bgShape1 = await rootBundle.loadString('assets/imgTemp7R.svg');
  final bgLine = await rootBundle.loadString('assets/imgTemp7L.svg');

  format = PdfPageFormat.a4.applyMargin(left:0, top:0, right:0, bottom:0);
  return pw.
  PageTheme(
    pageFormat: format,
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: -73,
              top: -300,
            ),
            pw.Positioned(
              child: pw.SvgImage(svg: bgLine),
              left: -73,
              top: 450,
            ),
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape1),
              left: -70,
              top: -200,
            ),
          ],
        ),
      );
    },
  );
}


