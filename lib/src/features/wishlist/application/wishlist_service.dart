import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/wishlist/domain/wishlist_model.dart';

class WishlistService {
  static const wishListKey = 'wishlist_items';

  Future<List<WishlistModel>> getWishList() async {
    final pref = await SharedPreferences.getInstance();
    final wishListString = pref.getString(wishListKey);
    if (wishListString != null) {
      final List<dynamic> decodedList = jsonDecode(wishListString);
      return decodedList.map((item) => WishlistModel.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> saveWishList(List<WishlistModel> wishListItems) async {
    final pref = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedList = wishListItems.map((item) => item.toJson()).toList();
    await pref.setString(wishListKey, jsonEncode(encodedList));
  }

  Future<void> addWishList(WishlistModel newItem) async {
    final wishListItems = await getWishList();
    if (!wishListItems.any((item) => item.variantId == newItem.variantId)) {
      wishListItems.add(newItem);
      await saveWishList(wishListItems);
    }
  }

  Future<void> removeFromWishlist(String variantId) async {
    final wishListItems = await getWishList();
    wishListItems.removeWhere((item) => item.variantId == variantId);
    await saveWishList(wishListItems);
  }
}

final wishListServiceProvider = Provider((ref) => WishlistService());

final wishlistItemsProvider = FutureProvider<List<WishlistModel>>((ref) {
  final wishlistService = ref.watch(wishListServiceProvider);
  return wishlistService.getWishList();
});