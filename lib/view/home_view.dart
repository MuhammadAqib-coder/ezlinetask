import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eziline_task/components/circle_avatar_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storage = FirebaseStorage.instance;
  String? url;
  bool showAttendance = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        url = value.data()!['photo_url'];
        showAttendance = value.data()!['attendance_permission'];
        setState(() {});
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'photo_url': '', 'attendance_permission': false});
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                url != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(url!),
                        radius: 40,
                      )
                    : CircleAvatar(
                        radius: 40,
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(FirebaseAuth.instance.currentUser!.email.toString())
              ],
            )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: const CircleAvatarImage()),
            const SizedBox(
              height: 30,
            ),
            showAttendance
                ? const Text(
                    'Attendance',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : const Text(
                    'Leave',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
          ],
        ),
      ),
    );
  }

  // getImage() async {
  //   return await storage
  //       .ref('test/${FirebaseAuth.instance.currentUser!.uid}')
  //       .getDownloadURL();
  // }
}
