
// a list of car objects. It is used to populate the items of dropdown widget
List<Car> cars = [
  Car('Honda', 10000),
  Car('Toyota', 20000),
  Car('BMW', 30000),
  Car('Hyundai', 8000)
];

class Car{
  String model;
  int price;
  int warranty = 1; // warranty years, default 1 year
  bool insurance = false;

  Car(this.model, this.price);

  @override
  String toString() {
    return '$model  Price: \$$price';
  }

  String getTotalPrice() {
    /*
    calculate price as follows: if warranty is 1 then 5% else 10%
    if insurance is added, then add 1000 to total price
     */
    int insuranceAmount = insurance ? 1000 : 0;
    if (warranty == 1) {
      return (price * 1.05 + insuranceAmount).toStringAsFixed(0);
    }
    return (price * 1.1 + insuranceAmount).toStringAsFixed(0);
  }
}