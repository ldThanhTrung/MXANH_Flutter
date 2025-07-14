import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  int selectedIndex = 0;
  List<String> addresses = [
    'Số 1, đường A, phường B, TP.HCM',
    'Số 2, đường C, phường D, TP.HCM',
  ];

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
          'Địa chỉ',
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400, // for web/desktop, will fill on mobile
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4, color: AppColor.background),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          itemCount: addresses.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColor.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Selected indicator
                                  Container(
                                    width: 6,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: index == selectedIndex ? AppColor.primary : Colors.transparent,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Address text
                                  Expanded(
                                    child: Text(
                                      addresses[index],
                                      style: TextStyle(fontSize: 16, color: AppColor.textPrimary),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 20, color: AppColor.textSecondary),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline, size: 20, color: AppColor.textSecondary),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 