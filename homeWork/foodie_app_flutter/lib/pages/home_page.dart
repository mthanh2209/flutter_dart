import 'package:flutter/material.dart';
import '../component/food_item.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colors = [Colors.red, Colors.green, Colors.pink, Colors.yellow];
  final _colorNames = ['R', 'G', 'B', 'A'];
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = _colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.yellow),
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          ...List.generate(
            _colors.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = _colors[index];
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.6),
                child: CircleAvatar(
                  backgroundColor: _colors[index],
                  radius: 14.0,
                  child: Text(
                    _colorNames[index],
                    style: const TextStyle(color: Colors.blue, fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Foodies',
                style: TextStyle(color: _selectedColor, fontSize: 32.0),
              ),
              const SizedBox(height: 12.0),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  FoodModel food = foods[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.6),
                    child: FoodItem(
                      onPressed: () => print(food.id),
                      food: food,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodModel {
  int? id;
  String? imageStr;
  String? name;
  String? description;
  double? price;
  int? quantity;

  FoodModel({
    this.id,
    this.imageStr,
    this.name,
    this.description,
    this.price,
    this.quantity,
  });
}

List foods = [
  FoodModel(
      id: 1,
      imageStr: 'assets/images/Food_1.png',
      name: 'Fried Chicken',
      price: 20.0,
      quantity: 2,
      description: 'Golden browse fried chicken'),
  FoodModel(
      id: 2,
      imageStr: 'assets/images/Food_2.png',
      name: 'Cheese Sandwich',
      price: 18.0,
      quantity: 3,
      description: 'Grilled Cheese Sandwich'),
  FoodModel(
      id: 3,
      imageStr: 'assets/images/Food_3.png',
      name: 'Egg Pasta',
      price: 15.0,
      quantity: 1,
      description: 'Spicy Chicken Pasta'),
  FoodModel(
      id: 4,
      imageStr: 'assets/images/Food_1.png',
      name: 'Fried Chicken',
      price: 20.0,
      quantity: 2,
      description: 'Golden browse fried chicken'),
  FoodModel(
      id: 5,
      imageStr: 'assets/images/Food_2.png',
      name: 'Cheese Sandwich',
      price: 18.0,
      quantity: 3,
      description: 'Grilled Cheese Sandwich'),
  FoodModel(
      id: 6,
      imageStr: 'assets/images/Food_3.png',
      name: 'Egg Pasta',
      price: 15.0,
      quantity: 1,
      description: 'Spicy Chicken Pasta'),
  FoodModel(
      id: 7,
      imageStr: 'assets/images/Food_1.png',
      name: 'Fried Chicken',
      price: 20.0,
      quantity: 2,
      description: 'Golden browse fried chicken'),
  FoodModel(
      id: 8,
      imageStr: 'assets/images/Food_2.png',
      name: 'Cheese Sandwich',
      price: 18.0,
      quantity: 3,
      description: 'Grilled Cheese Sandwich'),
  FoodModel(
      id: 9,
      imageStr: 'assets/images/Food_3.png',
      name: 'Egg Pasta',
      price: 15.0,
      quantity: 1,
      description: 'Spicy Chicken Pasta'),
  FoodModel(
      id: 10,
      imageStr: 'assets/images/Food_1.png',
      name: 'Fried Chicken',
      price: 20.0,
      quantity: 2,
      description: 'Golden browse fried chicken'),
  FoodModel(
      id: 11,
      imageStr: 'assets/images/Food_2.png',
      name: 'Cheese Sandwich',
      price: 18.0,
      quantity: 3,
      description: 'Grilled Cheese Sandwich'),
  FoodModel(
      id: 12,
      imageStr: 'assets/images/Food_3.png',
      name: 'Egg Pasta',
      price: 15.0,
      quantity: 1,
      description: 'Spicy Chicken Pasta'),
];
