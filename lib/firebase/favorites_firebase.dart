class FavoritesFirebase{
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  
  CollectionReference? _favoritesCollection;
  
  FavoritesFirebase(){
    _favoritesCollection = _firebase.collection('favoritos');
  }
  
  String<QuerySnapshot> getAllFavorites() {
  
  }
}
