import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class HeroModel {
  HeroModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory HeroModel.fromJson(Map<String, dynamic> jsonRes) {
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
    return HeroModel(
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

  HeroModel copy() {
    return HeroModel(
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
    required this.id,
    required this.sortId,
    required this.heroName,
    required this.heroImg,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => Data(
        id: asT<int>(jsonRes['id'])!,
        sortId: asT<int>(jsonRes['sortId'])!,
        heroName: asT<String>(jsonRes['heroName'])!,
        heroImg: asT<String>(jsonRes['heroImg'])!,
      );

  int id;
  int sortId;
  String heroName;
  String heroImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sortId': sortId,
        'heroName': heroName,
        'heroImg': heroImg,
      };

  Data copy() {
    return Data(
      id: id,
      sortId: sortId,
      heroName: heroName,
      heroImg: heroImg,
    );
  }
}
