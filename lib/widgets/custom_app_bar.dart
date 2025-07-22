import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/models/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final bool isBalanceVisible;
  final VoidCallback onBalanceToggle;
  final VoidCallback onPointsPressed;
  final VoidCallback onCartPressed;

  const CustomAppBar({
    super.key,
    required this.user,
    required this.isBalanceVisible,
    required this.onBalanceToggle,
    required this.onPointsPressed,
    required this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.surface,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: AppTextStyles.bodyLarge),
                      Text(user.cash, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Đổi điểm →", style: AppTextStyles.bodySmall),
                    Text(
                      isBalanceVisible ? user.balance : "xxx.xxx điểm",
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: onCartPressed,
                  icon: const Icon(Icons.shopping_cart, color: AppColor.primary),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBalanceToggle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Ví MXANH"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPointsPressed,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.primary),
                      foregroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Điểm của bạn"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
