import 'dart:convert';

import 'hero_model.dart';

class ArmsClassModel {
  ArmsClassModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ArmsClassModel.fromJson(Map<String, dynamic> jsonRes) =>
      ArmsClassModel(
        version: asT<Object?>(jsonRes['version']),
        reqId: asT<Object?>(jsonRes['reqId']),
        code: asT<int>(jsonRes['code'])!,
        msg: asT<String>(jsonRes['msg'])!,
        data: Data.fromJson(asT<Map<String, dynamic>>(jsonRes['data'])!),
      );

  Object? version;
  Object? reqId;
  int code;
  String msg;
  Data data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'version': version,
        'reqId': reqId,
        'code': code,
        'msg': msg,
        'data': data,
      };

  ArmsClassModel copy() {
    return ArmsClassModel(
      version: version,
      reqId: reqId,
      code: code,
      msg: msg,
      data: data.copy(),
    );
  }
}

class Data {
  Data({
    required this.items,
    required this.params,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<Items>? items = jsonRes['items'] is List ? <Items>[] : null;
    if (items != null) {
      for (final dynamic item in jsonRes['items']!) {
        if (item != null) {
          tryCatch(() {
            items.add(Items.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Params>? params = jsonRes['params'] is List ? <Params>[] : null;
    if (params != null) {
      for (final dynamic item in jsonRes['params']!) {
        if (item != null) {
          tryCatch(() {
            params.add(Params.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      items: items!,
      params: params!,
    );
  }

  List<Items> items;
  List<Params> params;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'items': items,
        'params': params,
      };

  Data copy() {
    return Data(
      items: items.map((Items e) => e.copy()).toList(),
      params: params.map((Params e) => e.copy()).toList(),
    );
  }
}

class Items {
  Items({
    required this.id,
    required this.sortId,
    required this.topicId,
    required this.armsName,
    required this.armsIco,
    required this.armsImg,
    required this.quickDps,
    required this.quickCapacity,
    required this.quickShotSpeed,
    required this.quickShotHeadDistance,
    required this.quickShotHeadTimes,
    required this.headDamage,
    required this.bodyDamage,
    required this.limbDamage,
  });

  factory Items.fromJson(Map<String, dynamic> jsonRes) => Items(
        id: asT<int>(jsonRes['id'])!,
        sortId: asT<int>(jsonRes['sortId'])!,
        topicId: asT<int>(jsonRes['topicId'])!,
        armsName: asT<String>(jsonRes['armsName'])!,
        armsIco: asT<String>(jsonRes['armsIco'])!,
        armsImg: asT<String>(jsonRes['armsImg'])!,
        quickDps: asT<String>(jsonRes['quickDps'])!,
        quickCapacity: asT<String>(jsonRes['quickCapacity'])!,
        quickShotSpeed: asT<String>(jsonRes['quickShotSpeed'])!,
        quickShotHeadDistance: asT<String>(jsonRes['quickShotHeadDistance'])!,
        quickShotHeadTimes: asT<String>(jsonRes['quickShotHeadTimes'])!,
        headDamage: asT<String>(jsonRes['headDamage'])!,
        bodyDamage: asT<String>(jsonRes['bodyDamage'])!,
        limbDamage: asT<String>(jsonRes['limbDamage'])!,
      );

  int id;
  int sortId;
  int topicId;
  String armsName;
  String armsIco;
  String armsImg;
  String quickDps;
  String quickCapacity;
  String quickShotSpeed;
  String quickShotHeadDistance;
  String quickShotHeadTimes;
  String headDamage;
  String bodyDamage;
  String limbDamage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sortId': sortId,
        'topicId': topicId,
        'armsName': armsName,
        'armsIco': armsIco,
        'armsImg': armsImg,
        'quickDps': quickDps,
        'quickCapacity': quickCapacity,
        'quickShotSpeed': quickShotSpeed,
        'quickShotHeadDistance': quickShotHeadDistance,
        'quickShotHeadTimes': quickShotHeadTimes,
        'headDamage': headDamage,
        'bodyDamage': bodyDamage,
        'limbDamage': limbDamage,
      };

  Items copy() {
    return Items(
      id: id,
      sortId: sortId,
      topicId: topicId,
      armsName: armsName,
      armsIco: armsIco,
      armsImg: armsImg,
      quickDps: quickDps,
      quickCapacity: quickCapacity,
      quickShotSpeed: quickShotSpeed,
      quickShotHeadDistance: quickShotHeadDistance,
      quickShotHeadTimes: quickShotHeadTimes,
      headDamage: headDamage,
      bodyDamage: bodyDamage,
      limbDamage: limbDamage,
    );
  }
}

class Params {
  Params({
    required this.param,
    required this.value,
    required this.name,
    required this.remark,
  });

  factory Params.fromJson(Map<String, dynamic> jsonRes) => Params(
        param: asT<String>(jsonRes['param'])!,
        value: asT<String>(jsonRes['value'])!,
        name: asT<String>(jsonRes['name'])!,
        remark: asT<String>(jsonRes['remark'])!,
      );

  String param;
  String value;
  String name;
  String remark;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'param': param,
        'value': value,
        'name': name,
        'remark': remark,
      };

  Params copy() {
    return Params(
      param: param,
      value: value,
      name: name,
      remark: remark,
    );
  }
}
