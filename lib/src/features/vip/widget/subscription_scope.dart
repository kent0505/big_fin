import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// {@template subscription_wrapper}
/// SubscriptionScope widget.
/// {@endtemplate}
class SubscriptionScope extends StatefulWidget {
  /// {@macro subscription_wrapper}
  const SubscriptionScope({
    required this.child,
    super.key, // ignore: unused_element
  });

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

/// State for widget SubscriptionScope.
class _SubscriptionScopeState extends State<SubscriptionScope> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  String productId = '';

  /* #region Lifecycle */
  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    super.initState();
    // Initial state initialization
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    return _SubscriptionInheritedScope(
        productId: productId, child: widget.child);
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
        print('is pending');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // _handleError(purchaseDetails.error!);
        print('${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        setState(() {
          productId = purchaseDetails.productID;
        });

        print(purchaseDetails.productID);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        print('is completed');
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }
}

/// {@template subscription_scope}
/// _SubscriptionInheritedScope widget.
/// {@endtemplate}
class _SubscriptionInheritedScope extends InheritedWidget {
  /// {@macro subscription_scope}
  const _SubscriptionInheritedScope({
    required this.productId,
    required super.child, // ignore: unused_element
  });

  final String productId;

  @override
  bool updateShouldNotify(_SubscriptionInheritedScope oldWidget) {
    return oldWidget.productId != productId;
  }
}
