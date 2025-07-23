import 'package:flutter/material.dart';
import 'package:mxanh_flutter/screens/redeem_points_page.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/widgets/custom_app_bar.dart';
import 'package:mxanh_flutter/widgets/event_banner.dart';
import 'package:mxanh_flutter/widgets/quick_order_section.dart';
import 'package:mxanh_flutter/widgets/price_list_section.dart';
import 'package:mxanh_flutter/widgets/green_store_section.dart';
import 'package:mxanh_flutter/widgets/custom_bottom_navigation.dart';
import 'package:mxanh_flutter/services/data_service.dart';
import 'package:mxanh_flutter/models/user.dart';
import 'package:mxanh_flutter/models/material_item.dart';
import 'package:mxanh_flutter/models/product.dart';
import 'package:mxanh_flutter/models/event.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/screens/account_page.dart';
import 'package:mxanh_flutter/screens/create_order_page.dart';
import 'package:mxanh_flutter/screens/product_details_page.dart';
import 'package:mxanh_flutter/screens/cart_page.dart';
import 'package:mxanh_flutter/screens/redeem_points_page.dart';
import 'package:mxanh_flutter/screens/order_history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  late List<Map<String, dynamic>> _orderHistory;

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
    _orderHistory = DataService.orderHistory;
  }

  void _onBalanceToggle() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  void _onPointsPressed() {
    // Navigate to points history page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => RedeemPointsPage(
              currentPoints: _currentUser.points,
              products: _products,
            ),
      ),
    );
  }

  void _onCartPressed() {
    // Navigate to cart page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  void _onCreateOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrderPage(materials: _materials),
      ),
    );
  }

  void _onMaterialTap(MaterialItem item) {
    // Navigate to material detail page
    print("Navigate to material detail: ${item.name}");
  }

  void _onProductTap(Product product) {
    // Navigate to product detail page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  void _onViewAllMeterials() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Bảng giá vật liệu",
                  style: AppTextStyles.heading3,
                ),
              ),
              body: SingleChildScrollView(
                child: PriceListSection(
                  materials: _materials,
                  onItemTap: _onMaterialTap,
                  onViewAll: () {},
                  showAll: true,
                ),
              ),
            ),
      ),
    );
  }

  void _onViewAllProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Cửa hàng xanh",
                  style: AppTextStyles.heading3,
                ),
              ),
              body: SingleChildScrollView(
                child: GreenStoreSection(
                  products: _products,
                  onViewAll: () {},
                  onProductTap: _onProductTap,
                  showAll: true,
                ),
              ),
            ),
      ),
    );
  }

  void _onEventTap() {
    // Navigate to event detail page
    print("Navigate to event detail");
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    switch (_selectedIndex) {
      case 0:
        bodyContent = SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              EventBanner(event: _currentEvent, onTap: _onEventTap),
              const SizedBox(height: 20),
              QuickOrderSection(onCreateOrder: _onCreateOrder),
              const SizedBox(height: 20),
              PriceListSection(
                materials: _materials,
                onItemTap: _onMaterialTap,
                onViewAll: _onViewAllMeterials,
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
        );
        break;
      case 1:
        bodyContent = PriceListSection(
          materials: _materials,
          onItemTap: _onMaterialTap,
          onViewAll: _onViewAllMeterials,
          showAll: true,
        );
        break;
      case 2:
        bodyContent = CreateOrderPage(materials: _materials);
        break;
      case 3:
        bodyContent = OrderHistoryPage(orderHistory: _orderHistory);
        break;
      case 4:
        bodyContent = AccountPage();
        break;
      default:
        bodyContent = Column(
          children: [
            const SizedBox(height: 20),
            EventBanner(event: _currentEvent, onTap: _onEventTap),
            const SizedBox(height: 20),
            CreateOrderPage(materials: _materials),
            const SizedBox(height: 20),
            PriceListSection(
              materials: _materials,
              onItemTap: _onMaterialTap,
              onViewAll: _onViewAllMeterials,
            ),
            const SizedBox(height: 20),
            GreenStoreSection(
              products: _products,
              onViewAll: _onViewAllProducts,
              onProductTap: _onProductTap,
            ),
            const SizedBox(height: 20),
          ],
        );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:
          _selectedIndex == 0
              ? CustomAppBar(
                user: _currentUser,
                isBalanceVisible: _isBalanceVisible,
                onBalanceToggle: _onBalanceToggle,
                onPointsPressed: _onPointsPressed,
                onCartPressed: _onCartPressed,
              )
              : null,
      body: bodyContent,
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
