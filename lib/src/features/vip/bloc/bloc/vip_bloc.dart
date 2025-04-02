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
    StoreProduct(Identifiers.monthly, '', 'Pay Monthly', 9.99, '\$9.99', 'usd'),
    StoreProduct(Identifiers.yearly, '', 'Pay Yearly', 49.99, '\$49.99', 'usd'),
  ];

  int seconds = 0;

  VipBloc({required VipRepository repository})
      : _repository = repository,
        super(VipInitial()) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        LoadVips() => _loadVips(event, emit),
        BuyVip() => _buyVip(event, emit),
        CheckVip() => _checkVip(event, emit),
        RestoreVip() => _restoreVip(event, emit),
      },
    );
  }

  Future<void> _loadVips(
    LoadVips event,
    Emitter<VipState> emit,
  ) async {
    emit(VipLoading());
    try {
      seconds = await _repository.getVipSeconds();
      if (isIOS()) {
        products = await _repository.getProducts();
        add(CheckVip());
      } else {
        emit(VipsLoaded(
          products: products,
          showPaywall: true,
          seconds: seconds,
        ));
      }
    } on Object catch (e) {
      logger(e);
      emit(VipsLoaded(
        products: products,
        seconds: seconds,
      ));
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
        // ПОСЛЕ УСПЕШНОЙ ПОКУПКИ СОХРАНЯЕМ ДАТУ НА 7 ДНЕЙ
        // ЕСЛИ ЮЗЕР ОФФЛАЙН ТО ПО ДАТЕ БУДЕМ ЗНАТЬ ИМЕЕТСЯ ЛИ ПОДПИСКА ИЛИ НЕТ
        await _repository.setPeriod();
        emit(VipPurchased());
      } else {
        emit(VipsLoaded(
          products: products,
          seconds: seconds,
        ));
      }
    } on Object catch (e) {
      logger(e);
      emit(VipError());
      emit(VipsLoaded(
        products: products,
        seconds: seconds,
      ));
    }
  }

  Future<void> _checkVip(
    CheckVip event,
    Emitter<VipState> emit,
  ) async {
    try {
      // ЕСЛИ ЮЗЕР ПОДКЛЮЧЕН К ИНТЕРНЕТУ
      if (await _repository.vipPurchased()) {
        // ОБНОВЛЯЕМ ДАТУ ПОДПИСКИ
        await _repository.setPeriod();
        emit(VipPurchased());
      } else {
        throw Exception("Check failed");
      }
    } on Object catch (e) {
      logger(e);
      // ИНАЧЕ ПРОВЕРЯЕМ ПОДПИСКУ ПО ДАТЕ
      emit(getTimestamp() < _repository.getPeriod()
          ? VipPurchased()
          : VipsLoaded(
              products: products,
              showPaywall: true,
              seconds: seconds,
            ));
    }
  }

  Future<void> _restoreVip(
    RestoreVip event,
    Emitter<VipState> emit,
  ) async {
    emit(VipLoading());
    try {
      if (await _repository.restoreProduct()) {
        await _repository.setPeriod();
        emit(VipPurchased());
      } else {
        throw Exception("Restore failed");
      }
    } on Object catch (e) {
      logger(e);
      await _repository.removePeriod();
      emit(VipRestoreError());
      emit(VipsLoaded(
        products: products,
        seconds: seconds,
      ));
    }
  }
}
