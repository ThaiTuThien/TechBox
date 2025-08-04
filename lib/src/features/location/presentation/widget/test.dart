import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/location/presentation/controllers/location_controller.dart';
import 'package:techbox/src/features/location/presentation/states/location_state.dart';

class LocationTestWidget extends ConsumerWidget {
  const LocationTestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Test Fetch Provinces')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(locationControllerProvider.notifier).getProvinces();
              },
              child: const Text('Fetch Provinces'),
            ),
            const SizedBox(height: 20),
            _buildStateContent(locationState),
          ],
        ),
      ),
    );
  }

  Widget _buildStateContent(LocationState state) {
    return switch (state) {
      LocationInitial() => const Text('Nhấn button để bắt đầu fetch.'),
      LocationLoading() => const CircularProgressIndicator(),
      LocationSuccess(provinces: final provinces) => Expanded(
        child: ListView.builder(
          itemCount: provinces.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(provinces[index].name));
          },
        ),
      ),
      LocationError(message: final message) => Text(
        'Lỗi: $message',
        style: const TextStyle(color: Colors.red),
      ),
    };
  }
}
