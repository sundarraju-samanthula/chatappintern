import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _cfmpwdcontroller = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  void register(BuildContext context) async {
    final _auth = AuthService();
    final email = _emailcontroller.text.trim();
    final pwd = _pwdcontroller.text;
    final confirm = _cfmpwdcontroller.text;

    if (email.isEmpty || pwd.isEmpty || confirm.isEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Please fill all fields.")),
      );
      return;
    }

    if (pwd != confirm) {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Passwords don't match!")),
      );
      return;
    }

    try {
      final cred = await _auth.signUpWithEmailPassword(email, pwd);
      // Registration successful — maybe navigate:
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Registration failed"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  // Future<void> register(BuildContext context) async {
  //   // get auth service
  //   final _auth = AuthService();

  //   // passwords match -> create user
  //   if (_pwdcontroller.text == _cfmpwdcontroller.text) {
  //     try { final cred = await _auth.signUpWithEmailPassword(
  //         _emailcontroller.text,
  //         _pwdcontroller.text,
  //       );

  //     } catch (e) {
  //       showDialog(
  //         context: context,
  //         builder: (context) =>
  //             AlertDialog(title: Text(e.toString())), // AlertDialog
  //       );
  //     }
  //   }
  //   // passwords dont match -> tell user to fix
  //   else {
  //     showDialog(
  //       context: context,
  //       builder: (context) => const AlertDialog(
  //         title: Text("Passwords don't match!"),
  //       ), // AlertDialog
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ), // Icon
            SizedBox(height: 50),

            // welcome back message
            Text(
              "lets create an account for you ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            // email textfield
            MyTextField(
              hintText: "email",
              obscureText: false,
              controller: _emailcontroller,
            ),
            const SizedBox(height: 10),
            // pw textfield
            MyTextField(
              hintText: "passwprd",
              obscureText: true,
              controller: _pwdcontroller,
            ),
            SizedBox(height: 10),
            MyTextField(
              hintText: "cocnfirm password",
              obscureText: true,
              controller: _cfmpwdcontroller,
            ),

            //login button
            MyButton(text: "register", onTap: () => register(context)),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already have an account",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // register now
          ],
        ), // Column
      ), // Center
    );
  }
}
