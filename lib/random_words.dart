import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return new Divider();
      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final _alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
      onLongPress: () {
        setState(() {
          _saved.clear();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var title = "Startup Name Generator";
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
            title: new Text(pair.asPascalCase, style: _biggerFont));
      });
      final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}

class SavedList extends StatefulWidget{

  var _saved;

  SavedList(this._saved);

  @override
  State<StatefulWidget> createState() {
    return new SaveListState();
  }

}

class SaveListState extends State<SavedList>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Saved Suggestions')),
      body: new ListView(children: _buildChildren(context))
    );
  }

  _buildChildren(BuildContext context) {
    return widget._saved.map((pair){
      return ListTile(title: new Text(pair.asPascalCase, style: new TextStyle(fontSize: 18)));
    });
  }
}
