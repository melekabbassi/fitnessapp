import 'package:fitnessapp/components/exercice_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PecsTab extends StatefulWidget {
  const PecsTab({super.key});

  @override
  State<PecsTab> createState() => _PecsTabState();
}

class _PecsTabState extends State<PecsTab> {
  final _pecsExercicesStream = Supabase.instance.client
      .from('exercices')
      .stream(primaryKey: ['id']).eq('category', 'pecs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _pecsExercicesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final exercices = snapshot.data!;
          return ListView.builder(
            itemCount: exercices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Text(exercices[index]['name']),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        // change favorite to true if false and vice versa
                        final favorite = exercices[index]['favorite'];
                        await Supabase.instance.client
                            .from('exercices')
                            .update({'favorite': !favorite}).eq(
                                'id', exercices[index]['id']);
                      },
                      // if favorite is true, show filled star, else show empty star
                      icon: exercices[index]['favorite']
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.lightGreenAccent,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.lightGreenAccent,
                            ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
    // return Scaffold(
    //   body: ListView.builder(
    //     itemCount: 10,
    //     itemBuilder: (context, index) {
    //       return const ExerciceCard();
    //     },
    //   ),
    // );
  }
}
