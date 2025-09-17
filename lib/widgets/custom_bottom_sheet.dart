import 'package:ahwa_app_new/models/order_model.dart';
import 'package:ahwa_app_new/screens/pending_screen.dart';
import 'package:ahwa_app_new/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

// Define the drinks list globally
List<Order> drinks = [];

Future<dynamic> customBottom(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController drinkController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  return showModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: 300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add your drink!'),
              SizedBox(height: 20),
              CustomFormField(
                hintText: 'Name',
                labelText: 'Enter Your Name',
                controller: nameController,
              ),
              SizedBox(height: 10),
              CustomFormField(
                hintText: 'Drink',
                labelText: 'Enter Your Drink',
                controller: drinkController,
              ),
              SizedBox(height: 10),
              CustomFormField(
                hintText: 'Notes',
                labelText: 'Enter Notes',
                controller: notesController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  drinks.add(
                    Order(
                      nameController.text,
                      drinkController.text,
                      notesController.text,
                      isCompleted: false,
                    ),
                  );
                  nameController.clear();
                  drinkController.clear();
                  notesController.clear();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PendingScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Drink added successfully!')),
                  );
                },
                child: Text('Add Drink'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
