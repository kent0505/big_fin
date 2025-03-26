import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/constants.dart';
import '../bloc/bloc/vip_bloc.dart';

abstract interface class VipRepository {
  const VipRepository();

  Future<List<StoreProduct>> getProducts();
  Future<List<Offering>> getOffers();
  Future<bool> vipPurchased();
  Future<void> purchaseStoreProduct(StoreProduct product);
  int getPeriod();
  Future<void> setPeriod(int period);
  Future<int> getVipSeconds();
}

final class VipRepositoryImpl implements VipRepository {
  VipRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<List<StoreProduct>> getProducts() async {
    return await Purchases.getProducts([
      Identifiers.monthly,
      Identifiers.yearly,
    ]);
  }

  // FOR ANDROID
  @override
  Future<List<Offering>> getOffers() async {
    final offerings = await Purchases.getOfferings();
    final current = offerings.current;
    return current == null ? [] : [current];
  }

  @override
  Future<bool> vipPurchased() async {
    final customerInfo = await Purchases.getCustomerInfo();
    return customerInfo.entitlements.active.isNotEmpty;
  }

  @override
  Future<void> purchaseStoreProduct(StoreProduct product) async {
    await Purchases.purchaseStoreProduct(product);
  }

  @override
  int getPeriod() {
    return _prefs.getInt(Keys.vipPeriod) ?? 0;
  }

  @override
  Future<void> setPeriod(int period) async {
    await _prefs.setInt(Keys.vipPeriod, period);
  }

  @override
  Future<int> getVipSeconds() async {
    final now = DateTime.now();
    int seconds = _prefs.getInt(Keys.vipSeconds) ?? 0;
    if (seconds < now.millisecondsSinceEpoch) {
      final random = Random();
      final futureTime = now.add(Duration(
        hours: random.nextInt(10) + 14,
        minutes: random.nextInt(60),
        seconds: random.nextInt(60),
      ));
      seconds = futureTime.millisecondsSinceEpoch;
      await _prefs.setInt(Keys.vipSeconds, seconds);
    }
    return seconds;
  }
}
