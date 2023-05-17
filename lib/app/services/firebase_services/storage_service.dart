import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
 

class StorageService {
  Future<String?> uploadFile(String userID, String folder, Uint8List file) async {

    final fstorage = FirebaseStorage.instance;
 
    final Reference storageRef =
        fstorage.ref().child('Users_files/$userID/$folder');
    final UploadTask uploadTask = storageRef.putData(file);
    return (await uploadTask).ref.getDownloadURL();
  }

  Future<String?> uploadPDF(String userID, String folder, File pdfFile) async {
    try {
      final fstorage = FirebaseStorage.instance;
      final File image = await File(pdfFile.absolute.path).create();
      final Reference storageRef =
          fstorage.ref().child('Users_files/$userID/$folder');
      final UploadTask uploadTask = storageRef.putFile(image);
      return await (await uploadTask).ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteFile({required String urlFile}) async {
    final String filePath = urlFile.replaceAll(
        'https://firebasestorage.googleapis.com/v0/b/lizit-production.appspot.com/o/Users_files%2F',
        '');
    try {
      await FirebaseStorage.instance.refFromURL(urlFile).delete();
      print('Successfully deleted $filePath storage item');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteImage({required path}) async {
    try {
      await FirebaseStorage.instance.refFromURL(path).delete();
      print('Successfully deleted $path storage item');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  // Future<String?> uploadPDF(String userID, String folder, File file) async {
  //   var tmpDir = await path_provider.getTemporaryDirectory();
  //   var targetName = DateTime.now().millisecondsSinceEpoch;
  //   File? compressFile = File(file.path);
  //   String url = "";
  //   var _fstorage = FirebaseStorage.instance;
  //   File image = compressFile;
  //   Reference storageRef = _fstorage.ref().child('Users_files/$userID/$folder');
  //   UploadTask uploadTask = storageRef.putFile(image);
  //   return url = await (await uploadTask).ref.getDownloadURL();
  // }
}

final StorageService storageService = StorageService();
