extension PriceDouble on double {
  String toPrice() {
    var price = this.toStringAsFixed(2);
    return "R\$ $price";
  }
}