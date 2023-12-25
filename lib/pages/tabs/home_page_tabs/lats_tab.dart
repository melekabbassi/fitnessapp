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
              title: Row(
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
                          'user_id':
                              Supabase.instance.client.auth.currentUser?.id,
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
            );
          },
        );
      },
    ));
  }
}
