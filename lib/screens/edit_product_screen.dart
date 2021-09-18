import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit_product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0.0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'), actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            _saveForm();
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: '',
                    title: value!,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please, enter a title';
                  } else {
                    return null;
                  }

                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      price: double.parse(value!),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
              validator: (value) {
                    if(value!.isEmpty){
                      return 'Please, enter a price.';
                    }
                    if (double.tryParse(value) == null){
                      return 'Please, enter a valid number.';
                    }
                    if(double.parse(value) <= 0 ){
                      return 'Please, enter a correct price.';
                    }
                    return null;
              },),
              TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value!,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  },
              validator: (value) {
                    if (value!.isEmpty){
                      return 'Please, enter a description';
                    }
                    return null;
              },),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text(
                            'Enter a URL',
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        focusNode: _imageUrlFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) => _saveForm(),
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: '',
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: value!,
                          );
                        },
                    validator: (value){
                          if (value!.isEmpty){
                            return 'Please, enter an image URL';
                          }
                          if (!value.startsWith('https') && !value.startsWith('http')){
                            return 'Please, enter a valid URL';
                          }
                          if (!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')){
                            return 'Please enter a valid image URL';
                          }
                          return null;
                    },),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
