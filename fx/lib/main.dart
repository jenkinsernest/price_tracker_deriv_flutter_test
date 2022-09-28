import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx/Model/ActiveSymbol.dart';

import 'package:fx/Presenter/Repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'Model/Ticks.dart';
import 'repo_cubit.dart';


void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Tracker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RepoCubit>(
        create: (_) => RepoCubit(),
        child: const MyHomePage(title: 'Price Tracker'),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);


  final String title;

  WebSocketChannel get_Connection(){


    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=32968'),
    );
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_symbols'] = "brief";
    data['product_type'] = "basic";

    final json = jsonEncode(data);

    channel.sink.add(json);

    return channel;
  }




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



Repository repo= new Repository();


var channel;



  @override
  void initState() {

    super.initState();

     channel = widget.get_Connection();
  }


  @override
  void dispose(){
    if(BlocProvider.of<RepoCubit>(context).my_state.tick!=null) {

      BlocProvider.of<RepoCubit>(context).my_state.dispose(BlocProvider.of<RepoCubit>(context).my_state.tick.tick.id);
      print(BlocProvider.of<RepoCubit>(context).my_state.tick.tick.id);

    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0.1,
        ),
        body:
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ?

            home(jsonDecode(snapshot.data), context)

                :

          Center(
           child: CircularProgressIndicator(),

          ) ;
          },
        )


    );

  }


  Widget home( a, BuildContext context){


    repo.symbol=ActiveSymbol.fromJson(a);

    //print(  repo.symbol.activeSymbols.length);

if( BlocProvider.of<RepoCubit>(context).my_state.is_read==false) {

  BlocProvider.of<RepoCubit>(context).my_state.markets =
  List.from(BlocProvider.of<RepoCubit>(context).my_state.markets)..
  addAll(BlocProvider.of<RepoCubit>(context).my_state.
  getMarket(repo.symbol.activeSymbols));
}


     BlocProvider.of<RepoCubit>(context).my_state.is_read=true;

    return
          SafeArea(
          child:
          Container(

            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Column(
              children: <Widget>[

    BlocBuilder<RepoCubit, RepoInitial>(
    builder: (context2, state) {
      return
        DropdownButton<String>(
          isExpanded: true,
          items: BlocProvider
              .of<RepoCubit>(context)
              .my_state
              .markets
              .map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (value) =>
              context.read<RepoCubit>().onSelectedMarket(value, repo.symbol),
          value: state.selectedmarket,
        );

    }),


                BlocBuilder<RepoCubit, RepoInitial>(
                    builder: (context2, state){

                   return   DropdownButton<String>(
                        isExpanded: true,
                        items:

                        state.asset.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        // onChanged: (value) => print(value),
                        onChanged: (value) =>
                            context.read<RepoCubit>().onSelectedAsset(value, repo.symbol),
                        value: state.selectedasset,
                      );

                    }),


    BlocBuilder<RepoCubit, RepoInitial>(
    builder: (context2, state) {
      return Column(

            children:

              state.Dynamic,


        );
    })
              ],
            ),

          ));
    }





  }







