import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../widget/auth_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Create account ✨",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Let’s set up your account in just a few steps",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 28),
                authField(
                  label: "Name",
                  controller: nameCtrl,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                authField(
                  label: "Email",
                  controller: emailCtrl,
                  icon: Icons.mail_outline,
                ),
                const SizedBox(height: 16),
                authField(
                  label: "Password",
                  controller: passCtrl,
                  icon: Icons.lock_outline,
                  obscure: hidePassword,
                  suffix: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => hidePassword = !hidePassword),
                  ),
                ),
                const SizedBox(height: 16),
                authField(
                  label: "Confirm Password",
                  controller: confirmCtrl,
                  icon: Icons.lock_outline,
                  obscure: hideConfirm,
                  suffix: IconButton(
                    icon: Icon(
                      hideConfirm
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () =>
                        setState(() => hideConfirm = !hideConfirm),
                  ),
                ),
                if (confirmCtrl.text.isNotEmpty &&
                    confirmCtrl.text != passCtrl.text)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Passwords do not match",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (auth.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      auth.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    onPressed: auth.isLoading
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        if (passCtrl.text != confirmCtrl.text) return;

                        final success = await auth.register(
                          nameCtrl.text,
                          emailCtrl.text,
                          passCtrl.text,
                        );

                        if (success && context.mounted) {
                          Navigator.pop(context); // Back to Login
                        }
                      }
                    },
                    child: auth.isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                        : const Text(
                      "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
