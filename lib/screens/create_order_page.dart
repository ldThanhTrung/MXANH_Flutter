import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mxanh_flutter/themes/app_color.dart';
import 'package:mxanh_flutter/themes/text_styles.dart';
import 'package:mxanh_flutter/models/material_item.dart';
import 'package:mxanh_flutter/screens/order_details_page.dart';

class CreateOrderPage extends StatefulWidget {
  final List<MaterialItem> materials;

  const CreateOrderPage({
    Key? key,
    required this.materials,
  }) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final Map<String, double> selectedMaterials = {};
  final Map<String, TextEditingController> weightControllers = {};
  final _formKey = GlobalKey<FormState>();
  String address = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    for (var controller in weightControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectMaterial(MaterialItem material) {
    setState(() {
      if (selectedMaterials.containsKey(material.name)) {
        // Nếu đã chọn thì bỏ chọn
        selectedMaterials.remove(material.name);
        weightControllers[material.name]?.dispose();
        weightControllers.remove(material.name);
      } else {
        // Nếu chưa chọn thì thêm vào
        selectedMaterials[material.name] = 0.0;
        weightControllers[material.name] = TextEditingController();
        weightControllers[material.name]!.addListener(() {
          _updateWeight(material.name);
        });
      }
    });
  }

  void _updateWeight(String materialName) {
    final controller = weightControllers[materialName];
    if (controller != null) {
      final weight = double.tryParse(controller.text) ?? 0.0;
      setState(() {
        selectedMaterials[materialName] = weight;
      });
    }
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    for (var entry in selectedMaterials.entries) {
      final material = widget.materials.firstWhere((m) => m.name == entry.key);
      // Chuyển đổi price string thành number (loại bỏ dấu phẩy)
      final priceString = material.price.replaceAll(',', '');
      final price = double.tryParse(priceString) ?? 0.0;
      total += price * entry.value;
    }
    return total;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _createOrder() {
    if (_formKey.currentState!.validate()) {
      if (selectedMaterials.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn ít nhất một vật liệu')),
        );
        return;
      }

      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng chọn ngày và giờ thu gom')),
        );
        return;
      }

      // Generate order ID
      final orderId = 'MX${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

      // Navigate to order details page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailsPage(
            selectedMaterials: selectedMaterials,
            materials: widget.materials,
            address: address,
            selectedDate: selectedDate!,
            selectedTime: selectedTime!,
            orderId: orderId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tạo đơn',
          style: AppTextStyles.heading3.copyWith(color: AppColor.textPrimary),
        ),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              
              // Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tạo Đơn Thu Gom',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Chọn loại vật liệu',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Material Selection Grid
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: widget.materials.length,
                  itemBuilder: (context, index) {
                    final material = widget.materials[index];
                    final isSelected = selectedMaterials.containsKey(material.name);
                    
                    return GestureDetector(
                      onTap: () => _selectMaterial(material),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary.withOpacity(0.1) : AppColor.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColor.primary : Colors.transparent,
                            width: 2,
                          ),
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
                            Icon(
                              Icons.recycling,
                              size: 24,
                              color: isSelected ? AppColor.primary : AppColor.textSecondary,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              material.name,
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.w500,
                                color: isSelected ? AppColor.primary : AppColor.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${material.price} ${material.unit}",
                              style: AppTextStyles.caption.copyWith(
                                color: AppColor.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Weight Input Section
              if (selectedMaterials.isNotEmpty) ...[
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nhập khối lượng (kg)',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...selectedMaterials.entries.map((entry) {
                        final material = widget.materials.firstWhere((m) => m.name == entry.key);
                        // Chuyển đổi price string thành number
                        final priceString = material.price.replaceAll(',', '');
                        final price = double.tryParse(priceString) ?? 0.0;
                        final totalPrice = price * entry.value;
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  material.name,
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: weightControllers[entry.key],
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                  ],
                                  decoration: InputDecoration(
                                    suffixText: 'kg',
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nhập khối lượng';
                                    }
                                    final weight = double.tryParse(value);
                                    if (weight == null || weight <= 0) {
                                      return 'Khối lượng phải > 0';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${totalPrice.toStringAsFixed(0)}đ',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng cộng:',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_calculateTotalPrice().toStringAsFixed(0)}đ',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Address Input
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      onChanged: (value) => address = value,
                      decoration: InputDecoration(
                        hintText: 'Số 1, đường A, phường B, TP.HCM',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập địa chỉ';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Date and Time Selection
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thời gian',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _selectDate,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate != null 
                                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                        : 'Chọn ngày',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: selectedDate != null 
                                          ? AppColor.textPrimary 
                                          : AppColor.textSecondary,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: _selectTime,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedTime != null 
                                        ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                                        : 'Chọn giờ',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: selectedTime != null 
                                          ? AppColor.textPrimary 
                                          : AppColor.textSecondary,
                                    ),
                                  ),
                                  const Icon(Icons.access_time, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Create Order Button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: _createOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Tạo đơn',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}