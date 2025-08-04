// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:techbox/src/common_widgets/app_bar.dart';
// import 'package:techbox/src/core/constants.dart';
// import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
// import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';
// import 'package:techbox/src/features/location/presentation/states/location_state.dart';
// import 'package:techbox/src/features/location/presentation/controllers/location_controller.dart';

// class UpdateAddressPage extends ConsumerStatefulWidget {
//   const UpdateAddressPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<UpdateAddressPage> createState() => _UpdateAddressPageState();
// }

// class _UpdateAddressPageState extends ConsumerState<UpdateAddressPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   String? _selectedProvince;
//   String? _selectedDistrict;
//   String? _selectedWard;

//   @override
//   void initState() {
//     super.initState();
//     _loadInitialData();
//     ref.read(locationControllerProvider.notifier).getProvinces();
//   }

//   void _loadInitialData() {
//     final state = ref.read(profileControllerProvider);
//     if (state is ProfileSuccess) {
//       final profile = state.profile;
//       _nameController.text = profile.name;
//       _phoneController.text = profile.phoneNumber;
//       _addressController.text = [
//         if (profile.address.street.isNotEmpty) profile.address.street,
//         if (profile.address.ward.isNotEmpty) profile.address.ward,
//         if (profile.address.district.isNotEmpty) profile.address.district,
//         if (profile.address.city.isNotEmpty) profile.address.city,
//       ].where((e) => e.isNotEmpty).join(', ');
//       _selectedProvince = profile.address.city.isNotEmpty ? profile.address.city : null;
//       _selectedDistrict = profile.address.district.isNotEmpty ? profile.address.district : null;
//       _selectedWard = profile.address.ward.isNotEmpty ? profile.address.ward : null;
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _loadInitialData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBarComponent(
//         title: 'Cập nhật địa chỉ',
//         showBottomBorder: false,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               Container(
//                 color: Colors.white,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     _buildSectionTitle('Họ và tên'),
//                     const SizedBox(height: 4),
//                     _buildTextField(
//                       controller: _nameController,
//                       hintText: 'Vui lòng nhập tên',
//                       labelText: 'Họ và tên',
//                       keyboardType: TextInputType.name,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildSectionTitle('Số điện thoại'),
//                     const SizedBox(height: 4),
//                     _buildPhoneField(),
//                     const SizedBox(height: 16),
//                     _buildSectionTitle('Tỉnh/Thành phố'),
//                     const SizedBox(height: 4),
//                     _buildProvinceDropdown(),
//                     const SizedBox(height: 16),
//                     _buildSectionTitle('Quận/Huyện'),
//                     const SizedBox(height: 4),
//                     _buildDistrictDropdown(),
//                     const SizedBox(height: 16),
//                     _buildSectionTitle('Phường/Xã'),
//                     const SizedBox(height: 4),
//                     _buildWardDropdown(),
//                     const SizedBox(height: 16),
//                     _buildSectionTitle('Số nhà/Tên đường'),
//                     const SizedBox(height: 4),
//                     _buildTextField(
//                       controller: _addressController,
//                       hintText: 'Nhập số nhà, tên đường',
//                       labelText: 'Số nhà/Tên đường',
//                       keyboardType: TextInputType.streetAddress,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 height: 145,
//                 width: 380,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Stack(
//                     children: [
//                       Container(
//                         color: Colors.blue[50],
//                         child: const Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.location_on,
//                                 size: 40,
//                                 color: Colors.red,
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Bản đồ vị trí',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const Positioned(
//                         top: 80,
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.white)],
//         ),
//         child: SafeArea(
//           child: SizedBox(
//             width: 358,
//             height: 54,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: 170,
//                     height: 54,
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(
//                           color: ConstantsColor.colorMain,
//                           width: 1,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         'Hủy',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Inter',
//                           color: ConstantsColor.colorMain,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 18),
//                 Expanded(
//                   child: Container(
//                     width: 170,
//                     height: 54,
//                     child: ElevatedButton(
//                       onPressed: _updateAddress,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ConstantsColor.colorMain,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Cập nhật',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Inter',
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required String labelText,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Container(
//       width: 358,
//       height: 52,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: const Color.fromARGB(255, 230, 230, 230),
//           width: 1,
//         ),
//       ),
//       child: Container(
//         width: 301,
//         height: 22,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         child: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
//             border: InputBorder.none,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPhoneField() {
//     return Container(
//       width: 358,
//       height: 52,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: const Color.fromARGB(255, 230, 230, 230),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Image(
//               image: AssetImage('assets/image/vn_circle.png'),
//               width: 24,
//               height: 24,
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
//               child: TextField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   hintText: 'Vui lòng nhập số điện thoại',
//                   hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProvinceDropdown() {
//     return Container(
//       width: 358,
//       height: 52,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: const Color.fromARGB(255, 230, 230, 230),
//           width: 1,
//         ),
//       ),
//       child: Consumer(
//         builder: (context, ref, child) {
//           final state = ref.watch(locationControllerProvider);
//           return state.when(
//             initial: () => const Center(child: CircularProgressIndicator()),
//             loading: () => const Center(child: CircularProgressIndicator()),
//             success: (provinces) => DropdownButtonFormField<String>(
//               value: _selectedProvince,
//               decoration: InputDecoration(
//                 hintText: 'Chọn Tỉnh/Thành phố',
//                 hintStyle: TextStyle(
//                   color: const Color.fromARGB(255, 205, 205, 205),
//                   fontSize: 16,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//               ),
//               items: provinces.map((province) {
//                 return DropdownMenuItem<String>(
//                   value: province.name,
//                   child: Text(province.name),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedProvince = value;
//                   _selectedDistrict = null;
//                   _selectedWard = null;
//                 });
//               },
//               icon: const Icon(Icons.keyboard_arrow_down),
//             ),
//             error: (message) => Center(child: Text(message)),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDistrictDropdown() {
//     return Container(
//       width: 358,
//       height: 52,
//       decoration: BoxDecoration(
//         color: _selectedProvince == null ? Colors.white : Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: const Color.fromARGB(255, 230, 230, 230),
//           width: 1,
//         ),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: _selectedDistrict,
//         decoration: InputDecoration(
//           hintText: 'Chọn Quận/Huyện',
//           hintStyle: TextStyle(
//             color: const Color.fromARGB(255, 205, 205, 205),
//             fontSize: 16,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 15,
//           ),
//         ),
//         items: _getDistricts().map((district) {
//           return DropdownMenuItem<String>(
//             value: district,
//             child: Text(district),
//           );
//         }).toList(),
//         onChanged: _selectedProvince == null
//             ? null
//             : (value) {
//                 setState(() {
//                   _selectedDistrict = value;
//                   _selectedWard = null;
//                 });
//               },
//         icon: const Icon(Icons.keyboard_arrow_down),
//       ),
//     );
//   }

//   Widget _buildWardDropdown() {
//     return Container(
//       width: 358,
//       height: 52,
//       decoration: BoxDecoration(
//         color: _selectedDistrict == null ? Colors.white : Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: const Color.fromARGB(255, 230, 230, 230),
//           width: 1,
//         ),
//       ),
//       child: DropdownButtonFormField<String>(
//         value: _selectedWard,
//         decoration: InputDecoration(
//           hintText: 'Chọn Phường/Xã',
//           hintStyle: TextStyle(
//             color: const Color.fromARGB(255, 205, 205, 205),
//             fontSize: 16,
//           ),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 15,
//           ),
//         ),
//         items: _getWards().map((ward) {
//           return DropdownMenuItem<String>(
//             value: ward,
//             child: Text(ward),
//           );
//         }).toList(),
//         onChanged: _selectedDistrict == null
//             ? null
//             : (value) {
//                 setState(() {
//                   _selectedWard = value;
//                 });
//               },
//         icon: const Icon(Icons.keyboard_arrow_down),
//       ),
//     );
//   }

//   List<String> _getDistricts() {
//     final state = ref.read(locationControllerProvider);
//     if (state is LocationSuccess && _selectedProvince != null) {
//       return state.provinces
//           .where((province) => province.name == _selectedProvince)
//           .map((e) => e.name.split(',').map((e) => e.trim()).toList())
//           .expand((element) => element)
//           .toList();
//     }
//     return [];
//   }

//   List<String> _getWards() {
//     final state = ref.read(locationControllerProvider);
//     if (state is LocationSuccess && _selectedDistrict != null) {
//       return state.provinces
//           .where((province) => province.name == _selectedProvince)
//           .map((e) => e.name.split(',').map((e) => e.trim()).toList())
//           .expand((element) => element)
//           .toList();
//     }
//     return [];
//   }

//   Future<void> _updateAddress() async {
//     if (_nameController.text.isEmpty) {
//       _showSnackBar('Vui lòng nhập họ và tên');
//       return;
//     }
//     if (_phoneController.text.isEmpty) {
//       _showSnackBar('Vui lòng nhập số điện thoại');
//       return;
//     }
//     if (_selectedProvince == null) {
//       _showSnackBar('Vui lòng chọn tỉnh/thành phố');
//       return;
//     }
//     if (_selectedDistrict == null) {
//       _showSnackBar('Vui lòng chọn quận/huyện');
//       return;
//     }
//     if (_selectedWard == null) {
//       _showSnackBar('Vui lòng chọn phường/xã');
//       return;
//     }
//     if (_addressController.text.isEmpty) {
//       _showSnackBar('Vui lòng nhập số nhà, tên đường');
//       return;
//     }

//     final address = '${_addressController.text}, $_selectedWard, $_selectedDistrict, $_selectedProvince';
//     await ref.read(profileControllerProvider.notifier).updateProfile(
//       _nameController.text,
//       _phoneController.text,
//       address,
//     );
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: const Color.fromARGB(255, 12, 20, 21),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }