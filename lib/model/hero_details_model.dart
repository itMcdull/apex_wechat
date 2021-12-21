import 'dart:convert';

import 'hero_model.dart';

class HeroDetailsModel {
  HeroDetailsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory HeroDetailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      HeroDetailsModel(
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

  HeroDetailsModel copy() {
    return HeroDetailsModel(
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
    required this.sortId,
    required this.heroName,
    required this.heroImg,
    required this.heroVideo,
    required this.gameName,
    required this.realName,
    required this.sex,
    required this.nickName,
    required this.age,
    required this.height,
    required this.weight,
    required this.homeland,
    required this.moveSpeed,
    required this.motto,
    required this.backStory,
    required this.skillDesc,
    required this.strategy,
    required this.historyUpdate,
    required this.skills,
    required this.attrs,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
    final List<Skills>? skills = jsonRes['skills'] is List ? <Skills>[] : null;
    if (skills != null) {
      for (final dynamic item in jsonRes['skills']!) {
        if (item != null) {
          tryCatch(() {
            skills.add(Skills.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Attrs>? attrs = jsonRes['attrs'] is List ? <Attrs>[] : null;
    if (attrs != null) {
      for (final dynamic item in jsonRes['attrs']!) {
        if (item != null) {
          tryCatch(() {
            attrs.add(Attrs.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      id: asT<int>(jsonRes['id'])!,
      sortId: asT<int>(jsonRes['sortId'])!,
      heroName: asT<String>(jsonRes['heroName'])!,
      heroImg: asT<String>(jsonRes['heroImg'])!,
      heroVideo: asT<String>(jsonRes['heroVideo'])!,
      gameName: asT<String>(jsonRes['gameName'])!,
      realName: asT<String>(jsonRes['realName'])!,
      sex: asT<int>(jsonRes['sex'])!,
      nickName: asT<String>(jsonRes['nickName'])!,
      age: asT<String>(jsonRes['age'])!,
      height: asT<String>(jsonRes['height'])!,
      weight: asT<String>(jsonRes['weight'])!,
      homeland: asT<String>(jsonRes['homeland'])!,
      moveSpeed: asT<String>(jsonRes['moveSpeed'])!,
      motto: asT<String>(jsonRes['motto'])!,
      backStory: asT<String>(jsonRes['backStory'])!,
      skillDesc: asT<String>(jsonRes['skillDesc'])!,
      strategy: asT<String>(jsonRes['strategy'])!,
      historyUpdate: asT<String>(jsonRes['historyUpdate'])!,
      skills: skills!,
      attrs: attrs!,
    );
  }

  int id;
  int sortId;
  String heroName;
  String heroImg;
  String heroVideo;
  String gameName;
  String realName;
  int sex;
  String nickName;
  String age;
  String height;
  String weight;
  String homeland;
  String moveSpeed;
  String motto;
  String backStory;
  String skillDesc;
  String strategy;
  String historyUpdate;
  List<Skills> skills;
  List<Attrs> attrs;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sortId': sortId,
        'heroName': heroName,
        'heroImg': heroImg,
        'heroVideo': heroVideo,
        'gameName': gameName,
        'realName': realName,
        'sex': sex,
        'nickName': nickName,
        'age': age,
        'height': height,
        'weight': weight,
        'homeland': homeland,
        'moveSpeed': moveSpeed,
        'motto': motto,
        'backStory': backStory,
        'skillDesc': skillDesc,
        'strategy': strategy,
        'historyUpdate': historyUpdate,
        'skills': skills,
        'attrs': attrs,
      };

  Data copy() {
    return Data(
      id: id,
      sortId: sortId,
      heroName: heroName,
      heroImg: heroImg,
      heroVideo: heroVideo,
      gameName: gameName,
      realName: realName,
      sex: sex,
      nickName: nickName,
      age: age,
      height: height,
      weight: weight,
      homeland: homeland,
      moveSpeed: moveSpeed,
      motto: motto,
      backStory: backStory,
      skillDesc: skillDesc,
      strategy: strategy,
      historyUpdate: historyUpdate,
      skills: skills.map((Skills e) => e.copy()).toList(),
      attrs: attrs.map((Attrs e) => e.copy()).toList(),
    );
  }
}

class Skills {
  Skills({
    required this.id,
    required this.heroId,
    required this.skillName,
    required this.skillTitle,
    required this.skillImg,
    required this.skillContent,
  });

  factory Skills.fromJson(Map<String, dynamic> jsonRes) => Skills(
        id: asT<int>(jsonRes['id'])!,
        heroId: asT<int>(jsonRes['heroId'])!,
        skillName: asT<String>(jsonRes['skillName'])!,
        skillTitle: asT<String>(jsonRes['skillTitle'])!,
        skillImg: asT<String>(jsonRes['skillImg'])!,
        skillContent: asT<String>(jsonRes['skillContent'])!,
      );

  int id;
  int heroId;
  String skillName;
  String skillTitle;
  String skillImg;
  String skillContent;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'heroId': heroId,
        'skillName': skillName,
        'skillTitle': skillTitle,
        'skillImg': skillImg,
        'skillContent': skillContent,
      };

  Skills copy() {
    return Skills(
      id: id,
      heroId: heroId,
      skillName: skillName,
      skillTitle: skillTitle,
      skillImg: skillImg,
      skillContent: skillContent,
    );
  }
}

class Attrs {
  Attrs({
    required this.type,
    required this.levels,
  });

  factory Attrs.fromJson(Map<String, dynamic> jsonRes) {
    final List<Levels>? levels = jsonRes['levels'] is List ? <Levels>[] : null;
    if (levels != null) {
      for (final dynamic item in jsonRes['levels']!) {
        if (item != null) {
          tryCatch(() {
            levels.add(Levels.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Attrs(
      type: asT<int>(jsonRes['type'])!,
      levels: levels!,
    );
  }

  int type;
  List<Levels> levels;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'levels': levels,
      };

  Attrs copy() {
    return Attrs(
      type: type,
      levels: levels.map((Levels e) => e.copy()).toList(),
    );
  }
}

class Levels {
  Levels({
    required this.level,
    required this.items,
  });

  factory Levels.fromJson(Map<String, dynamic> jsonRes) {
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
    return Levels(
      level: asT<int>(jsonRes['level'])!,
      items: items!,
    );
  }

  int level;
  List<Items> items;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'level': level,
        'items': items,
      };

  Levels copy() {
    return Levels(
      level: level,
      items: items.map((Items e) => e.copy()).toList(),
    );
  }
}

class Items {
  Items({
    required this.id,
    required this.targetId,
    required this.type,
    required this.level,
    required this.attrName,
    required this.attrImg,
    required this.attrDesc,
    required this.attrFeature,
    required this.token,
    required this.metal,
    required this.coin,
  });

  factory Items.fromJson(Map<String, dynamic> jsonRes) => Items(
        id: asT<int>(jsonRes['id'])!,
        targetId: asT<int>(jsonRes['targetId'])!,
        type: asT<int>(jsonRes['type'])!,
        level: asT<int>(jsonRes['level'])!,
        attrName: asT<String>(jsonRes['attrName'])!,
        attrImg: asT<String>(jsonRes['attrImg'])!,
        attrDesc: asT<String>(jsonRes['attrDesc'])!,
        attrFeature: asT<String>(jsonRes['attrFeature'])!,
        token: asT<String>(jsonRes['token'])!,
        metal: asT<String>(jsonRes['metal'])!,
        coin: asT<String>(jsonRes['coin'])!,
      );

  int id;
  int targetId;
  int type;
  int level;
  String attrName;
  String attrImg;
  String attrDesc;
  String attrFeature;
  String token;
  String metal;
  String coin;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'targetId': targetId,
        'type': type,
        'level': level,
        'attrName': attrName,
        'attrImg': attrImg,
        'attrDesc': attrDesc,
        'attrFeature': attrFeature,
        'token': token,
        'metal': metal,
        'coin': coin,
      };

  Items copy() {
    return Items(
      id: id,
      targetId: targetId,
      type: type,
      level: level,
      attrName: attrName,
      attrImg: attrImg,
      attrDesc: attrDesc,
      attrFeature: attrFeature,
      token: token,
      metal: metal,
      coin: coin,
    );
  }
}
