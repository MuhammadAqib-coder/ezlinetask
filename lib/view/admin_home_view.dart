import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                // String url = snapshot.data!.docs[index]['photo_url'];
                // bool value =
                //     snapshot.data!.docs[index]['attendance_permission'];
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(snapshot.data!.docs[index]['photo_url']),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Allow Attendance'),
                        Switch(
                          value: snapshot.data!.docs[index]['attendance_permission'],
                          onChanged: (newValue) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(snapshot.data!.docs[index].id)
                                .update({'attendance_permission': newValue});
                          },
                        )
                      ],
                    )
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text('No User found'),
            );
          }
        },
      ),
    );
  }
}
