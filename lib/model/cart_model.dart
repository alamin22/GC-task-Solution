class CartModel{
   String name;
   int discount;
   int qty;
   CartModel({
    required this.name, 
    required this.discount,
    required this.qty,
  });
  //constructor that convert json to object instance
  CartModel.fromJson(Map<String, dynamic> json) : name = json['name'], discount = json['discount'],qty = json['qty'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'discount': discount,
    'qty': qty,
  };
}
List arrData = [];