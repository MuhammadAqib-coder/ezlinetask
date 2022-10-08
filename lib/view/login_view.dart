import 'package:eziline_task/components/custom_textfield.dart';
import 'package:eziline_task/services/firebase_services.dart';
import 'package:eziline_task/services/message_service.dart';
import 'package:eziline_task/view/admin_login_view.dart';
import 'package:eziline_task/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _passControler = TextEditingController();
  var _emailControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: _emailControler, labelText: 'Email'),
            CustomTextField(
              labelText: 'password',
              controller: _passControler,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseServices.userLogin(
                            _emailControler.text.trim(),
                            _passControler.text.trim())
                        .then((value) =>
                            MessageService.displaySnackbar(value, context));
                  }
                },
                child: Text('SignIn')),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignupView()));
                    },
                    child: Text('SignUp'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Admin account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AdminLoginView()));
                    },
                    child: Text('Admin'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
