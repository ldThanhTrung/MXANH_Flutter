class MaterialItem {
  final String name;
  final String price;
  final String unit;
  final String? image;

  MaterialItem({
    required this.name,
    required this.price,
    required this.unit,
    this.image,
  });
}