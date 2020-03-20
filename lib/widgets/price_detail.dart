import 'package:flutter/material.dart';
import '../components/shrimp_size_icon.dart';
import '../models/ShrimpSize.dart';
import '../models/ShrimpType.dart';
import '../models/ShrimpPrice.dart';

class DetailPrice extends StatefulWidget {
  final ShrimpSize size;
  final ShrimpType type;
  final List<ShrimpPrice> prices;

  DetailPrice({this.size, this.type, this.prices});

  @override
  _DetailPriceUIState createState() => _DetailPriceUIState();
}

class _DetailPriceUIState extends State<DetailPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Giá cả chi tiết')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            detailTitle(),
            ...widget.prices.map(
              (price) => Column(
                children: <Widget>[
                  _listTitle(price),
                  _listItem(price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTitle(ShrimpPrice price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(24, 6, 6, 6),
      color: Color(0xFFECFCFE),
      child: Text(
        '${price.shrimpPriceDate.day}-${price.shrimpPriceDate.month}-${price.shrimpPriceDate.year}',
        style: TextStyle(
            color: Color(
              0xFF14808C,
            ),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _listItem(ShrimpPrice price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(24, 6, 6, 6),
      child: Text(
        '${price.price}.000 đồng',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget detailTitle() {
    int min, max;
    min = max = num.tryParse(widget.size.shrimpSizeQuantity);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ShrimpSizeIcon(
                150,
                min: min,
                max: max,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'GIÁ ' + widget.type.shrimpTypeName.toUpperCase(),
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'LOẠI ' +
                  widget.size.shrimpSizeQuantity.toUpperCase() +
                  ' ' +
                  widget.size.shrimpSizeUnit.toUpperCase(),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ],
    );
  }
}
