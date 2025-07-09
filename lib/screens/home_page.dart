import 'package:flutter/material.dart';
import 'package:mxanh_flutter/custom_app_bar.dart';
import 'package:mxanh_flutter/event_banner.dart';
import 'package:mxanh_flutter/quick_order_section.dart';
import 'package:mxanh_flutter/price_list_section.dart';
import 'package:mxanh_flutter/green_store_section.dart';
import 'package:mxanh_flutter/custom_bottom_navigation.dart';
import 'package:mxanh_flutter/data_service.dart';
import 'package:mxanh_flutter/user.dart';
import 'package:mxanh_flutter/material_item.dart';
import 'package:mxanh_flutter/product.dart';
import 'package:mxanh_flutter/event.dart';
import 'package:mxanh_flutter/themes/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBalanceVisible = true;
  int _selectedIndex = 0;

  late User _currentUser;
  late List<MaterialItem> _materials;
  late List<Product> _products;
  late Event _currentEvent;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _currentUser = DataService.getCurrentUser();
    _materials = DataService.getMaterialPriceList();
    _products = DataService.getGreenProducts();
    _currentEvent = DataService.getCurrentEvent();
  }

  void _onBalanceToggle() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  void _onPointsPressed() {
    // Navigate to points history page
    print("Navigate to points history");
  }

  void _onCreateOrder() {
    // Navigate to create order page
    print("Navigate to create order");
  }

  void _onMaterialTap(MaterialItem item) {
    // Navigate to material detail page
    print("Navigate to material detail: ${item.name}");
  }

  void _onProductTap(Product product) {
    // Navigate to product detail page
    print("Navigate to product detail: ${product.name}");
  }

  void _onViewAllProducts() {
    // Navigate to full store page
    print("Navigate to full store");
  }

  void _onEventTap() {
    // Navigate to event detail page
    print("Navigate to event detail");
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Price list
        print("Navigate to price list");
        break;
      case 2:
        // Create order
        _onCreateOrder();
        break;
      case 3:
        // History
        print("Navigate to history");
        break;
      case 4:
        // Account
        print("Navigate to account");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        user: _currentUser,
        isBalanceVisible: _isBalanceVisible,
        onBalanceToggle: _onBalanceToggle,
        onPointsPressed: _onPointsPressed,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            EventBanner(
              event: _currentEvent,
              onTap: _onEventTap,
            ),
            const SizedBox(height: 20),
            QuickOrderSection(
              onCreateOrder: _onCreateOrder,
            ),
            const SizedBox(height: 20),
            PriceListSection(
              materials: _materials,
              onItemTap: _onMaterialTap,
            ),
            const SizedBox(height: 20),
            GreenStoreSection(
              products: _products,
              onViewAll: _onViewAllProducts,
              onProductTap: _onProductTap,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}