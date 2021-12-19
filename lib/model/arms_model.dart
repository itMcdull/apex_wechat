import 'dart:convert';

import 'hero_model.dart';

class ArmsModel {
  ArmsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ArmsModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<Data>? data = jsonRes['data'] is List ? <Data>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(Data.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ArmsModel(
      version: asT<Object?>(jsonRes['version']),
      reqId: asT<Object?>(jsonRes['reqId']),
      code: asT<int>(jsonRes['code'])!,
      msg: asT<String>(jsonRes['msg'])!,
      data: data!,
    );
  }

  Object? version;
  Object? reqId;
  int code;
  String msg;
  List<Data> data;

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

  ArmsModel copy() {
    return ArmsModel(
      version: version,
      reqId: reqId,
      code: code,
      msg: msg,
      data: data.map((Data e) => e.copy()).toList(),
    );
  }
}

class Data {
  Data({
    required this.type,
    required this.id,
    required this.name,
    required this.img,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => Data(
        type: asT<int>(jsonRes['type'])!,
        id: asT<int>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        img: asT<String>(jsonRes['img'])!,
        items: asT<Object?>(jsonRes['items']),
      );

  int type;
  int id;
  String name;
  String img;
  Object? items;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'id': id,
        'name': name,
        'img': img,
        'items': items,
      };

  Data copy() {
    return Data(
      type: type,
      id: id,
      name: name,
      img: img,
      items: items,
    );
  }
}
