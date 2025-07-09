import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/avatar_placeholder.png'), // Replace with your asset or NetworkImage
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nguyen van A',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.textPrimary),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Thay đổi thông tin cá nhân',
                            style: TextStyle(color: AppColor.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: AppColor.textSecondary),
                  ],
                ),
              ),
            ),
            // Ưu đãi
            sectionTitle('Ưu đãi'),
            sectionCard([
              ListTile(
                title: Text('Điểm tích lũy', style: TextStyle(color: AppColor.textPrimary)),
                subtitle: Text('xxx.xxx điểm', style: TextStyle(color: AppColor.textSecondary)),
                trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ]),
            // Quản lý ví
            sectionTitle('Quản lý ví'),
            sectionCard([
              ListTile(
                title: Row(
                  children: [
                    Text('Số dư hiện có', style: TextStyle(color: AppColor.textPrimary)),
                    SizedBox(width: 8),
                    Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColor.textSecondary),
                  ],
                ),
                subtitle: Text('xxx.xxx.xxx đồng', style: TextStyle(color: AppColor.textSecondary)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              Divider(height: 1),
              ListTile(
                title: Text('Rút tiền về tài khoản', style: TextStyle(color: AppColor.textPrimary)),
                trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ]),
            // Cài đặt & điều khoản
            sectionTitle('Cài đặt & điều khoản'),
            sectionCard([
              ListTile(
                title: Text('Cài đặt', style: TextStyle(color: AppColor.textPrimary)),
                trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              Divider(height: 1),
              ListTile(
                title: Text('Điều khoản', style: TextStyle(color: AppColor.textPrimary)),
                trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              Divider(height: 1),
              ListTile(
                title: Text('Liên hệ', style: TextStyle(color: AppColor.textPrimary)),
                trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
                onTap: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ]),
            // Đăng xuất
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.logout, color: AppColor.error),
                  label: Text('Đăng xuất', style: TextStyle(color: AppColor.error, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Mxanh phiên bản xx.xx',
                style: TextStyle(color: AppColor.textSecondary),
              ),
            ),
          ],
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
} 