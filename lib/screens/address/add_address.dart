import 'package:flutter/material.dart';
import 'package:techbox/components/app_bar.dart';
import 'package:techbox/core/constants.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedWard;

  // Dữ liệu cứng có cấu trúc phân cấp
  final Map<String, Map<String, List<String>>> _addressData = {
    'Hà Nội': {
      'Quận Ba Đình': ['Phường Phúc Xá', 'Phường Trúc Bạch', 'Phường Vĩnh Phúc'],
      'Quận Hoàn Kiếm': ['Phường Hàng Bạc', 'Phường Hàng Bồ', 'Phường Hàng Buồm'],
      'Quận Đống Đa': ['Phường Cát Linh', 'Phường Văn Miếu', 'Phường Quốc Tử Giám'],
    },
    'Hồ Chí Minh': {
      'Quận 1': ['Phường Bến Nghé', 'Phường Bến Thành', 'Phường Cầu Kho'],
      'Quận 3': ['Phường 1', 'Phường 2', 'Phường 3'],
      'Quận Bình Thạnh': ['Phường 1', 'Phường 2', 'Phường 3'],
    },
    'Đà Nẵng': {
      'Quận Hải Châu': ['Phường Hải Châu I', 'Phường Hải Châu II', 'Phường Bình Hiên'],
      'Quận Thanh Khê': ['Phường Thanh Khê Đông', 'Phường Thanh Khê Tây', 'Phường Tam Thuận'],
      'Quận Sơn Trà': ['Phường Thọ Quang', 'Phường Nại Hiên Đông', 'Phường Mân Thái'],
    },
  };

  // Lấy danh sách tỉnh/thành phố
  List<String> get _provinces => _addressData.keys.toList();

  // Lấy danh sách quận/huyện theo tỉnh được chọn
  List<String> get _districts {
    if (_selectedProvince == null) return [];
    return _addressData[_selectedProvince]?.keys.toList() ?? [];
  }

  // Lấy danh sách phường/xã theo quận được chọn
  List<String> get _wards {
    if (_selectedProvince == null || _selectedDistrict == null) return [];
    return _addressData[_selectedProvince]?[_selectedDistrict] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(title: 'Thêm địa chỉ', showBottomBorder: false,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Họ và tên
                    _buildSectionTitle('Họ và tên'),
                    const SizedBox(height: 4),
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Vui lòng nhập tên',
                      labelText: 'Họ và tên',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
          
                    // Số điện thoại
                    _buildSectionTitle('Số điện thoại'),
                    const SizedBox(height: 4),
                    _buildPhoneField(),
                    const SizedBox(height: 16),
          
                    // Tỉnh/Thành phố
                    _buildSectionTitle('Tỉnh/Thành phố'),
                    const SizedBox(height: 4),
                    _buildDropdown(
                      value: _selectedProvince,
                      hint: 'Chọn Tỉnh/Thành phố',
                      items: _provinces,
                      onChanged: (value) {
                        setState(() {
                          _selectedProvince = value;
                          _selectedDistrict = null; // Reset quận khi đổi tỉnh
                          _selectedWard = null; // Reset phường khi đổi tỉnh
                        });
                      },
                    ),
                    const SizedBox(height: 16),
          
                    // Quận/Huyện
                    _buildSectionTitle('Quận/Huyện'),
                    const SizedBox(height: 4),
                    _buildDropdown(
                      value: _selectedDistrict,
                      hint: 'Chọn Quận/Huyện',
                      items: _districts,
                      onChanged: _selectedProvince == null ? null : (value) {
                        setState(() {
                          _selectedDistrict = value;
                          _selectedWard = null; // Reset phường khi đổi quận
                        });
                      },
                    ),
                    const SizedBox(height: 16),
          
                    // Phường/Xã
                    _buildSectionTitle('Phường/Xã'),
                    const SizedBox(height: 4),
                    _buildDropdown(
                      value: _selectedWard,
                      hint: 'Chọn Phường/Xã',
                      items: _wards,
                      onChanged: _selectedDistrict == null ? null : (value) {
                        setState(() {
                          _selectedWard = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
          
                    // Số nhà/Tên đường
                    _buildSectionTitle('Số nhà/Tên đường'),
                    const SizedBox(height: 4),
                    _buildTextField(
                      controller: _addressController,
                      hintText: 'Nhập số nhà, tên đường',
                      labelText: 'Số nhà/Tên đường',
                      keyboardType: TextInputType.streetAddress,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
          
              // Map section
              Container(
                height: 145,
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      // Placeholder for map
                      Container(
                        color: Colors.blue[50],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Bản đồ vị trí',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Location pin
                      const Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: 358,
            height: 54,
            child: ElevatedButton(
              onPressed: _addAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantsColor.colorMain,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Thêm địa chỉ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: 358,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 230, 230, 230),
          width: 1,
        ),
      ),
      child: Container(
        width: 301,
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
  return Container(
    width: 358,
    height: 52,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color.fromARGB(255, 230, 230, 230),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Image(
            image: AssetImage('assets/image/vn_circle.png'),
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Vui lòng nhập số điện thoại',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      width: 358,
      height: 52,
      decoration: BoxDecoration(
        color: onChanged == null ? Colors.white : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 230, 230, 230),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 205, 205, 205),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  void _addAddress() {
    // Validate form
    if (_nameController.text.isEmpty) {
      _showSnackBar('Vui lòng nhập họ và tên');
      return;
    }
    if (_phoneController.text.isEmpty) {
      _showSnackBar('Vui lòng nhập số điện thoại');
      return;
    }
    if (_selectedProvince == null) {
      _showSnackBar('Vui lòng chọn tỉnh/thành phố');
      return;
    }
    if (_selectedDistrict == null) {
      _showSnackBar('Vui lòng chọn quận/huyện');
      return;
    }
    if (_selectedWard == null) {
      _showSnackBar('Vui lòng chọn phường/xã');
      return;
    }
    if (_addressController.text.isEmpty) {
      _showSnackBar('Vui lòng nhập số nhà, tên đường');
      return;
    }

    // In ra địa chỉ đầy đủ để test
    String fullAddress = '${_addressController.text}, $_selectedWard, $_selectedDistrict, $_selectedProvince';
    print('Địa chỉ đầy đủ: $fullAddress');
    
    _showSnackBar('Thêm địa chỉ thành công!');
    Navigator.pop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 12, 20, 21),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}