import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/models/product.dart';
import 'package:mxanh_flutter/widgets/green_store_section.dart';

class RedeemPointsPage extends StatefulWidget {
  final int currentPoints;
  final List<Product> products;

  const RedeemPointsPage({
    Key? key,
    required this.currentPoints,
    required this.products,
  }) : super(key: key);

  @override
  State<RedeemPointsPage> createState() => _RedeemPointsPageState();
}

class _RedeemPointsPageState extends State<RedeemPointsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _pointsToRedeem = 0;
  static const int exchangeRate = 100; // 1 điểm = 100 đ

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onRedeemMoney() {
    if (_pointsToRedeem <= 0) return;
    if (_pointsToRedeem > widget.currentPoints) {
      _showDialog('Lỗi', 'Bạn không đủ điểm.');
      return;
    }

    int amount = _pointsToRedeem * exchangeRate;

    _showDialog('Thành công', 'Bạn đã đổi $_pointsToRedeem điểm thành $amount VNĐ.');
    setState(() {
      _pointsToRedeem = 0;
    });
  }

  void _onProductTap(Product product) {
    double price = double.tryParse(product.price.replaceAll(',', '')) ?? 0;
    double discountedPrice = price * 0.9;
    int requiredPoints = (discountedPrice / exchangeRate).ceil();

    if (requiredPoints > widget.currentPoints) {
      _showDialog('Lỗi', 'Bạn không đủ điểm để đổi sản phẩm này.\nCần $requiredPoints điểm.');
      return;
    }

    _showDialog(
      'Đổi thành công',
      'Bạn đã dùng $requiredPoints điểm để đổi sản phẩm: ${product.name} (giá giảm 10%).',
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text('Đổi điểm mxanh', style: AppTextStyles.heading3.copyWith(color: Colors.white)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Đổi sang tiền'),
            Tab(text: 'Đổi sang vật phẩm'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRedeemMoneyTab(),
          _buildRedeemProductTab(),
        ],
      ),
    );
  }

  Widget _buildRedeemMoneyTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Điểm mxanh hiện có:', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 4),
          Text(
            '${widget.currentPoints} điểm',
            style: AppTextStyles.heading2.copyWith(color: AppColor.primary),
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Số điểm muốn đổi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _pointsToRedeem = int.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(height: 16),
          if (_pointsToRedeem > 0)
            Text(
              'Bạn sẽ nhận được: ${_pointsToRedeem * exchangeRate} VNĐ',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColor.primary),
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onRedeemMoney,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Xác nhận đổi điểm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemProductTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];

        double price = double.tryParse(product.price.replaceAll(',', '')) ?? 0;
        double discountedPrice = price * 0.9;
        int requiredPoints = (discountedPrice / exchangeRate).ceil();

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.image),
            ),
            title: Text(product.name),
            subtitle: Text('Cần $requiredPoints điểm'),
            trailing: ElevatedButton(
              onPressed: () => _onProductTap(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
              ),
              child: const Text(
                'Đổi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
