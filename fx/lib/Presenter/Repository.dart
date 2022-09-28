import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx/Model/ActiveSymbol.dart';
import 'package:fx/Model/Ticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Repository {


  ActiveSymbol symbol;


////// for tesing web sockets and responses ///////////////

  dispose(String id){

    final channel3 = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=32968'),
    );



    Map<String, dynamic> data = new Map<String, dynamic>();

    data['forget'] = id;
    final json = jsonEncode(data);
    channel3.sink.add(json);

    channel3.stream.listen(
          (data) {
        print(data);

      },
      onError: (error) => print(error),
    );


  }





  WebSocketChannel connect() {

    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=32968'),
    );
    Map<String, dynamic> data =  Map<String, dynamic>();
    data['active_symbols'] = "brief";
    data['product_type'] = "basic";

    final json = jsonEncode(data);

    channel.sink.add(json);

    return channel;

  }





  List<String> gettick(String state , List<ActiveSymbolElement> sym) =>
      sym.where((item) => item.displayName == state)
          .map((item) => item.symbol)
          .toList();




  WebSocketChannel ticks(String value){
    final channel2 = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=32968'),
    );

    String s= gettick(value, symbol.activeSymbols).single;

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticks'] = s;
    data['subscribe'] = 1;
    final json = jsonEncode(data);
    channel2.sink.add(json);

   return channel2;
  }

}


