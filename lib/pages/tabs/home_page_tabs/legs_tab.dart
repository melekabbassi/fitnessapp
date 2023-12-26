import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LegsTab extends StatefulWidget {
  const LegsTab({super.key});

  @override
  State<LegsTab> createState() => _LegsTabState();
}

class _LegsTabState extends State<LegsTab> {
  final _legsExercicesStream = Supabase.instance.client
      .from('legs_exercices')
      .stream(primaryKey: ['id']).order('id', ascending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _legsExercicesStream,
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
                    Image.network(
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
                            // when the user clicks on the favorite button create a new row in the legs_favorites table
                            // with the exercice id and the user id
                            final response = await Supabase.instance.client
                                .from('fav_legs_exercices')
                                .insert([
                              {
                                'user_id': Supabase
                                    .instance.client.auth.currentUser?.id,
                                'legs_exercice_id': exercices[index]['id'],
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
    );
  }
}
