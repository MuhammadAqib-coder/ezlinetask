import 'package:eziline_task/components/custom_textfield.dart';
import 'package:eziline_task/services/firebase_services.dart';
import 'package:eziline_task/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var passControler = TextEditingController();
  var addControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: emailControler, labelText: 'Email'),
            CustomTextField(controller: phoneControler, labelText: 'phone'),
            CustomTextField(
              controller: passControler,
              labelText: 'password',
            ),
            CustomTextField(
              labelText: 'Address',
              controller: addControler,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseServices.userSignup(emailControler.text.trim(),
                            passControler.text.trim())
                        .then((value) =>
                            MessageService.displaySnackbar(value, context))
                        .onError((error, stackTrace) =>
                            MessageService.displaySnackbar(
                                error.toString(), context));
                  }
                },
                child: const Text('SignUp'))
          ],
        ),
      ),
    );
  }
}
