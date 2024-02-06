import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late DateTime _selectedDate;
  late Color _selectedColor;

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
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
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
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Widgets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(7.0) ,
        child: Column(
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Date"),
              TextButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select Date'),
              )
            ]
          ),
          Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
          SizedBox(height: 20),
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
            child: Text('Pick and Open File'),
          ),
          )
        ],
      ),
    ),
    ); 
  }
   void _pickFile() async{
      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result==null) return;
      final file = result.files.first;
      _openFile(file); 
    }
   void _openFile(PlatformFile file){
      OpenFile.open(file.path!);
    }
}
