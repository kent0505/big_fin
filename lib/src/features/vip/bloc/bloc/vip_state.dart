part of 'vip_bloc.dart';

@immutable
sealed class VipState {}

final class VipInitial extends VipState {}

final class VipLoading extends VipState {}

final class VipsLoaded extends VipState {
  VipsLoaded({required this.productDetailList});

  final List<ProductDetails> productDetailList;
}

final class VipError extends VipState {
  VipError({required this.message});

  final String message;
}
