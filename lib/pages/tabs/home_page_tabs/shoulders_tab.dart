import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShouldersTab extends StatefulWidget {
  const ShouldersTab({super.key});

  @override
  State<ShouldersTab> createState() => _ShouldersTabState();
}

class _ShouldersTabState extends State<ShouldersTab> {
  final _shouldersExercicesStream = Supabase.instance.client
      .from('shoulders_exercices')
      .stream(primaryKey: ['id']).order('id', ascending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _shouldersExercicesStream,
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
                title: Row(
                  children: [
                    Text(exercices[index]['name']),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        // when the user clicks on the favorite button create a new row in the shoulders_favorites table
                        // with the exercice id and the user id
                        final response = await Supabase.instance.client
                            .from('fav_shoulders_exercices')
                            .insert([
                          {
                            'user_id':
                                Supabase.instance.client.auth.currentUser?.id,
                            'shoulders_exercice_id': exercices[index]['id'],
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
              );
            },
          );
        },
      ),
    );
  }
}
