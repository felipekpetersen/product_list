const EDIT_PRODUCT_ROUTE = "/editproduct";

extension PriceDouble on double {
  String toPrice() {
    var price = this.toStringAsFixed(2);
    return "\$ $price";
  }
}
