import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_page.dart';
import 'signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final UsernameController = TextEditingController();
  final passwordController = TextEditingController();

bool isLoading = false;

Future<void> handleLogin(BuildContext context) async {
  String username = UsernameController.text.trim();
  String password = passwordController.text.trim();

  // Kiểm tra rỗng
  if (username.isEmpty || password.isEmpty) {
    showMessage(context, 'Vui lòng nhập đầy đủ email và mật khẩu');
    return;
  }

  // Kiểm tra định dạng email
  if (!isValidInput(username)) {
  showMessage(context, 'Vui lòng nhập email hoặc username hợp lệ');
  return; 
}


  // Bắt đầu loading
  isLoading = true;

  try {
    final url = Uri.parse("https://10.0.2.2:7123/api/Auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];


      // ✅ Chuyển trang nếu thành công
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserPage(token: token, email: username,),
        ),
      );
    } else {
      showMessage(context, "Đăng nhập thất bại: ${data['message'] ?? 'Sai email hoặc mật khẩu'}");
    }
  } catch (e) {
    showMessage(context, "Lỗi kết nối đến server: $e");
  } finally {
    isLoading = false;
  }
}

// Hàm kiểm tra định dạng email
bool isValidInput(String input) {
  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  final usernameRegex = RegExp(r"^[a-zA-Z0-9._-]{3,}$"); // username từ 3 ký tự trở lên
  return emailRegex.hasMatch(input) || usernameRegex.hasMatch(input);
}

// Hàm hiển thị snackbar
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, \nWelcome Back",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.google, size: 50, color: Colors.red)
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: UsernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!isLoading) {
                        handleLogin(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage()));
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
