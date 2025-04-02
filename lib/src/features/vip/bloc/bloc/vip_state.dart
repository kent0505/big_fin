part of 'vip_bloc.dart';

@immutable
sealed class VipState {}

final class VipInitial extends VipState {}

final class VipLoading extends VipState {}

final class VipsLoaded extends VipState {
  VipsLoaded({
    required this.products,
    required this.seconds,
  });

  final List<StoreProduct> products;
  final int seconds;
}

final class VipPaywall extends VipState {}

final class VipPurchased extends VipState {}

final class VipRestored extends VipState {}

final class VipError extends VipState {}

final class VipRestoreError extends VipState {}
