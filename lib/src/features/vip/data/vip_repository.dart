import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/constants.dart';
import '../bloc/bloc/vip_bloc.dart';

abstract interface class VipRepository {
  const VipRepository();

  Future<List<StoreProduct>> getProducts();
  Future<bool> vipPurchased();
  Future<void> purchaseStoreProduct(StoreProduct product);
  int getPeriod();
  Future<void> setPeriod(int period);
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
}
