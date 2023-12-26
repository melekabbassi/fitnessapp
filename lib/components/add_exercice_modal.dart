import 'package:fitnessapp/components/exercice_picture.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddExerciceModal extends StatefulWidget {
  const AddExerciceModal({
    Key? key, // Add the missing key parameter
    required this.tableName,
    required this.category,
  }) : super(key: key); // Add the super constructor

  final String tableName;
  final String category;

  @override
  State<AddExerciceModal> createState() => _AddExerciceModalState();
}

class _AddExerciceModalState extends State<AddExerciceModal> {
  final _nameController = TextEditingController();
  String? _imageUrl;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // add Exercice to the table
  Future<void> _addExercice() async {
    final response =
        await Supabase.instance.client.from(widget.tableName).insert([
      {
        'name': _nameController.text,
        'picture': _imageUrl,
      }
    ]);
    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exercice added successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while adding the exercice'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        // Remove the const keyword here
        children: [
          const Text(
            'Add Exercice',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lightGreenAccent,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(color: Colors.lightGreenAccent),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              label: Text('Exercice name'),
            ),
          ),
          const SizedBox(height: 20),
          ExercicePicture(
            imageUrl: _imageUrl,
            pictureName: _nameController.text,
            onUpload: (imageUrl) {
              setState(() {
                _imageUrl = imageUrl;
              });
            },
            category: widget.category,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(150, 45),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
            ),
            onPressed: () async {
              await _addExercice();
              Navigator.of(context).pop();
            },
            child: const Text("Save",
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }
}
