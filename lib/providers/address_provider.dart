import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> addresses;

  AddressProvider({this.addresses});

  Future<List<Address>> fetchAddress(latitude, longitude) async {
    Coordinates coordinate = Coordinates(latitude, longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinate);
    this.addresses = addresses;
    notifyListeners();
    return addresses;
  }
}
