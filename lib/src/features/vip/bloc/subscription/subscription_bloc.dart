import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../../core/utils.dart';
import '../../data/vip_repository.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final VipRepository _repository;

  SubscriptionBloc({required VipRepository repository})
      : _repository = repository,
        super(SubscriptionInitial()) {
    on<SubscriptionEvent>(
      (event, emit) => switch (event) {
        SubscriptionLoaded() => _onSubscriptionLoaded(event, emit),
      },
    );
  }

  Future<void> _onSubscriptionLoaded(
    SubscriptionLoaded event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      logger('started');
      emit(SubscriptionLoadInProgress());

      final productDetailList = await _repository.loadProductList();

      emit(SubscriptionLoadCompleted(productDetailList: productDetailList));
    } on Object catch (e) {
      logger(event);
      emit(SubscriptionError(message: e.toString()));
    }
  }
}
