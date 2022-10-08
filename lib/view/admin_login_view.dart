import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eziline_task/components/custom_textfield.dart';
import 'package:eziline_task/services/message_service.dart';
import 'package:eziline_task/view/admin_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminLoginView extends StatefulWidget {
  const AdminLoginView({Key? key}) : super(key: key);

  @override
  State<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends State<AdminLoginView> {
  var _passControler = TextEditingController();
  var _emailControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
   String? email;
 String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('admin')
        .doc('admin1')
        .get()
        .then((value) {
      if (value.exists) {
        email = value.data()!['email'];
        password = value.data()!['password'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(' Admin Login'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Email',
              controller: _emailControler,
            ),
            CustomTextField(
              labelText: 'password',
              controller: _passControler,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_emailControler.text.trim() == email &&
                        _passControler.text.trim() == password) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AdminHomeView()));
                    } else {
                      MessageService.displaySnackbar(
                          "invalid email or password", context);
                    }
                  }
                },
                child: const Text('SignIn'))
          ],
        ),
      ),
    );
  }
}
