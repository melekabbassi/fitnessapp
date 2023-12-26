import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavShouldersTab extends StatefulWidget {
  const FavShouldersTab({super.key});

  @override
  State<FavShouldersTab> createState() => _FavShouldersTabState();
}

class _FavShouldersTabState extends State<FavShouldersTab> {
  final _favShouldersExercicesStream = Supabase.instance.client
      .from('fav_shoulders_exercices')
      .stream(primaryKey: ['id']).order('id', ascending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _favShouldersExercicesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final exercices = snapshot.data!;
          return exercices.isEmpty
              ? const Center(
                  child: Text('No favorites yet'),
                )
              : ListView.builder(
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
                                  // when the user clicks on the favorite button delete the row in the fav_shoulders_exercices table
                                  // with the exercice id and the user id
                                  final response = await Supabase
                                      .instance.client
                                      .from('fav_shoulders_exercices')
                                      .delete()
                                      .eq('id', exercices[index]['id']);
                                  if (response.error == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Exercice removed from favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.favorite,
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
