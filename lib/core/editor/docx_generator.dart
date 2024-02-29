import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class DocxGenerator {
  Future<List<int>> generateDocxFromJson(List<Map<String, dynamic>> json);
}

class DocxGeneratorImpl implements DocxGenerator {
  @override
  Future<List<int>> generateDocxFromJson(
      List<Map<String, dynamic>> json) async {
    try {
      // final ByteData data =
      //     await rootBundle.load("assets/docx_template/template.docx");
      // final Uint8List bytes = data.buffer.asUint8List();
       final f = File("template.docx");
      final docx = await DocxTemplate.fromBytes(await f.readAsBytes());
      Content content = Content();
      content.addAll(TextContent("docname", "Simple docname"));
      final docxGenerated = await docx.generate(content);
      final directory = await getTemporaryDirectory();
      final outputPath = "${directory.path}/output.docx";
      final file = File(outputPath);
      await file.writeAsBytes(docxGenerated!);
      print(outputPath);
      return docxGenerated ?? f.readAsBytesSync();
    } catch (e) {
      print(e);
      throw Exception('Error with generate DocxFile');
    }
  }
}
