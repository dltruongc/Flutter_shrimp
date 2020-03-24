import 'package:flutter/material.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/shrimpprice_controller.dart';
import 'package:shrimpapp/controllers/shrimpsize_controller.dart';
import 'package:shrimpapp/controllers/shrimptype_controller.dart';
import '../components/shrimp_size_icon.dart';
import '../widgets/price_detail.dart';
import '../components/custom_list_tile.dart';
import '../components/list_view_label.dart';
import '../models/ShrimpPrice.dart';
import '../models/ShrimpSize.dart';
import '../models/ShrimpType.dart';

class PricePage extends StatefulWidget {
  List<ShrimpPrice> prices;
  List<ShrimpType> shrimpTypes;
  List<ShrimpSize> shrimpSizes;
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  List<ShrimpPrice> prices;
  List<ShrimpType> shrimpTypes;
  List<ShrimpSize> shrimpSizes;

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
    if (widget.prices == null) {
      ShrimpPriceController().fetchAll().then((data) {
        widget.prices = data;
        setState(() {
          prices = data;
        });
      });
    }
    if (widget.shrimpSizes == null) {
      ShrimpSizeController().fetchAll().then((data) {
        widget.shrimpSizes = data;
        setState(() {
          shrimpSizes = data;
        });
      });
    }
    if (widget.shrimpTypes == null) {
      ShrimpTypeController().fetchAll().then((data) {
        widget.shrimpTypes = data;
        setState(() {
          shrimpTypes = data;
        });
      });
    }

    if (prices == null || shrimpTypes == null || shrimpSizes == null) {
      return LoadingScreen();
    }

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
