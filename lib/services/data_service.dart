import 'package:mxanh_flutter/models/user.dart';
import 'package:mxanh_flutter/models/material_item.dart';
import 'package:mxanh_flutter/models/product.dart';
import 'package:mxanh_flutter/models/event.dart';

class DataService {
  static User getCurrentUser() {
    return User(
      name: "VI MXANH",
      phoneNumber: "0123456789",
      cash: "xxx.xxx.xxx VND",
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
      MaterialItem(name: "Nghia béo", price: "2,800", unit: "VNĐ/kg"),
      MaterialItem(name: "Triệu béo", price: "4,800", unit: "VNĐ/kg"),
      MaterialItem(name: "Liêm béo", price: "5,800", unit: "VNĐ/kg"),
    ];
  }

  static List<Product> getGreenProducts() {
    return [
      Product(
        name: "Túi vải organic",
        price: "45,000",
        image: "assets/bag.png",
        tag: "Mới",
        description: "Túi vải organic được làm từ 100% cotton tự nhiên, thân thiện với môi trường. Túi có kích thước 35x40cm, có thể chứa được nhiều đồ dùng. Thiết kế đơn giản, dễ sử dụng và có thể giặt được nhiều lần. Thay thế hoàn hảo cho túi nilon, góp phần bảo vệ môi trường.",
      ),
      Product(
        name: "Ống hút tre",
        price: "25,000",
        image: "assets/straw.png",
        tag: "Đổi điểm",
        description: "Ống hút tre tự nhiên, an toàn cho sức khỏe và thân thiện với môi trường. Được làm từ tre nguyên chất, không chứa hóa chất độc hại. Ống hút có độ bền cao, có thể tái sử dụng nhiều lần. Kích thước phù hợp cho các loại đồ uống khác nhau. Sản phẩm được chứng nhận an toàn thực phẩm.",
      ),
      Product(
        name: "Ly gỗ thủ công",
        price: "80,000",
        image: "assets/cup.png",
        tag: "Mới",
        description: "Ly gỗ thủ công được chế tác từ gỗ tự nhiên, mỗi sản phẩm đều mang nét độc đáo riêng. Ly có dung tích 350ml, phù hợp cho các loại đồ uống nóng và lạnh. Bề mặt được xử lý mịn, an toàn khi sử dụng. Thiết kế tối giản, phù hợp với không gian hiện đại. Sản phẩm thân thiện với môi trường, có thể phân hủy tự nhiên.",
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
