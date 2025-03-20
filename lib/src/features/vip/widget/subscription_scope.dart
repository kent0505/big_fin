import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../core/utils.dart';

class SubscriptionScope extends StatefulWidget {
  const SubscriptionScope({super.key, required this.child});

  final Widget child;

  static String productId(BuildContext context) {
    final _SubscriptionInheritedScope? scope = context
        .dependOnInheritedWidgetOfExactType<_SubscriptionInheritedScope>();
    return scope?.productId ?? '';
  }

  static bool purchased(BuildContext context) {
    final _SubscriptionInheritedScope? scope = context
        .dependOnInheritedWidgetOfExactType<_SubscriptionInheritedScope>();
    final productId = scope?.productId ?? '';

    return productId.isEmpty;
  }

  @override
  State<SubscriptionScope> createState() => _SubscriptionScopeState();
}

class _SubscriptionScopeState extends State<SubscriptionScope> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  String productId = '';

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {},
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SubscriptionInheritedScope(
      productId: productId,
      child: widget.child,
    );
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
        logger('is pending');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        logger('${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        setState(() {
          productId = purchaseDetails.productID;
        });
        logger(purchaseDetails.productID);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        logger('is completed');
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }
}

class _SubscriptionInheritedScope extends InheritedWidget {
  const _SubscriptionInheritedScope({
    required this.productId,
    required super.child,
  });

  final String productId;

  @override
  bool updateShouldNotify(_SubscriptionInheritedScope oldWidget) {
    return oldWidget.productId != productId;
  }
}
