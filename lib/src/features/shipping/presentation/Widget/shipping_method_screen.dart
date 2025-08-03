import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:flutter/material.dart';
import 'package:techbox/src/features/shipping/presentation/Controller/shipping_method_controller.dart';
import 'package:techbox/src/features/shipping/presentation/State/shipping_method_state.dart';


class ShippingMethodScreen extends ConsumerWidget {
  final CalculateFeeDto dto = const CalculateFeeDto(
    shippingAddress: 'Hanoi',
    weight: 500,
    height: 10,
    length: 20,
    width: 15,
    insuranceValue: 100000,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shippingMethodControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shipping Methods')),
      body: _buildBody(state),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(shippingMethodControllerProvider.notifier).calculateFee(dto);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(ShippingMethodState state) {
    if (state is ShippingMethodLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ShippingMethodSuccess) {
      return ListView.builder(
        itemCount: state.methods.length,
        itemBuilder: (context, index) {
          final method = state.methods[index];
          return ListTile(
            title: Text(method.name),
            subtitle: Text('Type: ${method.type}, Fee: ${method.fee} VND'),
          );
        },
      );
    } else if (state is ShippingMethodError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    return const Center(child: Text('Press the button to calculate fee'));
  }
}