
import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _cfmpwdcontroller = TextEditingController();

  Future<void> register(BuildContext context) async {
    final _auth = AuthService();
    final email = _emailcontroller.text.trim();
    final mobile = _mobilecontroller.text.trim();
    final pwd = _pwdcontroller.text;
    final confirm = _cfmpwdcontroller.text;

    if (email.isEmpty || mobile.isEmpty || pwd.isEmpty || confirm.isEmpty) {
      showDialog(
        context: context,
        builder: (_) =>
            const AlertDialog(title: Text("Please fill all fields.")),
      );
      return;
    }

    if (pwd != confirm) {
      showDialog(
        context: context,
        builder: (_) =>
            const AlertDialog(title: Text("Passwords don't match!")),
      );
      return;
    }

    try {
      final cred = await _auth.signUpWithEmailPassword(email, pwd);
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Registration failed"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4460F7), Color(0xFF8338EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                children: [
                  Icon(
                    Icons.message,
                    size: 80,
                    color: theme.colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Create Account",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join us and start chatting!",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Glass-card form container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        MyTextField(
                          hintText: "Email",
                          obscureText: false,
                          controller: _emailcontroller,
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          hintText: "Mobile Number",
                          obscureText: false,
                          controller: _mobilecontroller,
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          hintText: "Password",
                          obscureText: true,
                          controller: _pwdcontroller,
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          hintText: "Confirm Password",
                          obscureText: true,
                          controller: _cfmpwdcontroller,
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 24),
                        MyButton(
                          text: "Register",
                          onTap: () => register(context),
                          weight: FontWeight.bold,
                          // you can pass style props here if MyButton supports it
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Login now",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
