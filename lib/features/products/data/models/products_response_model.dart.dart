class ProductsResponseModel {
    final List<Product> data;

    ProductsResponseModel({
        required this.data,
    });

    factory ProductsResponseModel.fromJson(Map<String, dynamic> json) => ProductsResponseModel(
        data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Product {
    final String pCode;
    final String pDescription;
    final String pAmount;
    final String pDuration;
    final String pkgName;
    final String comboOffer;
    final String alertMsg;
    final String couponCode;
    final int srNo;
    final String pTotaAmount;

    Product({
        required this.pCode,
        required this.pDescription,
        required this.pAmount,
        required this.pDuration,
        required this.pkgName,
        required this.comboOffer,
        required this.alertMsg,
        required this.couponCode,
        required this.srNo,
        required this.pTotaAmount,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        pCode: json['PCode'],
        pDescription: json['PDescription'],
        pAmount: json['PAmount'],
        pDuration: json['PDuration'],
        pkgName: json['PKGName'],
        comboOffer: json['ComboOffer'],
        alertMsg: json['AlertMsg'],
        couponCode: json['CouponCode'],
        srNo: json['SrNo'],
        pTotaAmount: json['PTotaAmount'],
    );

    Map<String, dynamic> toJson() => {
        'PCode': pCode,
        'PDescription': pDescription,
        'PAmount': pAmount,
        'PDuration': pDuration,
        'PKGName': pkgName,
        'ComboOffer': comboOffer,
        'AlertMsg': alertMsg,
        'CouponCode': couponCode,
        'SrNo': srNo,
        'PTotaAmount': pTotaAmount,
    };
}
