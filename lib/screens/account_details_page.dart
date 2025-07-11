import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/screens/address_list_page.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Nguyen van A');
  final TextEditingController _emailController = TextEditingController(text: 'nguyenvana@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '0123456789');
  final TextEditingController _dobController = TextEditingController();
  final String _gender = 'Nam';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Thông tin tài khoản',
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 400, // for web/desktop, otherwise will fill mobile
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  // Avatar
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: AppColor.background,
                            width: 72,
                            height: 72,
                            child: Image.asset(
                              'assets/avatar_placeholder.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 48, color: AppColor.textSecondary),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Thay đổi ảnh đại diện',
                            style: TextStyle(color: Colors.blue, fontSize: 14, decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Họ tên
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Họ tên', style: TextStyle(fontSize: 14, color: AppColor.textPrimary)),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      //change color of hint text
                      filled: true,
                      fillColor: AppColor.background,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: AppColor.textPrimary),
                    ),
                  ),

                  SizedBox(height: 16),
                  // Email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email', style: TextStyle(fontSize: 14, color: AppColor.textPrimary)),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.background,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: AppColor.textPrimary),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Số điện thoại
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Số điện thoại', style: TextStyle(fontSize: 14, color: AppColor.textPrimary)),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _phoneController,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.textSecondary.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: AppColor.textPrimary),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Địa chỉ
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Địa chỉ', style: TextStyle(fontSize: 14, color: AppColor.textPrimary)),
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressListPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('erthesrheryhe', style: TextStyle(color: AppColor.textPrimary)),
                          Icon(Icons.chevron_right, color: AppColor.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  // Lưu thông tin button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Lưu thông tin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
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