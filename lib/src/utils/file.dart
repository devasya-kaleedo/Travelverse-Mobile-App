import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkAndRequestStoragePermission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    status = await Permission.manageExternalStorage.request();
  }
  return status.isGranted;
}

Future openFile(String url, String fileName) async {
  final file = await downloadFile(url, fileName);
  if (file == null) return;
  OpenFile.open(file.path);
}

Future<File?> downloadFile(String url, String name) async {
  if (!kIsWeb) {
    final hasPermission = await checkAndRequestStoragePermission();
    if (!hasPermission) {
      throw Exception(
          'Storage permission needed for downloading and viewing files.');
    }
  }
  final appStorage = await getExternalStorageDirectory();
  final file = File('${appStorage?.absolute.path}/$name');
  try {
    final response = await dio.Dio().get(url,
        options: dio.Options(
            responseType: dio.ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration.zero));
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  } catch (e) {
    print(e.toString());
  }
}
