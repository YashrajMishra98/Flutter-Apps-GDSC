import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Songs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class Song {
  final String title;
  final String artist;

  Song({required this.title, required this.artist});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Song> _songs = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();

  void _addSong() {
    if (_titleController.text.isNotEmpty && _artistController.text.isNotEmpty) {
      setState(() {
        _songs.add(Song(
          title: _titleController.text,
          artist: _artistController.text,
        ));
      });
      _titleController.clear();
      _artistController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddSongDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new song'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Song Title'),
              ),
              TextField(
                controller: _artistController,
                decoration: InputDecoration(labelText: 'Artist'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: _addSong,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite Songs'),
      ),
      body: _songs.isEmpty
          ? Center(child: Text('No songs added yet!'))
          : ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(_songs[index].title),
                  subtitle: Text(_songs[index].artist),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSongDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
