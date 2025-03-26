part of 'vip_bloc.dart';

@immutable
sealed class VipState {}

final class VipInitial extends VipState {}

final class VipLoading extends VipState {}

final class VipsLoaded extends VipState {
  VipsLoaded({
    required this.products,
    this.showPaywall = false,
    required this.seconds,
  });

  final List<StoreProduct> products;
  final bool showPaywall;
  final int seconds;
}

final class VipPurchased extends VipState {}

final class VipError extends VipState {}
