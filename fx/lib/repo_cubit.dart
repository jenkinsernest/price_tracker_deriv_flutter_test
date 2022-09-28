import 'package:bloc/bloc.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx/Model/ActiveSymbol.dart';
import 'package:fx/Model/Ticks.dart';
import 'package:fx/Presenter/Repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'repo_state.dart';

class RepoCubit extends Cubit<RepoInitial> {

  RepoCubit() : super(RepoInitial(selectedasset: "select an asset", selectedmarket: "Select a market"
      , asset: ["select an asset"], markets: ["Select a market"],  Dynamic: []));

 var my_state= RepoInitial(selectedasset: "select an asset", selectedmarket: "Select a market",
     asset: ["select an asset"], markets: ["Select a market"],  Dynamic: []);






  void onSelectedMarket(String value, ActiveSymbol symbol) {
    // setState(() {

   // print("am called");
    state. Dynamic.clear();

    state.selectedasset = "select an asset";
    state.asset = ["select an asset"];
    state. selectedmarket = value;
    state.asset = List.from(state.asset)..addAll(state.getassetByMarket(value,
      symbol.activeSymbols));
    // });
   emit(RepoInitial(selectedmarket: state. selectedmarket, selectedasset: state.selectedasset,
       asset: state.asset, markets: state.markets,  Dynamic: state.Dynamic));
  }




  void onSelectedAsset(String value, ActiveSymbol symbol ) {


    final channel2 = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=32968'),
    );

    String s= state.gettick(value, symbol.activeSymbols).single;

    Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticks'] = s;
    data['subscribe'] = 1;
    final json = jsonEncode(data);
    channel2.sink.add(json);


    //setState(() {
    state.selectedasset = value;

    state.Dynamic.clear();

    state.Dynamic.add(
          StreamBuilder(
            stream: channel2.stream,
            builder: (context, snapshot) {
              return snapshot.hasData ?
              Column(

                children: [
                  SizedBox(
                    height: 40,
                  )
                  ,

                  state.getPrice(Ticks.fromJson(jsonDecode(snapshot.data)))

                ],
              )


                  :

              Column(
                  children:[

                    SizedBox(
                      height: 20,
                    )
                    ,
                    Center(
                      child: CircularProgressIndicator(),

                    )

                  ]
              );
            },
          )

      );

    emit(RepoInitial(selectedmarket: state. selectedmarket,
        selectedasset: state. selectedasset, asset: state.asset, Dynamic: state.Dynamic));

    //});
  }


}
