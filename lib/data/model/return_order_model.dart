class ReturnOrder {
  int index;
  int id;
  int quantity;
  double price;
  double total;
  double tax;
  int order_quantity;
  double return_price;
  bool has_variation;
  String variation_id;
  String variation_names;

  ReturnOrder({required this.index, required this.id,required this.quantity,required this.price,required this.has_variation, required this.order_quantity, required this.return_price, required this.tax, required this.total, required this.variation_id, required this.variation_names });
}