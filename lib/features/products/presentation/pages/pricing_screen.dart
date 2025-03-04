import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';
import 'package:stockaxis/features/products/presentation/bloc/products_cubit.dart';
import 'package:stockaxis/features/products/presentation/widgets/product_container.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen>
    with AutomaticKeepAliveClientMixin {
  late final ProductsCubit _cubit;
  List<PricingModel> _products = [];
  final List<PricingModel> _selectedProducts = [];
  int totalAmount = 0;

  @override
  void initState() {
    _cubit = context.read<ProductsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getPricing();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F1F1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: Color(0xff030303)),
          ),
        ),
        leadingWidth: 32,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Pricing', style: TextStyle(color: Color(0xff030303))),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.headset_mic, color: Color(0xff000000)),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, snapshot) {
              return Visibility(
                visible: _selectedProducts.length >= 2,
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color(0xFF008800)),
                  child: Text(
                    'You will save Rs. ${_selectedProducts.length >= 2 ? totalAmount * 0.2 : totalAmount} on this plan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(211, 252, 210, 255),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
                state.maybeWhen(
                  loadedPricing: (products) {
                    _products = products;
                  },

                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loadingPricing: () {
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                  orElse: () {
                    return ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return ProductContainer(
                          item: _products[index],
                          onChanged: (selected, item, oldAmount, newAmount) {
                            if (selected == false) {
                              if (_selectedProducts.contains(
                                _products[index],
                              )) {
                                _selectedProducts.remove(_products[index]);
                              }
                            } else {
                              if (!_selectedProducts.contains(
                                _products[index],
                              )) {
                                _selectedProducts.add(_products[index]);
                              }
                            }
                            totalAmount -= oldAmount;
                            totalAmount += newAmount;

                            _cubit.calculateTotalPayment();
                          },
                        );
                      },
                      addAutomaticKeepAlives: true,
                    );
                  },
                );
              },
              buildWhen: (previous, current) {
                return previous.maybeWhen(
                      loadingPricing: () {
                        return true;
                      },
                      orElse: () {
                        return false;
                      },
                    ) &&
                    current.maybeWhen(
                      loadPricingError: (error) {
                        return true;
                      },
                      loadedPricing: (products) {
                        return true;
                      },
                      orElse: () {
                        return false;
                      },
                    );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, snapshot) {
                        return Text(
                          'Rs. ${_selectedProducts.length >= 2 ? totalAmount * 0.8 : totalAmount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF040404),
                          ),
                        );
                      },
                    ),
                    Text(
                      'Inclusive GST',
                      style: TextStyle(fontSize: 16, color: Color(0xFFa4a4a4)),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF18388f)),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Proceed For Payemnt',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  void dispose() async {
    await _cubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
