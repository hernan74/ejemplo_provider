import 'package:ejemplo_provider/provider/stream_provider.dart';
import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  StreamProvider stream;
  int valor = 0;
  TextStyle style=TextStyle(fontSize: 30,fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    stream = new StreamProvider();
  }

  @override
  void dispose() {
    super.dispose();
    stream.disposeStreams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Straeam'),
      ),
      body: Center(
        child: StreamBuilder(
            stream: stream.numerosStream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString(),style: style,);
              } else {
                return Text(valor.toString(),style: style,);
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          valor++;
          stream.numerosSink(valor);
        },
      ),
    );
  }
}
