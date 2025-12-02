import 'dart:io';
import 'dart:typed_data';

//import  'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Document {
  /*
  // dosya indirip bildirim gönderir
  void saveAndDownloadFile(File file, Uint8List document) async {
    PermissionStatus status = await checkExternalStoragePermission();
    if (status.isGranted) {
      try {
        await file
            .writeAsBytes(document.buffer
                .asUint8List(document.offsetInBytes, document.lengthInBytes))
            .then((value) {
          EasyLoading.dismiss();
          LocalNotification.showNotificationMediaStyle(file.path);
        }).onError((error, stackTrace) {
          GlobalNavigator.showAlertDialog(error.toString());
          throw error.toString();
        });
      } on FileSystemException catch (err) {
        throw err;
      }
    } else {
      Permission.storage.request();
    }
  }

//Saf ile dosya indirir
  downloadFile(String fileName, Uint8List document, String mimeType) async {
    PermissionStatus status = await checkExternalStoragePermission();
    if (status.isGranted) {
      if (Platform.isAndroid) {
        return downloadFileAndroid(fileName, document, mimeType);
      } else if (Platform.isIOS) {
        downloadFileIos(fileName, document, mimeType);
      }
    } else {
      Permission.storage.request();
      return false;
    }
  }

  Future<bool> downloadFileAndroid(
      String fileName, Uint8List document, String mimeType) async {
    Uri? selectedUriDir;
    final pref = await SharedPreferences.getInstance();
    final scopeStoragePersistUrl = pref.getString('scopeStoragePersistUrl');

    // Check User has already grant permission to any directory or not
    if (scopeStoragePersistUrl != null &&
        await saf.isPersistedUri(Uri.parse(scopeStoragePersistUrl)) &&
        (await saf.exists(Uri.parse(scopeStoragePersistUrl)) ?? false)) {
      selectedUriDir = Uri.parse(scopeStoragePersistUrl);
    } else {
      selectedUriDir = await saf.openDocumentTree();
      await pref.setString('scopeStoragePersistUrl', selectedUriDir.toString());
    }
    if (selectedUriDir == null) {
      return false;
    }
    print(selectedUriDir);

    try {
      final newDocumentFile = await saf.createFileAsBytes(
        selectedUriDir,
        mimeType: mimeType == "pdf"
            ? "application/pdf"
            : "text/comma-separated-values",
        bytes: document,
        displayName: fileName,
      );

      print(newDocumentFile!.uri!.path);
      EasyLoading.dismiss();
      LocalNotification.showNotificationMediaStyle(
          "${selectedUriDir}/$fileName.$mimeType");
      //  LocalNotification.showNotificationMediaStyle(newDocumentFile!.uri!.path);
      return true;
    } catch (e) {
      debugPrint("Exception while create new file: ${e.toString()}");
      return false;
    }
  }

  downloadFileIos(String fileName, Uint8List document, String mimeType) async {
    Directory? dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$fileName.$mimeType');
    print(file.path);
    PermissionStatus status = await checkExternalStoragePermission();
    if (status.isGranted) {
      try {
        await file
            .writeAsBytes(document.buffer
                .asUint8List(document.offsetInBytes, document.lengthInBytes))
            .then((value) {
          EasyLoading.dismiss();
          LocalNotification.showNotificationMediaStyle(file.path);
        }).onError((error, stackTrace) {
          GlobalNavigator.showAlertDialog(error.toString());
          throw error.toString();
        });
      } on FileSystemException catch (err) {
        throw err;
      }
    } else {
      Permission.storage.request();
    }
  }

  Future<PermissionStatus> checkExternalStoragePermission() async {
    PermissionStatus? status;
    if (Platform.isAndroid) {
      if (int.parse(BaseService.deviceInfo!.release.toString()) < 13) {
        status = await Permission.storage.status;
      } else {
        status = await Permission.manageExternalStorage.status;
      }
      // ignore: prefer_interpolation_to_compose_strings
      if (status == PermissionStatus.denied) {
        if (int.parse(BaseService.deviceInfo!.release.toString()) < 13) {
          status = await Permission.storage.request();
        } else {
          status = await Permission.manageExternalStorage.request();
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        GlobalNavigator.showAlertDialog(
            "Dosyayı açmak için uygulama ayarlarından tüm dosya işlerine izin vermelisin.");
      } else if (status == PermissionStatus.restricted) {
        GlobalNavigator.showAlertDialog(
            "Dosyayı açmak için uygulama ayarlarından tüm dosya işlerine izin vermelisin.");
      }
      if (status.isGranted) {}
    } else if (Platform.isIOS) {
      status = await Permission.storage.status;
    }

    return status!;
  }

*/
  Future<void> shareFile(
      {required String fileName,
      required Uint8List bytes,
      required String ext,
      String? filePath,
      Rect? sharePositionOrigin}) async {
    if (filePath == null) {
      Directory? dir = (Platform.isAndroid)
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      filePath = dir!.path;
    }

    //      await FileSaver.instance
    //      .saveFile(name: fileName, bytes: bytes, ext: ext, filePath: filePath);

    File fileDef = File('$filePath/$fileName.csv');
    await fileDef.create(recursive: true);
    //Uint8List bytes = await file.readAsBytes();
    await fileDef.writeAsBytes(bytes);

    if (await File('$filePath/$fileName.csv').exists()) {
      await Share.shareXFiles(
        [XFile('$filePath/$fileName.$ext')],
        sharePositionOrigin: sharePositionOrigin,
      );
      File('$filePath/$fileName.$ext').delete();
    } else {
      print('File does not exist: $filePath/$fileName.$ext');
    }
  }
}
