import 'package:in_app_purchase/in_app_purchase.dart';

abstract interface class VipRepository {
  Future<List<ProductDetails>> loadProductList();
  Future<void> buySubscription(ProductDetails productDetails);
}

final class VipRepositoryImpl implements VipRepository {
  const VipRepositoryImpl({required InAppPurchase inAppPurchase})
      : _inAppPurchase = inAppPurchase;

  final InAppPurchase _inAppPurchase;

  static const _productIds = {'Monthly', 'Yearly'};

  @override
  Future<bool> buySubscription(ProductDetails productDetails) async {
    return await _inAppPurchase.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: productDetails),
    );
  }

  @override
  Future<List<ProductDetails>> loadProductList() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      Error.throwWithStackTrace(
        Exception('InAppPurchase is not aviable'),
        StackTrace.current,
      );
    }
    final response = await _inAppPurchase.queryProductDetails(_productIds);
    if (response.notFoundIDs.isNotEmpty) {
      Error.throwWithStackTrace(
        Exception('Products not found'),
        StackTrace.current,
      );
    }
    return response.productDetails;
  }
}
