part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionState {}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoadInProgress extends SubscriptionState {}

final class SubscriptionLoadCompleted extends SubscriptionState {
  SubscriptionLoadCompleted({required this.productDetailList});

  final List<ProductDetails> productDetailList;
}

final class SubscriptionError extends SubscriptionState {
  SubscriptionError({required this.message});

  final String message;
}
