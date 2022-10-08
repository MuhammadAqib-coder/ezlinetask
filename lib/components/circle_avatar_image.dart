import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eziline_task/services/image_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircleAvatarImage extends StatefulWidget {
  const CircleAvatarImage({Key? key}) : super(key: key);

  @override
  State<CircleAvatarImage> createState() => _CircleAvatarImageState();
}

class _CircleAvatarImageState extends State<CircleAvatarImage> {
  File? image;
  dynamic map;
  String imagePath = '';

  var showImage = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        map = value.data();
        imagePath = map['photo_url'];
      }
      //image = File(map['photo_url']);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 110,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          imagePath.isNotEmpty
              ? CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(imagePath),
                )
              : image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(image!.path).absolute),
                      backgroundColor: Colors.blue,
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
          Positioned(
              bottom: 5,
              right: 5,
              child: InkWell(
                onTap: () async {
                  //showImage.value = false;
                  image = await ImageService.getImage(context);
                  if (image!.path.isEmpty) {
                  } else {
                    //image setting is not cleared
                    //use provider
                    //imagePath = image!.path;
                    imagePath = '';
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.camera_alt_outlined, size: 20)),
                ),
              )),
        ],
      ),
    );
  }
}
