class Item {
  int? id;
  String prodName;
  double qty;
  double rate;
  double gstPer;
  Item({
    this.id,
    required this.prodName,
    required this.qty,
    required this.rate,
    required this.gstPer,
  });
}