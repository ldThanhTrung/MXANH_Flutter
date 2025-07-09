import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'email_verification_page.dart'; // trang xác thực email

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> handleSignup() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if ([username, email, phone, password, confirmPassword].any((e) => e.isEmpty)) {
      showMessage('Vui lòng nhập đầy đủ thông tin');
      return;
    }

    if (!isValidEmail(email)) {
      showMessage('Email không hợp lệ');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Mật khẩu không khớp');
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse("https://10.0.2.2:7123/api/Users");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "phoneNumber": phone,
          "password": password,
          "dob": "2025-06-06",
          "gender": 0,
          "name": "trieu"
        }),
      );

     // final data = jsonDecode(response.body);

      if (response.statusCode == 200 ) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmailVerificationPage(email: email),
          ),
        );
      } else {
        showMessage("Đăng ký thất bại: ${['message'] ?? 'Lỗi không xác định'}");
      }
    } catch (e) {
      showMessage("Lỗi kết nối: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username', border: InputBorder.none, labelStyle: TextStyle(color: Colors.black)),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', border: InputBorder.none, labelStyle: TextStyle(color: Colors.black)),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Số điện thoại', border: InputBorder.none, labelStyle: TextStyle(color: Colors.black)),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Mật khẩu', border: InputBorder.none, labelStyle: TextStyle(color: Colors.black)),
                obscureText: true,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu', border: InputBorder.none, labelStyle: TextStyle(color: Colors.black)),
                obscureText: true,
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : handleSignup,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
