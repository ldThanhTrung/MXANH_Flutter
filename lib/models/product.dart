class Product {
  final String name;
  final String price;
  final String image;
  final String? tag;
  final String? description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    this.tag,
    this.description,
  });
}