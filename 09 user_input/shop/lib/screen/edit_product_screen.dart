import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    // FocusNodes have to be disposed!
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode), // war gar nicht notwendig?
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  focusNode: _descriptionFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
