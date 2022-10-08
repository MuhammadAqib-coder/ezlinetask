import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eziline_task/services/message_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<File> getImage(context) async {
    File? image;
    final storage = FirebaseStorage.instance;
    // String filePath;
    String fileName = FirebaseAuth.instance.currentUser!.uid;

    try {
      final pickFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickFile != null) {
        image = File(pickFile.path);
        // fileName = pickFile.name;
        await storage.ref('test/$fileName').putFile(image);
        String url = await storage.ref('test/$fileName').getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'photo_url': url});
      }
    } on FirebaseException catch (e) {
      MessageService.displaySnackbar(e.toString(), context);
    } catch (e) {
      MessageService.displaySnackbar(e.toString(), context);
    }
    return image!;
  }
}
