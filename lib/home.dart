import 'package:flutter/material.dart';
import 'car.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _years = 1;
  String totalPrice = cars.first.getTotalPrice(); // holds total car price
  Car car = cars.first; // set the first car to be displayed
  bool _insurance = false;

  void updateCar(Car car) {
    // updates car price when the user selects a car form the dropdown
    setState(() {
      this.car = car;
      car.warranty = _years;
      car.insurance = _insurance;
      totalPrice = car.getTotalPrice();
    });
  }

  void updateWarranty(int warranty){
    setState(() {
      _years = warranty;
      car.warranty = warranty;
      totalPrice = car.getTotalPrice();
    });
  }

  void updateInsurance(bool val){
    setState(() {
      _insurance = val;
      car.insurance = val;
      totalPrice = car.getTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
              const SizedBox(height: 20.0),
              const Text("Select Model", style: TextStyle(fontSize: 25.0),),
              const SizedBox(height: 10.0),
              DropdownMenu(
                  dropdownMenuEntries: cars.map<DropdownMenuEntry<Car>>((Car car){
                    return DropdownMenuEntry(value: car, label: car.toString());
                  }).toList(),
                  width: 200.0,
                  initialSelection: cars.first,
                  onSelected: (Car? car){
                     updateCar(car as Car);
                  },
              ),
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Warranty', style: TextStyle(fontSize: 25.0),),
                  Radio(value: 1, groupValue: _years, onChanged: (int? val){updateWarranty(val as int);}),
                  Text('1 year', style: TextStyle(fontSize: 25.0),),
                  Radio(value: 5, groupValue: _years, onChanged: (int? val){updateWarranty(val as int);}),
                  Text('5 years', style: TextStyle(fontSize: 25.0),),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Insurance ?", style: TextStyle(fontSize: 25.0),),
                  Checkbox(value: _insurance, onChanged: (bool? val){ updateInsurance(val as bool);})
                ],
              ),
              const SizedBox(height: 10.0),
              Text('Total Price: $totalPrice', style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            ])));
  }
}
