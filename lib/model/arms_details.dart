import 'dart:convert';

import 'hero_model.dart';

class ArmsDetailsModel {
  ArmsDetailsModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ArmsDetailsModel.fromJson(Map<String, dynamic> jsonRes) =>
      ArmsDetailsModel(
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

  ArmsDetailsModel copy() {
    return ArmsDetailsModel(
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
    required this.topicId,
    required this.armsName,
    required this.armsIco,
    required this.armsImg,
    required this.armsType,
    required this.armsShotType,
    required this.quickDps,
    required this.quickCapacity,
    required this.quickShotSpeed,
    required this.quickShotHeadDistance,
    required this.quickShotHeadTimes,
    required this.distance,
    required this.accuracy,
    required this.shotSpeed,
    required this.headDamage,
    required this.bodyDamage,
    required this.limbDamage,
    required this.dps,
    required this.trajectorySpeed,
    required this.bulletChangeSpeed,
    required this.bulletFullChangeSpeed,
    required this.capacity,
    required this.arenaPrice,
    required this.armsHistory,
    required this.attrs,
    required this.normalParams,
    required this.titanParams,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) {
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

    final List<NormalParams>? normalParams =
        jsonRes['normalParams'] is List ? <NormalParams>[] : null;
    if (normalParams != null) {
      for (final dynamic item in jsonRes['normalParams']!) {
        if (item != null) {
          tryCatch(() {
            normalParams
                .add(NormalParams.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<TitanParams>? titanParams =
        jsonRes['titanParams'] is List ? <TitanParams>[] : null;
    if (titanParams != null) {
      for (final dynamic item in jsonRes['titanParams']!) {
        if (item != null) {
          tryCatch(() {
            titanParams
                .add(TitanParams.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Data(
      id: asT<int>(jsonRes['id'])!,
      sortId: asT<int>(jsonRes['sortId'])!,
      topicId: asT<int>(jsonRes['topicId'])!,
      armsName: asT<String>(jsonRes['armsName'])!,
      armsIco: asT<String>(jsonRes['armsIco'])!,
      armsImg: asT<String>(jsonRes['armsImg'])!,
      armsType: asT<String>(jsonRes['armsType'])!,
      armsShotType: asT<String>(jsonRes['armsShotType'])!,
      quickDps: asT<String>(jsonRes['quickDps'])!,
      quickCapacity: asT<String>(jsonRes['quickCapacity'])!,
      quickShotSpeed: asT<String>(jsonRes['quickShotSpeed'])!,
      quickShotHeadDistance: asT<String>(jsonRes['quickShotHeadDistance'])!,
      quickShotHeadTimes: asT<String>(jsonRes['quickShotHeadTimes'])!,
      distance: asT<String>(jsonRes['distance'])!,
      accuracy: asT<String>(jsonRes['accuracy'])!,
      shotSpeed: asT<String>(jsonRes['shotSpeed'])!,
      headDamage: asT<String>(jsonRes['headDamage'])!,
      bodyDamage: asT<String>(jsonRes['bodyDamage'])!,
      limbDamage: asT<String>(jsonRes['limbDamage'])!,
      dps: asT<String>(jsonRes['dps'])!,
      trajectorySpeed: asT<String>(jsonRes['trajectorySpeed'])!,
      bulletChangeSpeed: asT<String>(jsonRes['bulletChangeSpeed'])!,
      bulletFullChangeSpeed: asT<String>(jsonRes['bulletFullChangeSpeed'])!,
      capacity: asT<String>(jsonRes['capacity'])!,
      arenaPrice: asT<String>(jsonRes['arenaPrice'])!,
      armsHistory: asT<String>(jsonRes['armsHistory'])!,
      attrs: attrs!,
      normalParams: normalParams!,
      titanParams: titanParams!,
    );
  }

  int id;
  int sortId;
  int topicId;
  String armsName;
  String armsIco;
  String armsImg;
  String armsType;
  String armsShotType;
  String quickDps;
  String quickCapacity;
  String quickShotSpeed;
  String quickShotHeadDistance;
  String quickShotHeadTimes;
  String distance;
  String accuracy;
  String shotSpeed;
  String headDamage;
  String bodyDamage;
  String limbDamage;
  String dps;
  String trajectorySpeed;
  String bulletChangeSpeed;
  String bulletFullChangeSpeed;
  String capacity;
  String arenaPrice;
  String armsHistory;
  List<Attrs> attrs;
  List<NormalParams> normalParams;
  List<TitanParams> titanParams;

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
        'armsType': armsType,
        'armsShotType': armsShotType,
        'quickDps': quickDps,
        'quickCapacity': quickCapacity,
        'quickShotSpeed': quickShotSpeed,
        'quickShotHeadDistance': quickShotHeadDistance,
        'quickShotHeadTimes': quickShotHeadTimes,
        'distance': distance,
        'accuracy': accuracy,
        'shotSpeed': shotSpeed,
        'headDamage': headDamage,
        'bodyDamage': bodyDamage,
        'limbDamage': limbDamage,
        'dps': dps,
        'trajectorySpeed': trajectorySpeed,
        'bulletChangeSpeed': bulletChangeSpeed,
        'bulletFullChangeSpeed': bulletFullChangeSpeed,
        'capacity': capacity,
        'arenaPrice': arenaPrice,
        'armsHistory': armsHistory,
        'attrs': attrs,
        'normalParams': normalParams,
        'titanParams': titanParams,
      };

  Data copy() {
    return Data(
      id: id,
      sortId: sortId,
      topicId: topicId,
      armsName: armsName,
      armsIco: armsIco,
      armsImg: armsImg,
      armsType: armsType,
      armsShotType: armsShotType,
      quickDps: quickDps,
      quickCapacity: quickCapacity,
      quickShotSpeed: quickShotSpeed,
      quickShotHeadDistance: quickShotHeadDistance,
      quickShotHeadTimes: quickShotHeadTimes,
      distance: distance,
      accuracy: accuracy,
      shotSpeed: shotSpeed,
      headDamage: headDamage,
      bodyDamage: bodyDamage,
      limbDamage: limbDamage,
      dps: dps,
      trajectorySpeed: trajectorySpeed,
      bulletChangeSpeed: bulletChangeSpeed,
      bulletFullChangeSpeed: bulletFullChangeSpeed,
      capacity: capacity,
      arenaPrice: arenaPrice,
      armsHistory: armsHistory,
      attrs: attrs.map((Attrs e) => e.copy()).toList(),
      normalParams: normalParams.map((NormalParams e) => e.copy()).toList(),
      titanParams: titanParams.map((TitanParams e) => e.copy()).toList(),
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

class NormalParams {
  NormalParams({
    required this.param,
    required this.value,
    required this.name,
    required this.remark,
  });

  factory NormalParams.fromJson(Map<String, dynamic> jsonRes) => NormalParams(
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

  NormalParams copy() {
    return NormalParams(
      param: param,
      value: value,
      name: name,
      remark: remark,
    );
  }
}

class TitanParams {
  TitanParams({
    required this.param,
    required this.value,
  });

  factory TitanParams.fromJson(Map<String, dynamic> jsonRes) => TitanParams(
        param: asT<String>(jsonRes['param'])!,
        value: asT<String>(jsonRes['value'])!,
      );

  String param;
  String value;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'param': param,
        'value': value,
      };

  TitanParams copy() {
    return TitanParams(
      param: param,
      value: value,
    );
  }
}
