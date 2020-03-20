import 'package:flutter/material.dart';
import '../components/shrimp_size_icon.dart';
import '../widgets/price_detail.dart';
import '../components/custom_list_tile.dart';
import '../components/list_view_label.dart';
import '../models/ShrimpPrice.dart';
import '../models/ShrimpSize.dart';
import '../models/ShrimpType.dart';

final prices = [
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da76",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c2",
    "shrimpSizeId": "5e00f81e48200e00a8147935",
    "price": 280,
    "shrimpPriceDate": "2019-07-09T03:28:20.201Z",
    "createdAt": "2019-12-24T04:13:37.972Z",
    "updatedAt": "2019-12-24T04:13:37.972Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e1ef1780bc12f9dfcdb4668",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c2",
    "shrimpSizeId": "5e00f81e48200e00a8147935",
    "price": 1111110,
    "shrimpPriceDate": "2019-07-09T03:28:20.201Z",
    "createdAt": "2019-12-24T04:13:37.972Z",
    "updatedAt": "2019-12-24T04:13:37.972Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da75",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c3",
    "shrimpSizeId": "5dfa477233cf6523d0a0ba1f",
    "price": 142,
    "shrimpPriceDate": "2019-12-13T08:32:20.201Z",
    "createdAt": "2019-12-24T04:13:37.963Z",
    "updatedAt": "2019-12-24T04:13:37.963Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da74",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c3",
    "shrimpSizeId": "5dfa475e33cf6523d0a0ba1d",
    "price": 99,
    "shrimpPriceDate": "2019-12-13T08:32:20.201Z",
    "createdAt": "2019-12-24T04:13:37.953Z",
    "updatedAt": "2019-12-24T04:13:37.953Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da73",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c4",
    "shrimpSizeId": "5dfa475e33cf6523d0a0ba1d",
    "price": 122,
    "shrimpPriceDate": "2019-12-13T08:32:20.201Z",
    "createdAt": "2019-12-24T04:13:37.942Z",
    "updatedAt": "2019-12-24T04:13:37.942Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da72",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c0",
    "shrimpSizeId": "5e00f85f48200e00a8147936",
    "price": 150,
    "shrimpPriceDate": "2019-11-26T07:45:20.201Z",
    "createdAt": "2019-12-24T04:13:37.931Z",
    "updatedAt": "2019-12-24T04:13:37.931Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019071c7480b1bf8b0da71",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c1",
    "shrimpSizeId": "5dfa476d33cf6523d0a0ba1e",
    "price": 185,
    "shrimpPriceDate": "2019-11-26T07:45:20.201Z",
    "createdAt": "2019-12-24T04:13:37.912Z",
    "updatedAt": "2019-12-24T04:13:37.912Z",
    "__v": 0
  }),
  ShrimpPrice.fromMap({
    "_id": "5e019070c7480b1bf8b0da70",
    "shrimpTypeId": "5dc80560f0dde7da1a8822c0",
    "shrimpSizeId": "5dfa477233cf6523d0a0ba1f",
    "price": 250,
    "shrimpPriceDate": "2019-11-26T07:45:20.201Z",
    "createdAt": "2019-12-24T04:13:36.851Z",
    "updatedAt": "2019-12-24T04:13:36.851Z",
    "__v": 0
  }),
];

final shrimpTypes = [
  ShrimpType.fromMap({
    "_id": "5dc80560f0dde7da1a8822c0",
    "shrimpTypeName": "Tép bạc",
    "shrimpTypeDescription": "",
    "createdAt": null,
    "updatedAt": null
  }),
  ShrimpType.fromMap({
    "_id": "5dc80560f0dde7da1a8822c1",
    "shrimpTypeName": "Tôm thẻ",
    "shrimpTypeDescription": "",
    "createdAt": null,
    "updatedAt": null
  }),
  ShrimpType.fromMap({
    "_id": "5dc80560f0dde7da1a8822c2",
    "shrimpTypeName": "Tôm càng xanh",
    "shrimpTypeDescription": "",
    "createdAt": null,
    "updatedAt": null
  }),
  ShrimpType.fromMap({
    "_id": "5dc80560f0dde7da1a8822c3",
    "shrimpTypeName": "Tôm đất",
    "shrimpTypeDescription": "",
    "createdAt": null,
    "updatedAt": null
  }),
  ShrimpType.fromMap({
    "_id": "5dc80560f0dde7da1a8822c4",
    "shrimpTypeName": "Tôm sú",
    "shrimpTypeDescription": "",
    "createdAt": null,
    "updatedAt": null
  })
];

