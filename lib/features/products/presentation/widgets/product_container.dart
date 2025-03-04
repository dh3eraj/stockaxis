import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';

class ProductContainer extends StatefulWidget {
  final PricingModel item;
  final void Function(
    bool isSelected,
    PricingModel item,
    int oldAmount,
    int newAmount,
  )
  onChanged;
  final String value;

  const ProductContainer({
    super.key,
    required this.item,
    required this.onChanged,
    this.value = 'Select a Plan (inclusive of GST)',
  });
  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer>
    with AutomaticKeepAliveClientMixin {
  late String selectedValue;
  late int oldAmount;
  late int newAmount;
  @override
  void initState() {
    selectedValue = widget.value;
    oldAmount = 0;
    newAmount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 16, top: 0, bottom: 16, right: 16),

      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevationToShadow[2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.string(
                widget.item.imageString,
                width: 24,
                fit: BoxFit.fitWidth,
              ),

              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(widget.item.category),
                ],
              ),
              Spacer(),
              Icon(Icons.info_outline, color: Color(0xffacacac)),
            ],
          ),
          Divider(),
          SizedBox(height: 16),
          Text(
            widget.item.description,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: selectedValue,
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 8, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        selectedValue != 'Select a Plan (inclusive of GST)'
                            ? Color(0xff326c2d)
                            : Color(0xffb3b3b3),
                  ),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(Icons.arrow_drop_down, color: Color(0xff3e74be)),
              ),
              items:
                  [
                    'Select a Plan (inclusive of GST)',
                    ...widget.item.plans,
                  ].map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: Color(0xFF696969)),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != 'Select a Plan (inclusive of GST)') {
                  newAmount = int.parse(
                    (value ?? 'Rs. 0')
                        .split('Rs.')
                        .last
                        .trim()
                        .replaceAll(',', ''),
                  );
                  widget.onChanged(true, widget.item, oldAmount, newAmount);
                } else {
                  newAmount = 0;
                  widget.onChanged(false, widget.item, oldAmount, newAmount);
                }
                setState(() {
                  selectedValue = value!;
                  oldAmount = newAmount;
                });
              },
              dropdownStyleData: DropdownStyleData(
                width: 300,
                decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
