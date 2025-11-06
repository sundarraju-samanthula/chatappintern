import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _cfmpwdcontroller = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  void register() {}

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
            MyButton(text: "register", onTap: register),
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
