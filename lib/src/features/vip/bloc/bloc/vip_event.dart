part of 'vip_bloc.dart';

@immutable
sealed class VipEvent {}

final class LoadVips extends VipEvent {}

final class BuyVip extends VipEvent {
  BuyVip({required this.product});

  final StoreProduct product;
}

final class CheckVip extends VipEvent {}
