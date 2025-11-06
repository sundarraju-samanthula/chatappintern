
import 'package:chatapp/authentication/auth.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final authService = AuthService();
    final email = _emailController.text.trim();
    final pwd = _pwdController.text;

    if (email.isEmpty || pwd.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) =>
            const AlertDialog(title: Text("Please fill all fields.")),
      );
      return;
    }

    try {
      await authService.signInWithEmailPassword(email, pwd);
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Login Failed"),
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
                  // Curved Header
                  ClipPath(
                    clipper: _TopWaveClipper(),
                    child: Container(
                      height: 150,
                      color: Colors.white.withOpacity(0.2),
                      alignment: Alignment.center,
                      child: Icon(Icons.message, size: 80, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Welcome Back",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to continue",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Glassmorphism card
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
                          controller: _emailController,
                          prefixIcon:
                              Icons.email, // add this prop in your widget
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          hintText: "Password",
                          obscureText: true,
                          controller: _pwdController,
                          prefixIcon: Icons.lock,
                        ),
                        const SizedBox(height: 24),
                        MyButton(
                          text: "Login",
                          onTap: () => login(context),
                          weight: FontWeight.bold,
                          // maybe add color or style arg
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Register now",
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

// CustomClipper for wave header
class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
