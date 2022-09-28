// To parse this JSON data, do
//
//     final ticks = ticksFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Ticks ticksFromJson(String str) => Ticks.fromJson(json.decode(str));

String ticksToJson(Ticks data) => json.encode(data.toJson());

class Ticks {
  Ticks({
    @required this.echoReq,
    @required this.msgType,
    @required this.subscription,
    @required this.tick,
  });

  EchoReq echoReq;
  String msgType;
  Subscription subscription;
  Tick tick;

  factory Ticks.fromJson(Map<String, dynamic> json) => Ticks(
    echoReq: json["echo_req"] == null ? null : EchoReq.fromJson(json["echo_req"]),
    msgType: json["msg_type"] == null ? null : json["msg_type"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    tick: json["tick"] == null ? null : Tick.fromJson(json["tick"]),
  );

  Map<String, dynamic> toJson() => {
    "echo_req": echoReq == null ? null : echoReq.toJson(),
    "msg_type": msgType == null ? null : msgType,
    "subscription": subscription == null ? null : subscription.toJson(),
    "tick": tick == null ? null : tick.toJson(),
  };
}

class EchoReq {
  EchoReq({
    @required this.subscribe,
    @required this.ticks,
  });

  int subscribe;
  String ticks;

  factory EchoReq.fromJson(Map<String, dynamic> json) => EchoReq(
    subscribe: json["subscribe"] == null ? null : json["subscribe"],
    ticks: json["ticks"] == null ? null : json["ticks"],
  );

  Map<String, dynamic> toJson() => {
    "subscribe": subscribe == null ? null : subscribe,
    "ticks": ticks == null ? null : ticks,
  };
}

class Subscription {
  Subscription({
    @required this.id,
  });

  String id;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

class Tick {
  Tick({
    @required this.ask,
    @required this.bid,
    @required this.epoch,
    @required this.id,
    @required this.pipSize,
    @required this.quote,
    @required this.symbol,
  });

  double ask;
  double bid;
  int epoch;
  String id;
  int pipSize;
  double quote;
  String symbol;

  factory Tick.fromJson(Map<String, dynamic> json) => Tick(
    ask: json["ask"] == null ? null : json["ask"].toDouble(),
    bid: json["bid"] == null ? null : json["bid"].toDouble(),
    epoch: json["epoch"] == null ? null : json["epoch"],
    id: json["id"] == null ? null : json["id"],
    pipSize: json["pip_size"] == null ? null : json["pip_size"],
    quote: json["quote"] == null ? null : json["quote"].toDouble(),
    symbol: json["symbol"] == null ? null : json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "ask": ask == null ? null : ask,
    "bid": bid == null ? null : bid,
    "epoch": epoch == null ? null : epoch,
    "id": id == null ? null : id,
    "pip_size": pipSize == null ? null : pipSize,
    "quote": quote == null ? null : quote,
    "symbol": symbol == null ? null : symbol,
  };
}
