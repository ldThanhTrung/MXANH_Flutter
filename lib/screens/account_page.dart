import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/screens/account_details_page.dart';
import 'package:mxanh_flutter/screens/welcome_page.dart'; // Import màn WelcomePage

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AccountDetailsPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage(
                            'assets/avatar_placeholder.png',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nguyen van A',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColor.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Thay đổi thông tin cá nhân',
                                style: TextStyle(
                                  color: AppColor.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: AppColor.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Ưu đãi
              sectionTitle('Ưu đãi'),
              sectionCard([
                ListTile(
                  title: Text(
                    'Điểm tích lũy',
                    style: TextStyle(color: AppColor.textPrimary),
                  ),
                  subtitle: Text(
                    'xxx.xxx điểm',
                    style: TextStyle(color: AppColor.textSecondary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColor.textSecondary,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ]),

              // Quản lý ví
              sectionTitle('Quản lý ví'),
              sectionCard([
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Số dư hiện có',
                        style: TextStyle(color: AppColor.textPrimary),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 18,
                        color: AppColor.textSecondary,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'xxx.xxx.xxx đồng',
                    style: TextStyle(color: AppColor.textSecondary),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    'Rút tiền về tài khoản',
                    style: TextStyle(color: AppColor.textPrimary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColor.textSecondary,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ]),

              // Cài đặt & điều khoản
              sectionTitle('Cài đặt & điều khoản'),
              sectionCard([
                ListTile(
                  title: Text(
                    'Cài đặt',
                    style: TextStyle(color: AppColor.textPrimary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColor.textSecondary,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    'Điều khoản',
                    style: TextStyle(color: AppColor.textPrimary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColor.textSecondary,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    'Liên hệ',
                    style: TextStyle(color: AppColor.textPrimary),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: AppColor.textSecondary,
                  ),
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ]),

              // Đăng xuất
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                    icon: Icon(Icons.logout, color: AppColor.error),
                    label: Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: AppColor.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Mxanh phiên bản xx.xx',
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget sectionCard(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }

  /// Hàm hiển thị dialog xác nhận đăng xuất
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Đăng xuất',
            style: TextStyle( fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Bạn có thật sự muốn đăng xuất ?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (route) => false,
                );
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
