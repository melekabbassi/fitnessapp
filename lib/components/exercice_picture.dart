import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExercicePicture extends StatelessWidget {
  const ExercicePicture({
    super.key,
    required this.category,
    required this.imageUrl,
    required this.pictureName,
    required this.onUpload,
  });

  final String category;
  final String? imageUrl;
  final String? pictureName;
  final void Function(String imageUrl) onUpload;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 400,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Text("No Image"),
                  ),
                ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
          ),
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image == null) return;
            final imageExtension = image.path.split('.').last.toLowerCase();
            final imageBytes = await image.readAsBytes();
            final imagePath = '/$category/$pictureName';
            await supabase.storage
                .from('exercice_pics')
                .uploadBinary(imagePath, imageBytes,
                    fileOptions: FileOptions(
                      upsert: true,
                      contentType: 'image/$imageExtension',
                    ));
            String imageUrl =
                supabase.storage.from('exercice_pics').getPublicUrl(imagePath);
            imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
              't': DateTime.now().millisecondsSinceEpoch.toString()
            }).toString();
            onUpload(imageUrl);
          },
          child: const Text("Upload", style: TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}
