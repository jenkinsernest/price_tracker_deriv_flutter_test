
part of 'repo_cubit.dart';




class RepoInitial {


  bool is_read=false;
  double Price = 0.00;
  Ticks tick=null;

  List<Widget> Dynamic = [];


  List<String> asset = ["select an asset"];

  String selectedmarket = "Select a market";
  String selectedasset = "select an asset";

  List<String> markets = ["Select a market"];

  RepoInitial({@required this.selectedmarket ,  this.selectedasset, this.asset,
    this.markets, this.Dynamic});



  Widget getPrice(Ticks t){
    tick=t;

    // print(tick.tick.toString());
    double p= t.tick.quote.toDouble();

    if(p>Price){
      Price=p;
      return Text("Price : $p" , style: TextStyle(color: Colors.green, fontSize: 20),);
    }
    else if(p==Price){
      Price=p;
      return  Text("Price : $p" , style: TextStyle(color: Colors.grey, fontSize: 20),);
    }
    else{
      Price=p;
      return Text("Price : $p" , style: TextStyle(color: Colors.red, fontSize: 20),);
    }


  }



  List<String> gettick(String state , List<ActiveSymbolElement> sym) =>
      sym.where((item) => item.displayName == state)
          .map((item) => item.symbol)
          .toList();






  List<String> getassetByMarket(String state, List<ActiveSymbolElement> sym) =>

      sym.where((item) => item.market.name == state)
          .map((item) => item.displayName.toString())
          .toList();


  // _nigeria.where((list) => list['state'] == state);
  // .map((item) => item['lgas'])
  // .expand((i) => i)
  // .toList();

  List<String> getMarket( List<ActiveSymbolElement> activeSymbols)  =>
      activeSymbols

          .map((item) => item.market.name)

          .toSet().toList();

  // _nigeria.map((item) => item['state'].toString()).toList();


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
}
