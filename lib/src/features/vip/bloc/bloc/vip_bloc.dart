import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../core/utils.dart';
import '../../data/vip_repository.dart';

part 'vip_event.dart';
part 'vip_state.dart';

class VipBloc extends Bloc<VipEvent, VipState> {
  final VipRepository _repository;

  VipBloc({required VipRepository repository})
      : _repository = repository,
        super(VipInitial()) {
    on<VipEvent>(
      (event, emit) => switch (event) {
        LoadVips() => _loadVips(event, emit),
      },
    );
  }

  Future<void> _loadVips(
    LoadVips event,
    Emitter<VipState> emit,
  ) async {
    try {
      logger('started');
      emit(VipLoading());

      final productDetailList = await _repository.loadProductList();

      emit(VipsLoaded(productDetailList: productDetailList));
    } on Object catch (e) {
      logger(event);
      emit(VipError(message: e.toString()));
    }
  }
}
