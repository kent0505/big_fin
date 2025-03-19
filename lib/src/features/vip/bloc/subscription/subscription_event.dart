part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class SubscriptionLoaded extends SubscriptionEvent {}
