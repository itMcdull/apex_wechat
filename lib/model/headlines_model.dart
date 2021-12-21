import 'dart:convert';

import 'hero_model.dart';

class HeadlinesModel {
  HeadlinesModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory HeadlinesModel.fromJson(Map<String, dynamic> jsonRes) =>
      HeadlinesModel(
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

  HeadlinesModel copy() {
    return HeadlinesModel(
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
    required this.lists,
    required this.pageNow,
    required this.pageSize,
    required this.totalSize,
    required this.totalPage,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<Lists>? lists = jsonRes['list'] is List ? <Lists>[] : null;
    if (lists != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          tryCatch(() {
            lists.add(Lists.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      lists: lists!,
      pageNow: asT<int>(jsonRes['pageNow'])!,
      pageSize: asT<int>(jsonRes['pageSize'])!,
      totalSize: asT<int>(jsonRes['totalSize'])!,
      totalPage: asT<int>(jsonRes['totalPage'])!,
    );
  }

  List<Lists> lists;
  int pageNow;
  int pageSize;
  int totalSize;
  int totalPage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'list': lists,
        'pageNow': pageNow,
        'pageSize': pageSize,
        'totalSize': totalSize,
        'totalPage': totalPage,
      };

  Data copy() {
    return Data(
      lists: lists.map((Lists e) => e.copy()).toList(),
      pageNow: pageNow,
      pageSize: pageSize,
      totalSize: totalSize,
      totalPage: totalPage,
    );
  }
}

class Lists {
  Lists({
    required this.id,
    required this.title,
    required this.coverImg,
    required this.readCount,
    this.likeCount,
    this.commentCount,
    required this.createTime,
    required this.publisherName,
    required this.publisherHeadImg,
  });

  factory Lists.fromJson(Map<String, dynamic> jsonRes) => Lists(
        id: asT<int>(jsonRes['id'])!,
        title: asT<String>(jsonRes['title'])!,
        coverImg: asT<String>(jsonRes['coverImg'])!,
        readCount: asT<int>(jsonRes['readCount'])!,
        likeCount: asT<int?>(jsonRes['likeCount']),
        commentCount: asT<Object?>(jsonRes['commentCount']),
        createTime: asT<int>(jsonRes['createTime'])!,
        publisherName: asT<String>(jsonRes['publisherName'])!,
        publisherHeadImg: asT<String>(jsonRes['publisherHeadImg'])!,
      );

  int id;
  String title;
  String coverImg;
  int readCount;
  int? likeCount;
  Object? commentCount;
  int createTime;
  String publisherName;
  String publisherHeadImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'coverImg': coverImg,
        'readCount': readCount,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'createTime': createTime,
        'publisherName': publisherName,
        'publisherHeadImg': publisherHeadImg,
      };

  Lists copy() {
    return Lists(
      id: id,
      title: title,
      coverImg: coverImg,
      readCount: readCount,
      likeCount: likeCount,
      commentCount: commentCount,
      createTime: createTime,
      publisherName: publisherName,
      publisherHeadImg: publisherHeadImg,
    );
  }
}
