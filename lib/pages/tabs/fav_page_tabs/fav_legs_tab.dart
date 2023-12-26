import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavLegsTab extends StatefulWidget {
  const FavLegsTab({super.key});

  @override
  State<FavLegsTab> createState() => _FavLegsTabState();
}

class _FavLegsTabState extends State<FavLegsTab> {
  final _favLegsExercicesStream = Supabase.instance.client
      .from('fav_legs_exercices')
      .stream(primaryKey: ['id']).order('id', ascending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _favLegsExercicesStream,
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
                                  // when the user clicks on the favorite button delete the row in the fav_legs_exercices table
                                  // with the exercice id and the user id
                                  final response = await Supabase
                                      .instance.client
                                      .from('fav_legs_exercices')
                                      .delete()
                                      .eq('id', exercices[index]['id']);
                                  if (response.error == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Exercise removed from favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.favorite),
                                color: Colors.lightGreenAccent,
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
