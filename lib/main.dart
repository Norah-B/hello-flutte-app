import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Startup Name Generator', home: RandomWords(), theme: new ThemeData(primaryColor: Colors.yellow,));
  }
}

class RandomWordsState extends State<RandomWords> {
  // TODO Add build() method
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushFavs),
        ],
      ),
      body: _buildRandomWords(),
    );
  }

  final List<WordPair> _randomWords = <WordPair>[];
  final Set<WordPair> _fav = new Set<WordPair>();
  final _fontSize = const TextStyle(fontSize: 18.0);
  Widget _buildRow(WordPair pair) {
    final bool inFav = _fav.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: _fontSize),
        trailing: new Icon(
          inFav ? Icons.favorite : Icons.favorite_border,
          color: inFav ? Colors.red : null, //Colors.transparent
        ),
        onTap: () {
          setState(() {
            if (inFav) {
              _fav.remove(pair);
            } else {
              _fav.add(pair);
            }
          });
        });
  }

  Widget _buildRandomWords() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _randomWords.length) {
            _randomWords.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWords[index]);
        });
  }

  void _pushFavs() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _fav.map((WordPair pair) {
        return new ListTile(
          title: new Text(pair.asPascalCase, style: _fontSize),
        );
      });
      final List<Widget> devided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Icon(Icons.favorite),
          centerTitle: true,
        ),
        body: new ListView(children: devided),
      );
    })
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
