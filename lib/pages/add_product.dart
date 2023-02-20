import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _referenceController = TextEditingController();
  final _labelController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  Future<void> _addProduct() async {
    final url = Uri.parse(
        'https://ilatouba.with6.dolicloud.com/api/index.php/products');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'DOLAPIKEY': 'qChcqtpDdG9X',
      },
      body: {
        'ref': _referenceController.text,
        'label': _labelController.text,
        'price': _sellingPriceController.text,
        'cost_price': _purchasePriceController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _referenceController,
              decoration: const InputDecoration(
                labelText: 'Reference',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a reference';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(
                labelText: 'Label',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a label';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _purchasePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a purchase price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _sellingPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Selling Price',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a selling price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addProduct();
                }
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
