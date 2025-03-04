import 'package:dartz/dartz.dart';
import 'package:html/dom.dart' show Document;
import 'package:http/http.dart' show Client;
import 'package:stockaxis/core/status/failure.dart';
import 'package:stockaxis/core/utils.dart';
import 'package:stockaxis/features/products/data/datasources/remote/product_remote_client.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';
import 'package:stockaxis/features/products/data/models/products_response_model.dart.dart';
import 'package:stockaxis/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteClient _remoteClient;
  const ProductRepositoryImpl(this._remoteClient);
  @override
  Future<Either<Failure, List<Product>>> getProducts(
    String pkgName,
    String action,
    String activity,
    String cid,
  ) async {
    try {
      final response = await _remoteClient.getProducts(
        pkgName,
        action,
        activity,
        cid,
      );
      return right(response.data);
    } catch (_) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<PricingModel>>> getPricing() async {
    try {
      final Client client = Client();

      final response = await _remoteClient.getPricing();
      Document document = Document.html(response.data);
      final priceCards = document.getElementsByClassName('price-card-cont');
      List<PricingModel> stockPlans = [];
      for (var card in priceCards) {
        var titleElement = card.querySelector('.price-card-tle h5');
        String productName =
            titleElement != null ? titleElement.text.trim() : '';
        var categoryElement = card.querySelector('cite.caps');
        String category =
            categoryElement != null ? categoryElement.text.trim() : '';
        var volatilityElement = card.querySelector('cite.pri-vol');
        String volatility =
            volatilityElement != null ? volatilityElement.text.trim() : '';
        var descriptionElement = card.querySelector('.col-lg-21 p');
        String description =
            descriptionElement != null ? descriptionElement.text.trim() : '';
        var priceOptions = card.querySelectorAll('select option');
        List<String> plans = [];
        for (var option in priceOptions) {
          if (option.attributes['value'] != '0') {
            plans.add(option.text.trim());
          }
        }
        // Extract image URL
        var imageElement = card.querySelector('.price-card-tle img');
        String imageUrl =
            imageElement != null
                ? 'https://www.stockaxis.com${imageElement.attributes['src']!}'
                : 'N/A';
        final svgResponse = await client.get(Uri.parse(imageUrl));
        final imageString = svgRemoveStyleLabel(svgResponse.body);
        stockPlans.add(
          PricingModel(
            name: productName,
            category: category,
            volatility: volatility,
            description: description,
            plans: plans,
            imageString: imageString,
          ),
        );
      }
      return right(stockPlans);
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
