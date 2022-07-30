import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository makeProductRepository() => FakeProductsRepository(addDelay: false);

  group("Fake Product Repository", () {
    test("get product list return global list", () {
      final productsRepository = makeProductRepository();
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    });

    test("getProduct(1)", () {
      final productsRepository = makeProductRepository();
      expect(
        productsRepository.getProduct("1"),
        kTestProducts[0],
      );
    });

    test("getProduct(100)", () {
      final productsRepository = makeProductRepository();
      expect(
        productsRepository.getProduct("100"),
        null,
      );
    });
  });

  test("fetchProductsList return global list", () async {
    final productsRepository = makeProductRepository();
    expect(
      await productsRepository.fetchProductsList(),
      kTestProducts,
    );
  });

  test("watchProductList emits global list", () {
    final productsRepository = makeProductRepository();
    expect(
      productsRepository.watchProductsList(),
      emits(kTestProducts),
    );
  });

  test("watchProduct(1)", () {
    final productsRepository = makeProductRepository();
    expect(
      productsRepository.watchProduct("1"),
      emits(kTestProducts[0]),
    );
  });

  test("watchProduct(100)", () {
    final productsRepository = makeProductRepository();
    expect(
      productsRepository.watchProduct("100"),
      emits(null),
    );
  });
}
