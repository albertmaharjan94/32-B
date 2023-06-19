import 'package:flutter/material.dart';
import 'package:my_first_app/models/ProductModel.dart';
import 'package:my_first_app/repositories/ProductRepository.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  Future<void> updateProduct() async {
    try{
      final data = ProductModel(
        name: name.text,
        price: double.parse(price.text)
      );
      await ProductRepository().updateProduct(id.toString(), data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data saved")));
    }catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  String? id;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if(arguments!=null){
        setState(() {
          id = arguments.toString();
        });
        fillData(arguments.toString());
      }
    });
    super.initState();
  }
  void fillData(String id) async{
    final response = await ProductRepository().getOneProduct(id);
    name.text = response!.name.toString();
    price.text = response!.price.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a product"),),
      body: Column(
        children: [
          TextFormField(controller: name,),
          TextFormField(controller: price,),
          ElevatedButton(onPressed: (){
            updateProduct();
          }, child: Text("Save Product"))
        ],
      ),
    );
  }
}
