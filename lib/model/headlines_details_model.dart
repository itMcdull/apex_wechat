import 'dart:convert';

import 'hero_model.dart';

class HeadLinesDetailsModel {
  HeadLinesDetailsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory HeadLinesDetailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      HeadLinesDetailsModel(
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

  HeadLinesDetailsModel copy() {
    return HeadLinesDetailsModel(
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
    required this.title,
    required this.coverImg,
    required this.readCount,
    required this.likeCount,
    this.commentCount,
    required this.createTime,
    required this.publisherName,
    required this.publisherHeadImg,
    required this.content,
    required this.liked,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => Data(
        id: asT<int>(jsonRes['id'])!,
        title: asT<String>(jsonRes['title'])!,
        coverImg: asT<String>(jsonRes['coverImg'])!,
        readCount: asT<int>(jsonRes['readCount'])!,
        likeCount: asT<int>(jsonRes['likeCount'])!,
        commentCount: asT<Object?>(jsonRes['commentCount']),
        createTime: asT<int>(jsonRes['createTime'])!,
        publisherName: asT<String>(jsonRes['publisherName'])!,
        publisherHeadImg: asT<String>(jsonRes['publisherHeadImg'])!,
        content: asT<String>(jsonRes['content'])!,
        liked: asT<bool>(jsonRes['liked'])!,
      );

  int id;
  String title;
  String coverImg;
  int readCount;
  int likeCount;
  Object? commentCount;
  int createTime;
  String publisherName;
  String publisherHeadImg;
  String content;
  bool liked;

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
        'content': content,
        'liked': liked,
      };

  Data copy() {
    return Data(
      id: id,
      title: title,
      coverImg: coverImg,
      readCount: readCount,
      likeCount: likeCount,
      commentCount: commentCount,
      createTime: createTime,
      publisherName: publisherName,
      publisherHeadImg: publisherHeadImg,
      content: content,
      liked: liked,
    );
  }
}
