class ShoppingCart {
  String item;
  bool selected;

  ShoppingCart({this.item = "", this.selected = false});

  List<ShoppingCart> addCart(List<String> itemsList) {
    List<ShoppingCart> addCart = [];

    for (var item in itemsList) {
      addCart.add(ShoppingCart(item: item));
    }

    return addCart;
  }
}