final shrimpSizes = [
  ShrimpSize.fromMap({
    "_id": "5e00f8de2bf4bc115ca19a41",
    "shrimpSizeQuantity": "80",
    "shrimpSizeUnit": "con/kg",
    "createdAt": "2019-12-23T17:26:54.913Z",
    "updatedAt": "2019-12-23T17:26:54.913Z",
    "__v": 0,
    "shrimpTypeImage": null
  }),
  ShrimpSize.fromMap({
    "_id": "5e12d28cfa17e721bc180cc8",
    "shrimpSizeQuantity": "12",
    "shrimpSizeUnit": "con/kg",
    "updatedAt": "2019-12-23T17:26:54.913Z",
    "createdAt": "2019-12-23T17:26:54.913Z",
    "__v": 0,
    "shrimpTypeImage": null
  }),
  ShrimpSize.fromMap({
    "_id": "5e00f85f48200e00a8147936",
    "shrimpSizeQuantity": "15-20",
    "shrimpSizeUnit": "con/kg",
    "createdAt": "2019-12-23T17:24:47.691Z",
    "updatedAt": "2019-12-23T17:24:47.691Z",
    "__v": 0,
    "shrimpTypeImage": null
  }),
  ShrimpSize.fromMap({
    "_id": "5e00f8b342fcc316f412bf0f",
    "shrimpSizeQuantity": "32",
    "shrimpSizeUnit": "kg",
    "shrimpTypeImage": null,
    "createdAt": "2019-12-23T17:24:47.691Z",
    "updatedAt": "2020-01-06T06:26:04.033Z",
    "__v": 1
  }),
  ShrimpSize.fromMap({
    "_id": "5e00f81e48200e00a8147935",
    "shrimpSizeQuantity": "6-15",
    "shrimpSizeUnit": "con/kg",
    "createdAt": "2019-12-23T17:23:42.566Z",
    "updatedAt": "2019-12-23T17:23:42.566Z",
    "__v": 0,
    "shrimpTypeImage": null
  }),
  ShrimpSize.fromMap({
    "_id": "5dfa477533cf6523d0a0ba20",
    "shrimpSizeQuantity": "40",
    "shrimpSizeUnit": "con/kg",
    "shrimpTypeImage": null,
    "createdAt": "2019-12-18T15:36:21.852Z",
    "updatedAt": "2019-12-18T15:36:21.852Z",
    "__v": 0
  }),
  ShrimpSize.fromMap({
    "_id": "5dfa477233cf6523d0a0ba1f",
    "shrimpSizeQuantity": "50",
    "shrimpSizeUnit": "con/kg",
    "shrimpTypeImage": null,
    "createdAt": "2019-12-18T15:36:18.843Z",
    "updatedAt": "2019-12-18T15:36:18.843Z",
    "__v": 0
  }),
  ShrimpSize.fromMap({
    "_id": "5dfa476d33cf6523d0a0ba1e",
    "shrimpSizeQuantity": "20",
    "shrimpSizeUnit": "con/kg",
    "shrimpTypeImage": null,
    "createdAt": "2019-12-18T15:36:13.801Z",
    "updatedAt": "2019-12-18T15:36:13.801Z",
    "__v": 0
  }),
  ShrimpSize.fromMap({
    "_id": "5dfa475e33cf6523d0a0ba1d",
    "shrimpSizeQuantity": "100",
    "shrimpSizeUnit": "con/kg",
    "shrimpTypeImage": null,
    "createdAt": "2019-12-18T15:35:58.462Z",
    "updatedAt": "2019-12-18T15:35:58.462Z",
    "__v": 0
  })
];

class PricePage extends StatelessWidget {
  Widget titleNotification() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.85],
          colors: [
            Color(0xFF14808C),
            Color(0xff79CCD3),
          ],
        ),
      ),
      child: Center(
        child: Text(
          "Giá tôm hiện nay đang tăng cao theo nhu cầu thị hiếu của thị trường...",
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget subTitleNotification() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              'gia tom hien nay...',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              'gia tom hien nay...',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Giá cả')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...shrimpTypes.map(
              (type) => ListViewLabel(
                title: type.shrimpTypeName,
                items: priceListItems(context, prices, shrimpSizes, type),
                shows: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ShrimpSize sizeFromPrice(List<ShrimpSize> sizes, ShrimpPrice price) {
    return sizes.firstWhere((size) => size.id == price.sizeId);
  }

  List<ShrimpPrice> pricesFromType(List<ShrimpPrice> prices, ShrimpType type) {
    return prices.where((price) => price.typeId == type.id).toList();
  }

  List<ShrimpPrice> pricesFromSize(List<ShrimpPrice> prices, ShrimpSize size) {
    return prices.where((price) => price.sizeId == size.id).toList();
  }

  List<ShrimpPrice> pricesFromSizeAndType(
      List<ShrimpPrice> prices, ShrimpSize size, ShrimpType type) {
    final first = pricesFromSize(prices, size);
    final result = pricesFromType(first, type);
    return result;
  }

  List<Widget> priceListItems(
    BuildContext context,
    List<ShrimpPrice> prices,
    List<ShrimpSize> sizes,
    ShrimpType type,
  ) {
    final List<ShrimpPrice> _prices = pricesFromType(prices, type);
    return _prices.map((price) {
      final sizeFPrice = sizeFromPrice(sizes, price);
      return Column(
        children: <Widget>[
          GestureDetector(
            child: ListTileCustom(
              leading: ShrimpSizeIcon(40,
                  min: num.tryParse(sizeFPrice.shrimpSizeQuantity),
                  max: num.tryParse(sizeFPrice.shrimpSizeQuantity)),
              leftChild: sizeFPrice.toString(),
              rightChild: '${price.price}.000đ',
            ),
            onTap: () {
              final ShrimpSize size = sizeFPrice;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => DetailPrice(
                    size: size,
                    prices: pricesFromSizeAndType(prices, size, type),
                    type: type,
                  ),
                ),
              );
            },
          ),
          Divider(
            color: Colors.grey[400],
            height: 4.0,
          )
        ],
      );
    }).toList();
  }
}
