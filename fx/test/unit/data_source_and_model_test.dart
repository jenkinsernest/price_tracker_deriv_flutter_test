import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fx/Model/ActiveSymbol.dart';
import 'package:fx/Model/Ticks.dart';
import 'package:fx/Presenter/Repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  test('Active symbols can be fetched and ensure message type is Active symbol', () {
    Repository repo = new Repository();

    WebSocketChannel channel = repo.connect();

    channel.stream.listen(
          (data) {
        //print(data);
        repo.symbol=ActiveSymbol.fromJson(jsonDecode(data));


        expect(repo.symbol.msgType.toString(), equals("active_symbols"));
      },
      onError: (error) => print(error),
    );


  });



  test('Testing to get Ticks and ensure message type is Ticks', () {
    Repository repo = new Repository();

    WebSocketChannel channel = repo.connect();

    channel.stream.listen(
          (data) {
        //print(data);
        repo.symbol=ActiveSymbol.fromJson(jsonDecode(data));

        WebSocketChannel channel2 = repo.ticks(repo.symbol.activeSymbols.first.displayName);

        channel2.stream.listen(
              (data) {
            //print(data);
              Ticks t=  Ticks.fromJson(jsonDecode(data));

                String p= t.msgType.toString();

                expect(p, equals("tick"));
          },
          onError: (error) => print(error),
        );


      },
      onError: (error) => print(error),
    );


  });

  // NOTE we'll add more tests here later in this lesson
}