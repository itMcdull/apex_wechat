import 'dart:convert';

import 'hero_model.dart';

class MapDetailsModel {
  MapDetailsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory MapDetailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      MapDetailsModel(
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

  MapDetailsModel copy() {
    return MapDetailsModel(
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
    required this.id,
    required this.mapType,
    required this.mapName,
    required this.mapImg,
    required this.mapDesc,
    required this.mapHistory,
    required this.mapHistoryVersion,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => Data(
        id: asT<int>(jsonRes['id'])!,
        mapType: asT<int>(jsonRes['mapType'])!,
        mapName: asT<String>(jsonRes['mapName'])!,
        mapImg: asT<String>(jsonRes['mapImg'])!,
        mapDesc: asT<String>(jsonRes['mapDesc'])!,
        mapHistory: asT<String>(jsonRes['mapHistory'])!,
        mapHistoryVersion: asT<String>(jsonRes['mapHistoryVersion'])!,
      );

  int id;
  int mapType;
  String mapName;
  String mapImg;
  String mapDesc;
  String mapHistory;
  String mapHistoryVersion;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'mapType': mapType,
        'mapName': mapName,
        'mapImg': mapImg,
        'mapDesc': mapDesc,
        'mapHistory': mapHistory,
        'mapHistoryVersion': mapHistoryVersion,
      };

  Data copy() {
    return Data(
      id: id,
      mapType: mapType,
      mapName: mapName,
      mapImg: mapImg,
      mapDesc: mapDesc,
      mapHistory: mapHistory,
      mapHistoryVersion: mapHistoryVersion,
    );
  }
}
