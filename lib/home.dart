import 'package:flutter/material.dart';
import 'car.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String totalPrice = cars.first.getTotalPrice(); // holds total car price
  Car car = cars.first; // set the first car to be displayed

  void updateCar(Car car) {
    // updates car price when the user selects a car form the dropdown
    setState(() {
      this.car = car;
      totalPrice = car.getTotalPrice();
    });
  }

  void updateWarranty(int warranty){
    setState(() {
      car.warranty = warranty;
      totalPrice = car.getTotalPrice();
    });
  }

  void updateInsurance(bool val){
    setState(() {
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
              const Text("Select Car Model", style: TextStyle(fontSize: 25.0),),
              const SizedBox(height: 10.0),
              MyDropdownMenu(updateCar: updateCar),
              const SizedBox(height: 20.0),
              Warranty(updateWarranty: updateWarranty, car: car),
              const SizedBox(height: 20.0),
              Insurance(updateInsurance: updateInsurance, car: car,),
              const SizedBox(height: 10.0),
              Text('Total Price: $totalPrice', style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            ])));
  }
}

/**
 * Dropdown custom widget
 */
class MyDropdownMenu extends StatelessWidget {
  final Function(Car) updateCar;
  const MyDropdownMenu({required this.updateCar, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: cars.map<DropdownMenuEntry<Car>>((Car car){
        return DropdownMenuEntry(value: car, label: car.toString());
      }).toList(),
      width: 200.0,
      initialSelection: cars.first,
      onSelected: (Car? car){
        updateCar(car as Car);
      },
    );
  }
}

/**
 * Warranty cutsom widget
 * It can also be implemented as stateless widget ...
 */
class Warranty extends StatefulWidget {
  final Function(int) updateWarranty;
  Car car;
  Warranty({required this.updateWarranty, required this.car, super.key});

  @override
  State<Warranty> createState() => _WarrantyState();
}

class _WarrantyState extends State<Warranty> {
  int _years = 1;

  void changedSelection(int val){
    setState(() {
      this._years = val;
      widget.updateWarranty(this._years);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Warranty', style: TextStyle(fontSize: 25.0),),
        Radio(value: 1, groupValue: widget.car.warranty, onChanged: (int? val){changedSelection(val as int);}),
        Text('1 year', style: TextStyle(fontSize: 25.0),),
        Radio(value: 5, groupValue: widget.car.warranty, onChanged: (int? val){changedSelection(val as int);}),
        Text('5 years', style: TextStyle(fontSize: 25.0),),
      ],
    );
  }
}

/**
 * This is the Insurance custom widget
 */
class Insurance extends StatefulWidget {
  final Function(bool) updateInsurance;
  Car car;
  Insurance({required this.updateInsurance, required this.car, super.key});

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  bool _insurance = false;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Insurance ?", style: TextStyle(fontSize: 25.0),),
        Checkbox(value: widget.car.insurance, onChanged: (bool? val){
          setState(() {
            this._insurance = val as bool;
            widget.updateInsurance(this._insurance);
          });})
      ],
    );
  }
}
