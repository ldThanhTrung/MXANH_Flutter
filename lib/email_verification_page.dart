import 'package:flutter/material.dart';
import 'login.dart'; // Import trang login của bạn (thay đổi tùy theo tên file)

class EmailVerificationPage extends StatelessWidget {
  final String email;

  const EmailVerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xác minh Email')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Một email xác nhận đã được gửi đến:\n\n$email\n\nVui lòng kiểm tra hộp thư của bạn.',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('Quay về trang đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
