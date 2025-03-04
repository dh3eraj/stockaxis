class PricingModel {
  final String name;
  final String category;
  final String volatility;
  final String description;
  final List<String> plans;
  final String imageString;

  PricingModel({
    required this.name,
    required this.category,
    required this.volatility,
    required this.description,
    required this.plans,
    required this.imageString
  });

  @override
  String toString() {
    return "Plan: $name\nImage: $imageString\nCategory: $category\nVolatility: $volatility\nDescription: $description\nPlans: ${plans.join(", ")}\n";
  }
}
