import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/location/presentation/controllers/location_controller.dart';
import 'package:techbox/src/features/location/presentation/states/location_state.dart';

class UpdateAddressPage extends ConsumerStatefulWidget {
  final ProfileModel profile;
  const UpdateAddressPage({Key? key, required this.profile}) : super(key: key);

  @override
  ConsumerState<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends ConsumerState<UpdateAddressPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.profile.name;
    _phoneController.text = widget.profile.phoneNumber;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationControllerProvider.notifier).fetchProvinces();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      locationControllerProvider,
    ); // Theo dõi thay đổi state
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
        title: 'Cập nhật địa chỉ',
        showBottomBorder: false,
      ),
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
                    _buildSectionTitle('Họ và tên'),
                    const SizedBox(height: 4),
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Vui lòng nhập tên',
                      labelText: 'Họ và tên',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),

                    _buildSectionTitle('Số điện thoại'),
                    const SizedBox(height: 4),
                    _buildPhoneField(),
                    const SizedBox(height: 16),

                    _buildSectionTitle('Tỉnh/Thành phố'),
                    const SizedBox(height: 4),
                    _buildProvinceDropdown(state, ref),
                    const SizedBox(height: 16),

                    _buildSectionTitle('Quận/Huyện'),
                    const SizedBox(height: 4),
                    _buildDistrictDropdown(state, ref),
                    const SizedBox(height: 16),

                    _buildSectionTitle('Phường/Xã'),
                    const SizedBox(height: 4),
                    _buildWardDropdown(state, ref),
                    const SizedBox(height: 16),

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
              const SizedBox(height: 44),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.white)],
        ),
        child: SafeArea(
          child: SizedBox(
            width: 358,
            height: 54,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 170,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: ConstantsColor.colorMain,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Hủy',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                          color: ConstantsColor.colorMain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Container(
                    width: 170,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () => _addAddress(ref, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ConstantsColor.colorMain,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Lưu thay đổi',
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
              ],
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
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
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
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceDropdown(LocationState state, WidgetRef ref) {
    List<String>? provinceNames = [];
    if (state is LocationSuccess) {
      provinceNames = state.provinces.map((p) => p.name).toList();
      print('Province names: $provinceNames');
    } else {
      print('State is not LocationSuccess: $state');
    }
    return _buildDropdown(
      value: state is LocationSuccess ? state.selectedProvinceName : null,
      hint: 'Chọn Tỉnh/Thành phố',
      items: provinceNames ?? [],
      onChanged: (value) async {
        if (value != null && state is LocationSuccess) {
          print('Selected province: $value');
          final province = state.provinces.firstWhere(
            (p) => p.name == value,
            orElse: () => state.provinces.first,
          );
          ref
              .read(locationControllerProvider.notifier)
              .selectProvince(province.code);
          await ref
              .read(locationControllerProvider.notifier)
              .fetchDistricts(province.code);
        }
      },
    );
  }

  Widget _buildDistrictDropdown(LocationState state, WidgetRef ref) {
    List<String>? districtNames = [];
    if (state is LocationSuccess && state.districts != null) {
      districtNames = state.districts!.map((d) => d.name).toList();
      print('District names: $districtNames');
    } else {
      print('State or districts is null: $state');
    }
    return _buildDropdown(
      value: state is LocationSuccess ? state.selectedDistrictName : null,
      hint: 'Chọn Quận/Huyện',
      items: districtNames ?? [],
      onChanged:
          state is LocationSuccess && state.selectedProvinceCode != null
              ? (value) async {
                if (value != null && state.districts != null) {
                  print('Selected district: $value');
                  final district = state.districts!.firstWhere(
                    (d) => d.name == value,
                    orElse: () => state.districts!.first,
                  );
                  ref
                      .read(locationControllerProvider.notifier)
                      .selectDistrict(district.code);
                  await ref
                      .read(locationControllerProvider.notifier)
                      .fetchWards(district.code);
                }
              }
              : null,
    );
  }

  Widget _buildWardDropdown(LocationState state, WidgetRef ref) {
    List<String>? wardNames = [];
    if (state is LocationSuccess && state.wards != null) {
      wardNames = state.wards!.map((w) => w.name).toList();
      print('Ward names: $wardNames');
    } else {
      print('State or wards is null: $state');
    }
    return _buildDropdown(
      value: state is LocationSuccess ? state.selectedWardName : null,
      hint: 'Chọn Phường/Xã',
      items: wardNames,
      onChanged:
          state is LocationSuccess && state.selectedDistrictCode != null
              ? (value) {
                if (value != null) {
                  final ward = state.wards!.firstWhere(
                    (w) => w.name == value,
                    orElse: () => state.wards!.first,
                  );
                  ref
                      .read(locationControllerProvider.notifier)
                      .selectWard(ward.code);
                }
              }
              : null,
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
        color: onChanged == null ? Colors.grey[200] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 230, 230, 230),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: value == null ? Text(hint) : null,
        decoration: InputDecoration(
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
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  void _addAddress(WidgetRef ref, BuildContext context) async {
    final state = ref.read(locationControllerProvider);

    // Thêm một lớp kiểm tra để đảm bảo người dùng đã chọn địa chỉ
    if (state is! LocationSuccess ||
        state.selectedProvinceName == null ||
        state.selectedDistrictName == null ||
        state.selectedWardName == null) {
      _showSnackBar(context, 'Vui lòng chọn đầy đủ địa chỉ.');
      return;
    }

    if (_addressController.text.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập số nhà, tên đường');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    String fullAddress =
        '${_addressController.text}, '
        '${state.selectedWardName}, '
        '${state.selectedDistrictName}, '
        '${state.selectedProvinceName}';

    try {
      await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(
            name: _nameController.text,
            phoneNumber: _phoneController.text,
            street: _addressController.text,
            ward: state.selectedWardName!,
            district: state.selectedDistrictName!,
            city: state.selectedProvinceName!,
          );

      Navigator.of(context, rootNavigator: true).pop();

      _showSnackBar(context, 'Cập nhật địa chỉ thành công!');
      Navigator.pop(context, true);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      _showSnackBar(context, 'Cập nhật thất bại: ${e.toString()}');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ConstantsColor.colorMain,
      ),
    );
  }
}
