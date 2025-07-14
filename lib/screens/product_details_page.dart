import 'package:flutter/material.dart';
import '../models/product.dart';
import '../themes/app_color.dart';
import '../themes/text_styles.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

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
          'Chi tiết sản phẩm',
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Tag
                  if (product.tag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.tag!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  
                  if (product.tag != null) const SizedBox(height: 16),
                  
                  // Product Name
                  Text(
                    product.name,
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Product Price
                  Text(
                    product.price,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Product Description
                  if (product.description != null) ...[
                    Text(
                      'Mô tả sản phẩm',
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                                         Text(
                       product.description!,
                       style: AppTextStyles.bodyLarge.copyWith(
                         color: AppColor.textSecondary,
                         height: 1.5,
                       ),
                     ),
                    const SizedBox(height: 30),
                  ],
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Đã thêm ${product.name} vào giỏ hàng'),
                                backgroundColor: AppColor.primary,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              const SizedBox(width: 8),
                                                             Text(
                                 'Thêm vào giỏ',
                                 style: AppTextStyles.bodyMedium.copyWith(
                                   color: Colors.white,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Buy now functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mua ngay ${product.name}'),
                                backgroundColor: AppColor.secondary,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColor.primary,
                            side: const BorderSide(color: AppColor.primary),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag_outlined),
                              const SizedBox(width: 8),
                                                             Text(
                                 'Mua ngay',
                                 style: AppTextStyles.bodyMedium.copyWith(
                                   color: AppColor.primary,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Additional Info Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin bổ sung',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow('Tình trạng', 'Còn hàng'),
                        _buildInfoRow('Vận chuyển', 'Miễn phí'),
                        _buildInfoRow('Bảo hành', '12 tháng'),
                        _buildInfoRow('Xuất xứ', 'Việt Nam'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
                     Text(
             label,
             style: AppTextStyles.bodySmall.copyWith(
               color: AppColor.textSecondary,
             ),
           ),
           Text(
             value,
             style: AppTextStyles.bodySmall.copyWith(
               color: AppColor.textPrimary,
               fontWeight: FontWeight.w500,
             ),
           ),
        ],
      ),
    );
  }
} 