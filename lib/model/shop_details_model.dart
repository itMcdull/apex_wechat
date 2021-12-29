import 'dart:convert';

import 'hero_model.dart';

class ShopDatailsModel {
  ShopDatailsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ShopDatailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      ShopDatailsModel(
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

  ShopDatailsModel copy() {
    return ShopDatailsModel(
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
    required this.topicId,
    required this.itemName,
    required this.itemImg,
    required this.content,
    required this.contentPics,
    required this.createTime,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? contentPics =
        jsonRes['contentPics'] is List ? <String>[] : null;
    if (contentPics != null) {
      for (final dynamic item in jsonRes['contentPics']!) {
        if (item != null) {
          tryCatch(() {
            contentPics.add(asT<String>(item)!);
          });
        }
      }
    }
    return Data(
      id: asT<int>(jsonRes['id'])!,
      topicId: asT<int>(jsonRes['topicId'])!,
      itemName: asT<String>(jsonRes['itemName'])!,
      itemImg: asT<String>(jsonRes['itemImg'])!,
      content: asT<String>(jsonRes['content'])!,
      contentPics: contentPics!,
      createTime: asT<int>(jsonRes['createTime'])!,
    );
  }

  int id;
  int topicId;
  String itemName;
  String itemImg;
  String content;
  List<String> contentPics;
  int createTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'topicId': topicId,
        'itemName': itemName,
        'itemImg': itemImg,
        'content': content,
        'contentPics': contentPics,
        'createTime': createTime,
      };

  Data copy() {
    return Data(
      id: id,
      topicId: topicId,
      itemName: itemName,
      itemImg: itemImg,
      content: content,
      contentPics: contentPics.map((String e) => e).toList(),
      createTime: createTime,
    );
  }
}
