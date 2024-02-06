import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:prioritas1/page/GaleryScreen.dart';
import '../provider/theme_Provider.dart';

class MaterialScreen extends StatefulWidget {
  @override
  _MaterialScreenState createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
final List<Map<String, dynamic>> _data1 = [    {'name': 'Leanne Graham', 'number': '1-770-736-8031 x56442'},    {'name': 'Ervin Howell', 'number': '010-692-6593 x09125'},    {'name': 'Clementine Bauch', 'number': '1-463-123-4447'},    {'name': 'Patricia Lebsack', 'number': '493-170-9623mx156'},    {'name':'Chelsey Dietrich','number':'(254)954-1289'},    {'name':'Mrs. Dennis Schulist','number':'1-477-935-8478 x6430'},    {'name':'Kurtis Weissnat','number':'210.067.6132'}  ];
final List<Map<String, dynamic>> _data = [ ];

final _nameController = TextEditingController();
final _numberController = TextEditingController();
TextEditingController fileController = TextEditingController();
late DateTime _selectedDate;
late Color _selectedColor;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedColor = Colors.orange;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  
  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: Column(
           children: [ Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ElevatedButton(
                      child: Text('Gallery'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                              return ScaleTransition(
                                scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                                child: child,
                              );
                            },
                            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                              return GalleryScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Text('Settings'),
                  ),
                ],),
                
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.app_shortcut_outlined
                ),const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Create New Contacts',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  "A dialog is a type of modal window that appears in\n front of app content to provide critical information, or \n prompt for a decision to be made"),
               const SizedBox(height: 15.0),
               TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Insert Your name',
                    fillColor:  Color(0xFFE7E0EC),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                     hintText: '+62.....',
                    fillColor:  Color(0xFFE7E0EC),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                  ),
                ),
                 Padding(
                          padding: const EdgeInsets.all(7.0) ,
                          child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start ,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                const Text("Date"),
                                TextButton(
                                  onPressed: () => _selectDate(context),
                                  child: const Text('Select Date'),
                                )
                              ]
                            ),
                            Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
                            const SizedBox(height: 20),
                            const Text('color'),
                            const SizedBox(height: 10),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: _selectedColor,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center( 
                              child: ElevatedButton(
                              onPressed: _selectColor,
                              child: const Text('Pick Color'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedColor,// warna latar belakang
                              )
                            ),),
                            const SizedBox(height: 20),
                            const Text('Pick Files'),
                            const SizedBox(height: 10),
                            Center(
                            child:ElevatedButton(
                              onPressed: (){
                                _pickFile();
                              },
                              child: const Text('Pick File'),
                            ),
                            ),
                          ],
                        ),
                      ),
                      if (fileController.text != null)
                      Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              fileController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                        final name = _nameController.text;
                        final number = _numberController.text;
                        final date = _selectedDate;
                        final color = _selectedColor;
                        final pathImage = fileController.text;
                        setState(() {
                          _data.add({
                            'name': name,
                            'number': number,
                            'date': date,
                            'color': color,
                            'path': pathImage
                          });
                          _nameController.clear();
                          _numberController.clear();
                          fileController.clear();
                        });
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6750A4), // warna latar belakang
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // nilai radius yang diinginkan
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16.0),
            ListView.builder(
            itemCount: _data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              
              return ListTile(
                leading: CircleAvatar(
                    radius: 35,
                    backgroundColor: _data[index]['color'] ?? const Color(0xFFEADDFF),
                    child: _data[index]['path'] != ''
                        ? ClipOval(
                            child: Image.file(
                              File(_data[index]['path']),
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : Text(
                            _data[index]['name']?[0] ?? "A",
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF21005D),
                            ),
                          ),
                  ),
                
                title: Text(_data[index]['name']!),
                subtitle: Text(_data[index]['number']!),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children:[
                        Flexible(
                          child:Row(
                        children:[
                        IconButton(
                          iconSize: 20,
                        icon: const Icon(Icons.edit),
                        onPressed: (){
                          _showEditDialog(context, index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 20,
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Contact'),
                              content: const Text('Are you sure you want to delete this contact?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _data.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ], 
                            ),
                          );
                        },
                      )
                      ]
                      ),
                      ),
                      Flexible(child:
                      Text(DateFormat('dd-MM-yyyy').format(_data[index]['date']??DateTime.now())), 
                  ),]),
                    ],
                  ),
                ),
              );

            },
          ),
           ],
          ),
          
      ),
    );
  }
  void _showEditDialog(BuildContext context, int index) {
  final nameController = TextEditingController(text: _data[index]['name']);
  final numberController =
      TextEditingController(text: _data[index]['number']);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _data[index]['name'] = nameController.text;
                _data[index]['number'] = numberController.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
void _pickFile() async{
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result==null) return;
     final file = result.files.first.path;     
     setState(() {
      fileController.text = file.toString();
    });    
    }
}