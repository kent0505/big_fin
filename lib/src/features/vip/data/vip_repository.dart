import 'package:in_app_purchase/in_app_purchase.dart';

/// {@template vip_repository}
/// VipRepository.
/// {@endtemplate}
abstract interface class VipRepository {
  /// {@macro vip_repository}

  /// Загрузка подписок.
  Future<List<ProductDetails>> loadProductList();

  /// Покупка подписки.
  Future<void> buySubscription(ProductDetails productDetails);
}

/// {@template vip_repository}
/// VipRepositoryImpl.
/// {@endtemplate}
final class VipRepositoryImpl implements VipRepository {
  /// {@macro vip_repository}
  const VipRepositoryImpl({required InAppPurchase inAppPurchase})
      : _inAppPurchase = inAppPurchase;

  final InAppPurchase _inAppPurchase;

  static const _productIds = {'Monthly', 'Yearly'};

  @override
  Future<bool> buySubscription(ProductDetails productDetails) async {
    return await _inAppPurchase.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: productDetails));
  }

  @override
  Future<List<ProductDetails>> loadProductList() async {
    final available = await _inAppPurchase.isAvailable();

    if (!available) {
      Error.throwWithStackTrace(
          Exception('InAppPurchase is not aviable'), StackTrace.current);
    }

    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      Error.throwWithStackTrace(
          Exception('Products not found'), StackTrace.current);
    }

    return response.productDetails;
  }
}
