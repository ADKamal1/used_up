
import 'package:admin_app/animation/faidAnimation.dart';
import 'package:admin_app/ui/components/custom_button.dart';
import 'package:admin_app/ui/components/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateLineScreen extends StatefulWidget {
  @override
  _CreateLineScreenState createState() => _CreateLineScreenState();
}

class _CreateLineScreenState extends State<CreateLineScreen> {
  final _formKey = GlobalKey<FormState>();
  String _lineName = '';
  String _speciality="";
  String _dist="";
  String _product="";

  List<String>_lineProduct=[];
  List<String> _lineDistribution = [];
  List<String> _lineSpeciality = [];
  List<String> _lineClassification = [];

  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _distController = TextEditingController();
  final TextEditingController _productController = TextEditingController();



  void _addDistribution(String distribution) {
    if (_lineDistribution.contains(distribution)) {
      return;
    }
    setState(() {
      _lineDistribution.add(distribution);
      _distController.clear();
    });
  }

  void _addSpeciality(String speciality) {
    if (_lineSpeciality.contains(speciality)) {
      return;
    }
    setState(() {
      _lineSpeciality.add(speciality);
      _specialityController.clear();
    });
  }

  void _addClassification(String Classification) {
    if (_lineClassification.contains(Classification)) {
      return;
    }
    setState(() {
      _lineClassification.add(Classification);
      //_ClassificationController.clear();
    });
  }

  void _addproduct(String product) {
    if (_lineProduct.contains(product)) {
      return;
    }
    setState(() {
      _lineProduct.add(product);
      _productController.clear();
    });
  }

  void _removeDistribution(String distribution) {
    setState(() {
      _lineDistribution.remove(distribution);
    });
  }

  void _removeClassification(String classification) {
    setState(() {
      _lineClassification.remove(classification);
    });
  }
  void _removeProduct(String product) {
    setState(() {
      _lineProduct.remove(product);
    });
  }

  void _createLine() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    DocumentReference lines = FirebaseFirestore.instance.collection('lines').doc(_lineName);

    try {
      await lines.set({
        'name': _lineName,
        'distribution': _lineDistribution,
        'speciality': _lineSpeciality,
        'classification': _lineClassification,
        'product':_lineProduct,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Line created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating line: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Line'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimation(1.0,
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Line Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a line name.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _lineName = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                FadeAnimation(1.1,Text('classification:')),
                FadeAnimation(
                  1.3, Wrap(
                  spacing: 8.0,
                  children: [
                    _buildclassificationChip('A', Icons.star),
                    _buildclassificationChip('B', Icons.star),
                    _buildclassificationChip('C', Icons.star),
                  ],
                ),
                ),
                SizedBox(height: 16.0),
                FadeAnimation(1.4, Text('Distribution:')),
                FadeAnimation(
                  1.5, TextFormField(
                  controller: _distController,
                  onChanged: (v){
                    setState(() {
                      _dist=v;
                    });
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    suffixIcon: IconButton(

                      color: Colors.greenAccent,
                      icon: Icon(Icons.add_box_sharp,size: 30,opticalSize: 5),
                      onPressed: (){
                        _addDistribution(_dist);

                      },
                    ),
                    iconColor: Colors.green,
                    hintText: 'Enter Distribution',
                  ),
                ),
                ),

                SizedBox(height: 16.0),
                FadeAnimation(1.8, Text('speciality:')),
                FadeAnimation(
                  2, TextFormField(
                  controller: _specialityController,
                  onChanged: (v){
                    setState(() {
                      _speciality=v;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Colors.greenAccent,

                      icon: Icon(Icons.add_box_sharp,size: 30,),
                      onPressed: (){
                        _addSpeciality(_speciality);
                      },
                    ),
                    hintText: 'Enter Speciality',
                  ),
                ),
                ),

                SizedBox(height: 16.0),
                FadeAnimation(2.2, Text("product:")),
                FadeAnimation(
                  2.4, TextFormField(
                  controller: _productController
                  ,
                  onChanged: (v){
                    setState(() {
                      _product=v;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Colors.greenAccent,

                      icon: Icon(Icons.add_box_sharp,size: 30,),
                      onPressed: (){
                        _addproduct(_product);
                      },
                    ),
                    hintText: 'Enter Product',
                  ),
                ),
                ),
                SizedBox(height: 16.0),
                FadeAnimation(
                  2.6, Center(
                  child: ElevatedButton(
                    onPressed: _createLine,
                    child: Text('Create Line'),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistributionChip(String label, IconData icon) {
    return InputChip(
      label: Text(label),
      avatar: Icon(icon),
      backgroundColor: _lineDistribution.contains(label)
          ? Theme.of(context).accentColor
          : Colors.grey.shade300,
      onPressed: () {
        if (_lineDistribution.contains(label)) {
          _removeDistribution(label);
        } else {
          _addDistribution(label);
        }
      },
    );
  }

  Widget _buildclassificationChip(String label, IconData icon) {
    return InputChip(
      label: Text(label),
      avatar: Icon(icon),
      backgroundColor: _lineClassification.contains(label)
          ? Theme.of(context).accentColor
          : Colors.grey.shade300,
      onPressed: () {
        if (_lineClassification.contains(label)) {
          _removeClassification(label);
        } else {
          _addClassification(label);
        }
      },
    );
  }
}