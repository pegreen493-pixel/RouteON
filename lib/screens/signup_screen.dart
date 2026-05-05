import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import '../main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _receiveUpdates = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildGradientBorderTextField({
    required String hintText,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF3131), Color(0xFFFF914D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.all(2), // Border width
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularCheckbox(String text, bool value, ValueChanged<bool?> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(
              value ? Icons.check_circle : Icons.radio_button_unchecked,
              color: const Color(0xFFFF3131),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Color(0xFFFF3131), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const Icon(Icons.menu),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.star, size: 28),
                  const SizedBox(width: 4),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                      children: [
                        TextSpan(
                          text: 'Create your ',
                          style: TextStyle(color: Color(0xFFFF3131)),
                        ),
                        TextSpan(
                          text: 'Account',
                          style: TextStyle(color: Color(0xFFFF914D)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Please Provide your information',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Form Fields
              _buildGradientBorderTextField(hintText: 'First name'),
              _buildGradientBorderTextField(hintText: 'Last name'),
              _buildGradientBorderTextField(
                hintText: 'Email',
                controller: _emailController,
              ),
              _buildGradientBorderTextField(
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
                obscureText: _obscurePassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              _buildGradientBorderTextField(
                hintText: 'Confirm password',
                isPassword: true,
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              _buildGradientBorderTextField(hintText: 'Phone number'),

              const SizedBox(height: 12),

              // Agreement
              _buildCircularCheckbox('Agree to terms and services.', _agreeTerms, (v) {
                setState(() => _agreeTerms = v ?? false);
              }),
              _buildCircularCheckbox('Receive updates and mails.', _receiveUpdates, (v) {
                setState(() => _receiveUpdates = v ?? false);
              }),

              const SizedBox(height: 24),

              // Sign Up Button
              GestureDetector(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainLayout()),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Registration failed')),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF3131), Color(0xFFFF914D)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Social Login
              const Text('Or sign up with', style: TextStyle(color: Colors.black87, fontSize: 13)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.g_mobiledata, Colors.blue),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.facebook, Colors.blue[700]!),
                  const SizedBox(width: 16),
                  _buildSocialIcon(Icons.camera_alt_outlined, Colors.pink),
                ],
              ),

              const SizedBox(height: 32),

              // Footer
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                    children: [
                      TextSpan(text: 'Already have an account? '),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(color: Color(0xFFFF914D), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              const Text(
                '* Have problems with login in or signing up? contact support\n* Want to know more about us? Click here!',
                style: TextStyle(fontSize: 10, color: Colors.grey),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, color: color),
    );
  }
}
