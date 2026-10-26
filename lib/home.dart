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

  void updateWarranty(int warranty) {
    setState(() {
      car.warranty = warranty;
      totalPrice = car.getTotalPrice();
    });
  }

  void updateInsurance(bool val) {
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
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Text("Select Car Model", style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            MyDropdownMenu(updateCar: updateCar),
            const SizedBox(height: 20.0),
            WarrantyWidget(updateWarranty: updateWarranty, car: car),
            const SizedBox(height: 20.0),
            InsuranceWidget(updateInsurance: updateInsurance, car: car),
            const SizedBox(height: 10.0),
            Text(
              'Total Price: $totalPrice',
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDropdownMenu extends StatelessWidget {
  final Function(Car) updateCar;
  const MyDropdownMenu({required this.updateCar, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: cars.map<DropdownMenuEntry<Car>>((Car car) {
        return DropdownMenuEntry(value: car, label: car.toString());
      }).toList(),
      width: 250.0,
      initialSelection: cars.first,
      onSelected: (Car? car) {
        updateCar(car as Car);
      },
    );
  }
}

/**
 * Warranty custom widget
 */
class WarrantyWidget extends StatelessWidget {
  final Function(int) updateWarranty;
  final Car car;
  const WarrantyWidget({
    required this.updateWarranty,
    required this.car,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<int>(
      groupValue: car.warranty,
      onChanged: (int? val) {
        updateWarranty(val as int);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Warranty', style: TextStyle(fontSize: 25.0)),
          Radio<int>(value: 1),
          Text('1 year', style: TextStyle(fontSize: 25.0)),
          Radio<int>(value: 5),
          Text('5 years', style: TextStyle(fontSize: 25.0)),
        ],
      ),
    );
  }
}

/**
 * This is the Insurance custom widget
 */
class InsuranceWidget extends StatelessWidget {
  final Function(bool) updateInsurance;
  final Car car;
  const InsuranceWidget({
    required this.updateInsurance,
    required this.car,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Insurance ?", style: TextStyle(fontSize: 25.0)),
        Checkbox(
          value: car.insurance,
          onChanged: (bool? val) {
            updateInsurance(val as bool);
          },
        ),
      ],
    );
  }
}
