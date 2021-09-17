import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
   void _setFavValue(bool newValue){
     isFavorite = newValue;
     notifyListeners();
   }

 Future <void> toggleFavoriteStatus(String token,String userId) async {
     final oldstatus =isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shopapp-2cba2-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

try{
  final response = await http.put(
    url,
    body:jsonEncode(
      isFavorite,)
    );
    if (response.statusCode>= 400){
    _setFavValue(oldstatus); 
    }

}catch(error){
  _setFavValue(oldstatus); 
    
}
  }
}
