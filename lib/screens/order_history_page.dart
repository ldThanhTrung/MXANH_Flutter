import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/screens/history_details_page.dart';
import 'package:mxanh_flutter/models/material_item.dart';
import 'package:mxanh_flutter/screens/home_page.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderHistory;

  const OrderHistoryPage({super.key, required this.orderHistory});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goBackToHome(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 0,
          title: Text(
            'Lịch sử đơn hàng',
            style: AppTextStyles.heading3.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _goBackToHome(context),
          ),
        ),
        body: orderHistory.isEmpty
            ? Center(
                child: Text(
                  'Chưa có đơn hàng nào.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  final selectedMaterials =
                      order['selectedMaterials'] as Map<String, double>;
                  final address = order['address'] as String;
                  final date = order['date'] as DateTime;
                  final time = order['time'] as TimeOfDay;
                  final orderId = order['orderId'] as String;
                  final materials = order['materials'] as List<MaterialItem>;

                  final status = order['status'] as String? ?? 'Đang xử lý';
                  final collectorName = order['collectorName'] as String? ?? 'Không rõ';
                  final collectorPhone = order['collectorPhone'] as String? ?? 'Không rõ';
                  final completedDate = order['completedDate'] as DateTime? ?? DateTime.now();

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HistoryDetailsPage(
                            selectedMaterials: selectedMaterials,
                            materials: materials,
                            address: address,
                            selectedDate: date,
                            selectedTime: time,
                            orderId: orderId,
                            status: status,
                            collectorName: collectorName,
                            collectorPhone: collectorPhone,
                            completedDate: completedDate,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mã đơn: $orderId',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: AppColor.primary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  address,
                                  style: AppTextStyles.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 16,
                                color: AppColor.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${date.day}/${date.month}/${date.year} lúc ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${selectedMaterials.length} loại vật liệu',
                                style: AppTextStyles.caption,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _goBackToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }
}
