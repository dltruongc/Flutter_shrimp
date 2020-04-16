import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

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

  Future<String> getCurrentLocation() async {
    // find current location
    final Location location = Location();
    LocationData locationData = await location.getLocation();
    String addressString;

    try {
      List<Address> addressData =
          await fetchAddress(locationData.latitude, locationData.longitude);
      Address address = addressData.first;
      addressString =
          '${address.featureName}, ${address.subAdminArea}, ${address.adminArea}';
    } catch (e) {
      addressString = 'Việt nam';
    }
    return addressString;
  }
}
