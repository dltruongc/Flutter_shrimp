import 'package:flutter/material.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/shrimpprice_added_controller.dart';
import 'package:shrimpapp/models/ShrimpPriceAdded.dart';
import '../components/shrimp_size_icon.dart';
import '../components/custom_list_tile.dart';
import '../components/list_view_label.dart';

class PricePageAdded extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();

  PricePageAdded({Key key}) : super(key: key);
}

class _PricePageState extends State<PricePageAdded>
    with AutomaticKeepAliveClientMixin<PricePageAdded> {
  List<ShrimpPriceAdded> prices;

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

  @override
  void initState() {
    super.initState();
    if (prices == null) {
      ShrimpPriceAddedController().fetchAll().then((data) {
        setState(() {
          prices = data;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (prices == null) {
      return LoadingScreen();
    }

    var reg = RegExp(r'[0-9]');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ...prices.map((price) {
            try {
              final type = price.sizeType
                  .substring(0, reg.firstMatch(price.sizeType).start);
              final size = price.sizeType
                  .substring(reg.firstMatch(price.sizeType).start);
              return ListViewLabel(
                title: type,
                items: [
                  priceListItems(context, price, size, type),
                ],
                shows: 3,
              );
            } catch (e) {
              final type = price.sizeType
                  .substring(0, reg.firstMatch(price.sizeType).start);
              final size = price.sizeType
                  .substring(reg.firstMatch(price.sizeType).start);
              return ListViewLabel(
                title: type,
                items: [
                  priceListItems(context, price, size, type),
                ],
                shows: 3,
              );
            }
          }),
        ],
      ),
    );
  }

  Widget priceListItems(
    BuildContext context,
    ShrimpPriceAdded price,
    String size,
    String type,
  ) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: ListTileCustom(
            leading: ShrimpSizeIcon(
              40,
              min: num.tryParse(size),
              max: num.tryParse(size),
            ),
            leftChild: size.toString(),
            rightChild: '${price.price}.000đ',
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => _DetailPrice(
                  size: size,
                  price: price,
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
  }

  @override
  bool get wantKeepAlive => true;
}

class _DetailPrice extends StatefulWidget {
  final String size;
  final String type;
  final ShrimpPriceAdded price;

  _DetailPrice({this.size, this.type, this.price});

  @override
  _DetailPriceUIState createState() => _DetailPriceUIState();
}

class _DetailPriceUIState extends State<_DetailPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Giá cả chi tiết')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            detailTitle(),
            Column(
              children: <Widget>[
                _listTitle(widget.price),
                _listItem(widget.price),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTitle(ShrimpPriceAdded price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(24, 6, 6, 6),
      color: Color(0xFFECFCFE),
      child: Text(
        'Ngày ${price.date.day} tháng ${price.date.month}, ${price.date.year}',
        style: TextStyle(
          color: Color(0xFF14808C),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _listItem(ShrimpPriceAdded price) {
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
    min = max = num.tryParse(widget.size);
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
              'GIÁ ' + widget.type.toUpperCase(),
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'LOẠI ' + widget.size.toUpperCase(),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ],
    );
  }
}
