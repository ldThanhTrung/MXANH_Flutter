import 'package:mxanh_flutter/models/user.dart';
import 'package:mxanh_flutter/models/material_item.dart';
import 'package:mxanh_flutter/models/product.dart';
import 'package:mxanh_flutter/models/event.dart';

class DataService {
  static User getCurrentUser() {
    return User(
      name: "VI MXANH",
      phoneNumber: "xxx.xxx.xxx VND",
      balance: "xxx.xxx điểm",
      points: 2500,
      avatar: "assets/avatar.png",
    );
  }

  static List<MaterialItem> getMaterialPriceList() {
    return [
      MaterialItem(name: "Chai nhựa", price: "2,500", unit: "VNĐ/kg"),
      MaterialItem(name: "Giấy báo", price: "1,200", unit: "VNĐ/kg"),
      MaterialItem(name: "Sắt phế liệu", price: "8,000", unit: "VNĐ/kg"),
      MaterialItem(name: "Thùng carton", price: "1,800", unit: "VNĐ/kg"),
    ];
  }

  static List<Product> getGreenProducts() {
    return [
      Product(
        name: "Túi vải organic",
        price: "45,000",
        image: "assets/bag.png",
        tag: "Mới",
      ),
      Product(
        name: "Ống hút tre",
        price: "25,000",
        image: "assets/straw.png",
        tag: "Đổi điểm",
      ),
      Product(
        name: "Ly gỗ thủ công",
        price: "80,000",
        image: "assets/cup.png",
        tag: "Mới",
      ),
    ];
  }

  static Event getCurrentEvent() {
    return Event(
      title: 'SỰ KIỆN "ĐỔI RÁC\nLẤY QUÀ"',
      description: "Đổi rác lấy quà hấp dẫn",
      startDate: "19/4/2025",
      endDate: "20/4/2025",
    );
  }
}
