import 'package:fitnessapp/components/add_exercice_modal.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LatsTab extends StatefulWidget {
  const LatsTab({super.key});

  @override
  State<LatsTab> createState() => _LatsTabState();
}

class _LatsTabState extends State<LatsTab> {
  final _pecsExercicesStream = Supabase.instance.client
      .from('lats_exercices')
      .stream(primaryKey: ['id']).order('id', ascending: true);

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
            physics: const BouncingScrollPhysics(),
            itemCount: exercices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  children: [
                    exercices[index]['picture'] == null
                        ? const Placeholder(
                            fallbackHeight: 200,
                            fallbackWidth: 400,
                          )
                        : Image.network(
                            exercices[index]['picture'],
                            height: 200,
                            width: 400,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(exercices[index]['name']),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            // when the user clicks on the favorite button create a new row in the pecs_favorites table
                            // with the exercice id and the user id
                            final response = await Supabase.instance.client
                                .from('fav_lats_exercices')
                                .insert([
                              {
                                'user_id': Supabase
                                    .instance.client.auth.currentUser?.id,
                                'lats_exercice_id': exercices[index]['id'],
                                'name': exercices[index]['name'],
                                'picture': exercices[index]['picture'],
                              }
                            ]);
                            if (response.error == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Exercice added to favorites'),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.lightGreenAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 160),
        child: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent,
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddExerciceModal(
                  tableName: 'lats_exercices',
                  category: 'lats',
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
