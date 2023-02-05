import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = TextEditingController(); // we want the image url instantly to preview

  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      var value = _imageUrlController.text;
      if (!value.startsWith('http')) return;
      if (!value.endsWith('.png') && !value.endsWith('.jpg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();
    Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    // FocusNodes have to be disposed!
    // Listeners have to be removed!
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_priceFocusNode),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please provide a title';
                    return null;
                  },
                  // war gar nicht notwendig?
                  onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price (€)'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter a price';
                    var val = double.tryParse(value);
                    if (val == null || val <= 0) return 'Please provide a valid number > 0';
                    return null;
                  },
                  onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  // textInputAction: TextInputAction.newline, automatisch bei multiline
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please provide a description';
                    if (value.length < 10) return 'Please provide a description with at least 10 letters';
                    return null;
                  },
                  onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value!,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text(
                              'Enter a URL',
                              textAlign: TextAlign.center,
                            )
                          : ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Please provide a image url';
                          if (!value.startsWith('http')) return 'Please provide a valid url';
                          if (!value.endsWith('.png') && !value.endsWith('.jpg')) {
                            return 'Please provide a valid url for png or jpg';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) => _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value!),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}