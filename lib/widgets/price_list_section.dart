import 'package:flutter/material.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/models/material_item.dart';

class PriceListSection extends StatelessWidget {
  final List<MaterialItem> materials;
  final Function(MaterialItem) onItemTap;
  final VoidCallback onViewAll;
  final bool showAll;

  const PriceListSection({
    Key? key,
    required this.materials,
    required this.onItemTap,
    required this.onViewAll,
    this.showAll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bảng giá phế liệu", style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: showAll ? materials.length : 6,
            itemBuilder: (context, index) {
              if (index < materials.length) {
                final item = materials[index];
                return GestureDetector(
                  onTap: () => onItemTap(item),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.recycling,
                          size: 24,
                          color: AppColor.primary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.name,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${item.price} ${item.unit}",
                          style: AppTextStyles.caption,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColor.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}