import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/models/ProductModel.dart';

class ProductRepository {
  final instance =
      FirebaseFirestore.instance.collection("products").withConverter(
          fromFirestore: (snapshot, _) {
            return ProductModel.fromFirebaseSnapshot(snapshot);
          },
          toFirestore: (ProductModel model, _) => model.toJson());

  Future<void> createProduct(ProductModel data) async {
    try {
      final product = await instance.add(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<ProductModel>>> getAllProduct() async {
    try {
      final products = (await instance.get()).docs;
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await instance.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel?> getOneProduct(String id) async {
    try {
      final product = (await instance.doc(id).get()).data();
      return product;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, ProductModel data) async {
    try {
      await instance.doc(id).set(data);
    } catch (e) {
      rethrow;
    }
  }
}
