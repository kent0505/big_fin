import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/utils.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  final SharedPreferences _prefs;
  final List<String> _productIdentifiers = ['Monthly', 'Yearly'];
  List<StoreProduct> products = [];

  VipBloc({required SharedPreferences prefs})
      : _prefs = prefs,
        super(VipInitial()) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        LoadVips() => _loadVips(event, emit),
        BuyVip() => _buyVip(event, emit),
        CheckVip() => _checkVip(event, emit),
      },
    );
  }

  Future<void> _loadVips(
    LoadVips event,
    Emitter<VipState> emit,
  ) async {
    emit(VipLoading());
    try {
      products = await Purchases.getProducts(_productIdentifiers);
      add(CheckVip());
    } on Object catch (e) {
      logger(e);
      emit(VipsLoaded(products: products));
    }
  }

  Future<void> _buyVip(
    BuyVip event,
    Emitter<VipState> emit,
  ) async {
    emit(VipLoading());
    try {
      await Purchases.purchaseStoreProduct(event.product);
      final customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.active.isNotEmpty) {
        final now = DateTime.now();
        final endDate = DateTime(
          event.product.identifier == _productIdentifiers[1]
              ? now.year + 1
              : now.year,
          event.product.identifier == _productIdentifiers[0]
              ? now.month + 1
              : now.month,
          now.day,
          now.hour,
          now.minute,
        );
        await _prefs.setInt(Keys.period, endDate.millisecondsSinceEpoch);
        emit(VipPurchased());
      } else {
        emit(VipsLoaded(products: products));
      }
    } on Object catch (e) {
      logger(e);
      emit(VipError());
      emit(VipsLoaded(products: products));
    }
  }

  Future<void> _checkVip(
    CheckVip event,
    Emitter<VipState> emit,
  ) async {
    try {
      // final customerInfo = await Purchases.getCustomerInfo();
      // emit(customerInfo.entitlements.active.isNotEmpty
      //     ? VipPurchased()
      //     : VipsLoaded(products: products));
      final period = _prefs.getInt(Keys.period) ?? 0;
      emit(getTimestamp() < period
          ? VipPurchased()
          : VipsLoaded(products: products));
    } on Object catch (e) {
      logger(e);
      emit(VipsLoaded(products: products));
      // final period = _prefs.getInt(Keys.period) ?? 0;
      // emit(getTimestamp() < period
      //     ? VipPurchased()
      //     : VipsLoaded(products: products));
    }
  }
}
