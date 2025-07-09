import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String token;
  final String email;

  const UserPage({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang người dùng"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Xin chào 👋"),
            const SizedBox(height: 10),
            Text(
              "Email: $email",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
