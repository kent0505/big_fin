import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
export 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/utils.dart';
import '../../data/vip_repository.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  final VipRepository _repository;

  List<StoreProduct> products = [
    StoreProduct('', '', 'Pay Monthly', 9.99, '\$9.99', 'usd'),
    StoreProduct('', '', 'Pay Yearly', 49.99, '\$49.99', 'usd'),
  ];

  VipBloc({required VipRepository repository})
      : _repository = repository,
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
      if (isIOS()) {
        products = await _repository.getProducts();
        add(CheckVip());
      } else {
        emit(VipsLoaded(
          products: products,
          showPaywall: true,
        ));
      }
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
      await _repository.purchaseStoreProduct(event.product);
      if (await _repository.vipPurchased()) {
        // ПОСЛЕ УСПЕШНОЙ ПОКУПКИ СОХРАНЯЕМ ДАТУ ОКОНЧАНИЯ ПОДПИСКИ
        // ЕСЛИ ЮЗЕР ОФФЛАЙН ТО ПО ДАТЕ БУДЕМ ЗНАТЬ ИМЕЕТСЯ ЛИ ПОДПИСКА ИЛИ НЕТ
        final now = DateTime.now();
        final endDate = DateTime(
          event.product.identifier == Identifiers.yearly
              ? now.year + 1
              : now.year,
          event.product.identifier == Identifiers.monthly
              ? now.month + 1
              : now.month,
          now.day,
          now.hour,
          now.minute,
        );
        await _repository.setPeriod(endDate.millisecondsSinceEpoch);
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
      // ЕСЛИ ЮЗЕР ПОДКЛЮЧЕН К ИНТЕРНЕТУ
      emit(await _repository.vipPurchased()
          ? VipPurchased()
          : VipsLoaded(
              products: products,
              showPaywall: true,
            ));
    } on Object catch (e) {
      logger(e);
      // ИНАЧЕ ПРОВЕРЯЕМ ПОДПИСКУ ПО ДАТЕ
      emit(getTimestamp() < _repository.getPeriod()
          ? VipPurchased()
          : VipsLoaded(
              products: products,
              showPaywall: true,
            ));
    }
  }
}
