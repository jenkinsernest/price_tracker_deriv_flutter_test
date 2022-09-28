// To parse this JSON data, do
//
//     final activeSymbol = activeSymbolFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ActiveSymbol activeSymbolFromJson(String str) => ActiveSymbol.fromJson(json.decode(str));

String activeSymbolToJson(ActiveSymbol data) => json.encode(data.toJson());

class ActiveSymbol {
  ActiveSymbol({
    @required this.activeSymbols,
    @required this.echoReq,
    @required this.msgType,
  });

  List<ActiveSymbolElement> activeSymbols;
  EchoReq echoReq;
  String msgType;

  factory ActiveSymbol.fromJson(Map<String, dynamic> json) => ActiveSymbol(
    activeSymbols: json["active_symbols"] == null ? null : List<ActiveSymbolElement>.from(json["active_symbols"].map((x) => ActiveSymbolElement.fromJson(x))),
    echoReq: json["echo_req"] == null ? null : EchoReq.fromJson(json["echo_req"]),
    msgType: json["msg_type"] == null ? null : json["msg_type"],
  );

  Map<String, dynamic> toJson() => {
    "active_symbols": activeSymbols == null ? null : List<dynamic>.from(activeSymbols.map((x) => x.toJson())),
    "echo_req": echoReq == null ? null : echoReq.toJson(),
    "msg_type": msgType == null ? null : msgType,
  };
}

class ActiveSymbolElement {
  ActiveSymbolElement({
    @required this.allowForwardStarting,
    @required this.displayName,
    @required this.exchangeIsOpen,
    @required this.isTradingSuspended,
    @required this.market,
    @required this.marketDisplayName,
    @required this.pip,
    @required this.submarket,
    @required this.submarketDisplayName,
    @required this.symbol,
    @required this.symbolType,
  });

  int allowForwardStarting;
  String displayName;
  int exchangeIsOpen;
  int isTradingSuspended;
  Market market;
  MarketDisplayName marketDisplayName;
  double pip;
  String submarket;
  String submarketDisplayName;
  String symbol;
  SymbolType symbolType;

  factory ActiveSymbolElement.fromJson(Map<String, dynamic> json) => ActiveSymbolElement(
    allowForwardStarting: json["allow_forward_starting"] == null ? null : json["allow_forward_starting"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    exchangeIsOpen: json["exchange_is_open"] == null ? null : json["exchange_is_open"],
    isTradingSuspended: json["is_trading_suspended"] == null ? null : json["is_trading_suspended"],
    market: json["market"] == null ? null : marketValues.map[json["market"]],
    marketDisplayName: json["market_display_name"] == null ? null : marketDisplayNameValues.map[json["market_display_name"]],
    pip: json["pip"] == null ? null : json["pip"].toDouble(),
    submarket: json["submarket"] == null ? null : json["submarket"],
    submarketDisplayName: json["submarket_display_name"] == null ? null : json["submarket_display_name"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    symbolType: json["symbol_type"] == null ? null : symbolTypeValues.map[json["symbol_type"]],
  );

  Map<String, dynamic> toJson() => {
    "allow_forward_starting": allowForwardStarting == null ? null : allowForwardStarting,
    "display_name": displayName == null ? null : displayName,
    "exchange_is_open": exchangeIsOpen == null ? null : exchangeIsOpen,
    "is_trading_suspended": isTradingSuspended == null ? null : isTradingSuspended,
    "market": market == null ? null : marketValues.reverse[market],
    "market_display_name": marketDisplayName == null ? null : marketDisplayNameValues.reverse[marketDisplayName],
    "pip": pip == null ? null : pip,
    "submarket": submarket == null ? null : submarket,
    "submarket_display_name": submarketDisplayName == null ? null : submarketDisplayName,
    "symbol": symbol == null ? null : symbol,
    "symbol_type": symbolType == null ? null : symbolTypeValues.reverse[symbolType],
  };
}

enum Market { BASKET_INDEX, FOREX, INDICES, CRYPTOCURRENCY, SYNTHETIC_INDEX, COMMODITIES }

final marketValues = EnumValues({
  "basket_index": Market.BASKET_INDEX,
  "commodities": Market.COMMODITIES,
  "cryptocurrency": Market.CRYPTOCURRENCY,
  "forex": Market.FOREX,
  "indices": Market.INDICES,
  "synthetic_index": Market.SYNTHETIC_INDEX
});

enum MarketDisplayName { BASKET_INDICES, FOREX, STOCK_INDICES, CRYPTOCURRENCIES, SYNTHETIC_INDICES, COMMODITIES }

final marketDisplayNameValues = EnumValues({
  "Basket Indices": MarketDisplayName.BASKET_INDICES,
  "Commodities": MarketDisplayName.COMMODITIES,
  "Cryptocurrencies": MarketDisplayName.CRYPTOCURRENCIES,
  "Forex": MarketDisplayName.FOREX,
  "Stock Indices": MarketDisplayName.STOCK_INDICES,
  "Synthetic Indices": MarketDisplayName.SYNTHETIC_INDICES
});

enum SymbolType { FOREX_BASKET, FOREX, STOCKINDEX, CRYPTOCURRENCY, EMPTY, COMMODITY_BASKET, COMMODITIES }

final symbolTypeValues = EnumValues({
  "commodities": SymbolType.COMMODITIES,
  "commodity_basket": SymbolType.COMMODITY_BASKET,
  "cryptocurrency": SymbolType.CRYPTOCURRENCY,
  "": SymbolType.EMPTY,
  "forex": SymbolType.FOREX,
  "forex_basket": SymbolType.FOREX_BASKET,
  "stockindex": SymbolType.STOCKINDEX
});

class EchoReq {
  EchoReq({
    @required this.activeSymbols,
    @required this.productType,
  });

  String activeSymbols;
  String productType;

  factory EchoReq.fromJson(Map<String, dynamic> json) => EchoReq(
    activeSymbols: json["active_symbols"] == null ? null : json["active_symbols"],
    productType: json["product_type"] == null ? null : json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "active_symbols": activeSymbols == null ? null : activeSymbols,
    "product_type": productType == null ? null : productType,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
