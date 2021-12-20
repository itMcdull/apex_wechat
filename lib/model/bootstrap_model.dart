import 'dart:convert';

import 'hero_model.dart';

class BootstrapModel {
  BootstrapModel({
    this.version,
    this.reqId,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory BootstrapModel.fromJson(Map<String, dynamic> jsonRes) =>
      BootstrapModel(
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

  BootstrapModel copy() {
    return BootstrapModel(
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
    required this.shop,
    required this.hero,
    required this.arms,
    required this.map,
  });

  factory Data.fromJson(Map<String, dynamic> jsonRes) => Data(
        shop: Shop.fromJson(asT<Map<String, dynamic>>(jsonRes['shop'])!),
        hero: Hero.fromJson(asT<Map<String, dynamic>>(jsonRes['hero'])!),
        arms: Arms.fromJson(asT<Map<String, dynamic>>(jsonRes['arms'])!),
        map: BootMap.fromJson(asT<Map<String, dynamic>>(jsonRes['map'])!),
      );

  Shop shop;
  Hero hero;
  Arms arms;
  BootMap map;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'shop': shop,
        'hero': hero,
        'arms': arms,
        'map': map,
      };

  Data copy() {
    return Data(
      shop: shop.copy(),
      hero: hero.copy(),
      arms: arms.copy(),
      map: map.copy(),
    );
  }
}

class Shop {
  Shop({
    required this.topics,
  });

  factory Shop.fromJson(Map<String, dynamic> jsonRes) {
    final List<Topics>? topics = jsonRes['topics'] is List ? <Topics>[] : null;
    if (topics != null) {
      for (final dynamic item in jsonRes['topics']!) {
        if (item != null) {
          tryCatch(() {
            topics.add(Topics.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Shop(
      topics: topics!,
    );
  }

  List<Topics> topics;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'topics': topics,
      };

  Shop copy() {
    return Shop(
      topics: topics.map((Topics e) => e.copy()).toList(),
    );
  }
}

class Topics {
  Topics({
    required this.id,
    required this.topicName,
    required this.topicImg,
    required this.items,
  });

  factory Topics.fromJson(Map<String, dynamic> jsonRes) {
    final List<TopicsItems>? items =
        jsonRes['items'] is List ? <TopicsItems>[] : null;
    if (items != null) {
      for (final dynamic item in jsonRes['items']!) {
        if (item != null) {
          tryCatch(() {
            items.add(TopicsItems.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Topics(
      id: asT<int>(jsonRes['id'])!,
      topicName: asT<String>(jsonRes['topicName'])!,
      topicImg: asT<String>(jsonRes['topicImg'])!,
      items: items!,
    );
  }

  int id;
  String topicName;
  String topicImg;
  List<TopicsItems> items;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'topicName': topicName,
        'topicImg': topicImg,
        'items': items,
      };

  Topics copy() {
    return Topics(
      id: id,
      topicName: topicName,
      topicImg: topicImg,
      items: items.map((TopicsItems e) => e.copy()).toList(),
    );
  }
}

class TopicsItems {
  TopicsItems({
    required this.id,
    required this.topicId,
    required this.itemName,
    required this.itemImg,
  });

  factory TopicsItems.fromJson(Map<String, dynamic> jsonRes) => TopicsItems(
        id: asT<int>(jsonRes['id'])!,
        topicId: asT<int>(jsonRes['topicId'])!,
        itemName: asT<String>(jsonRes['itemName'])!,
        itemImg: asT<String>(jsonRes['itemImg'])!,
      );

  int id;
  int topicId;
  String itemName;
  String itemImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'topicId': topicId,
        'itemName': itemName,
        'itemImg': itemImg,
      };

  TopicsItems copy() {
    return TopicsItems(
      id: id,
      topicId: topicId,
      itemName: itemName,
      itemImg: itemImg,
    );
  }
}

class Hero {
  Hero({
    required this.sorts,
  });

  factory Hero.fromJson(Map<String, dynamic> jsonRes) {
    final List<Sorts>? sorts = jsonRes['sorts'] is List ? <Sorts>[] : null;
    if (sorts != null) {
      for (final dynamic item in jsonRes['sorts']!) {
        if (item != null) {
          tryCatch(() {
            sorts.add(Sorts.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Hero(
      sorts: sorts!,
    );
  }

  List<Sorts> sorts;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sorts': sorts,
      };

  Hero copy() {
    return Hero(
      sorts: sorts.map((Sorts e) => e.copy()).toList(),
    );
  }
}

class Sorts {
  Sorts({
    required this.id,
    required this.sortName,
    this.sortImg,
    required this.heroes,
  });

  factory Sorts.fromJson(Map<String, dynamic> jsonRes) {
    final List<Heroes>? heroes = jsonRes['heroes'] is List ? <Heroes>[] : null;
    if (heroes != null) {
      for (final dynamic item in jsonRes['heroes']!) {
        if (item != null) {
          tryCatch(() {
            heroes.add(Heroes.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Sorts(
      id: asT<int>(jsonRes['id'])!,
      sortName: asT<String>(jsonRes['sortName'])!,
      sortImg: asT<String?>(jsonRes['sortImg']),
      heroes: heroes!,
    );
  }

  int id;
  String sortName;
  String? sortImg;
  List<Heroes> heroes;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sortName': sortName,
        'sortImg': sortImg,
        'heroes': heroes,
      };

  Sorts copy() {
    return Sorts(
      id: id,
      sortName: sortName,
      sortImg: sortImg,
      heroes: heroes.map((Heroes e) => e.copy()).toList(),
    );
  }
}

class Heroes {
  Heroes({
    required this.id,
    required this.sortId,
    required this.heroName,
    required this.heroImg,
  });

  factory Heroes.fromJson(Map<String, dynamic> jsonRes) => Heroes(
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

  Heroes copy() {
    return Heroes(
      id: id,
      sortId: sortId,
      heroName: heroName,
      heroImg: heroImg,
    );
  }
}

class Arms {
  Arms({
    required this.groups,
  });

  factory Arms.fromJson(Map<String, dynamic> jsonRes) {
    final List<ArmsGroups>? groups =
        jsonRes['groups'] is List ? <ArmsGroups>[] : null;
    if (groups != null) {
      for (final dynamic item in jsonRes['groups']!) {
        if (item != null) {
          tryCatch(() {
            groups.add(ArmsGroups.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Arms(
      groups: groups!,
    );
  }

  List<ArmsGroups> groups;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'groups': groups,
      };

  Arms copy() {
    return Arms(
      groups: groups.map((ArmsGroups e) => e.copy()).toList(),
    );
  }
}

class ArmsGroups {
  ArmsGroups({
    required this.type,
    required this.id,
    required this.name,
    this.img,
    required this.items,
  });

  factory ArmsGroups.fromJson(Map<String, dynamic> jsonRes) {
    final List<ArmsGroupsItems>? items =
        jsonRes['items'] is List ? <ArmsGroupsItems>[] : null;
    if (items != null) {
      for (final dynamic item in jsonRes['items']!) {
        if (item != null) {
          tryCatch(() {
            items.add(
                ArmsGroupsItems.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return ArmsGroups(
      type: asT<int>(jsonRes['type'])!,
      id: asT<int>(jsonRes['id'])!,
      name: asT<String>(jsonRes['name'])!,
      img: asT<Object?>(jsonRes['img']),
      items: items!,
    );
  }

  int type;
  int id;
  String name;
  Object? img;
  List<ArmsGroupsItems> items;

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

  ArmsGroups copy() {
    return ArmsGroups(
      type: type,
      id: id,
      name: name,
      img: img,
      items: items.map((ArmsGroupsItems e) => e.copy()).toList(),
    );
  }
}

class ArmsGroupsItems {
  ArmsGroupsItems({
    this.type,
    required this.id,
    this.topicId,
    this.sortId,
    required this.name,
    required this.img,
  });

  factory ArmsGroupsItems.fromJson(Map<String, dynamic> jsonRes) =>
      ArmsGroupsItems(
        type: asT<Object?>(jsonRes['type']),
        id: asT<int>(jsonRes['id'])!,
        topicId: asT<Object?>(jsonRes['topicId']),
        sortId: asT<Object?>(jsonRes['sortId']),
        name: asT<String>(jsonRes['name'])!,
        img: asT<String>(jsonRes['img'])!,
      );

  Object? type;
  int id;
  Object? topicId;
  Object? sortId;
  String name;
  String img;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'id': id,
        'topicId': topicId,
        'sortId': sortId,
        'name': name,
        'img': img,
      };

  ArmsGroupsItems copy() {
    return ArmsGroupsItems(
      type: type,
      id: id,
      topicId: topicId,
      sortId: sortId,
      name: name,
      img: img,
    );
  }
}

class BootMap {
  BootMap({
    required this.groups,
  });

  factory BootMap.fromJson(Map<String, dynamic> jsonRes) {
    final List<BootMapGroups>? groups =
        jsonRes['groups'] is List ? <BootMapGroups>[] : null;
    if (groups != null) {
      for (final dynamic item in jsonRes['groups']!) {
        if (item != null) {
          tryCatch(() {
            groups
                .add(BootMapGroups.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return BootMap(
      groups: groups!,
    );
  }

  List<BootMapGroups> groups;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'groups': groups,
      };

  BootMap copy() {
    return BootMap(
      groups: groups.map((BootMapGroups e) => e.copy()).toList(),
    );
  }
}

class BootMapGroups {
  BootMapGroups({
    required this.type,
    required this.typeName,
    required this.items,
  });

  factory BootMapGroups.fromJson(Map<String, dynamic> jsonRes) {
    final List<BootMapGroupsItems>? items =
        jsonRes['items'] is List ? <BootMapGroupsItems>[] : null;
    if (items != null) {
      for (final dynamic item in jsonRes['items']!) {
        if (item != null) {
          tryCatch(() {
            items.add(
                BootMapGroupsItems.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return BootMapGroups(
      type: asT<int>(jsonRes['type'])!,
      typeName: asT<String>(jsonRes['typeName'])!,
      items: items!,
    );
  }

  int type;
  String typeName;
  List<BootMapGroupsItems> items;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'typeName': typeName,
        'items': items,
      };

  BootMapGroups copy() {
    return BootMapGroups(
      type: type,
      typeName: typeName,
      items: items.map((BootMapGroupsItems e) => e.copy()).toList(),
    );
  }
}

class BootMapGroupsItems {
  BootMapGroupsItems({
    required this.id,
    required this.mapType,
    required this.mapName,
    required this.mapImg,
  });

  factory BootMapGroupsItems.fromJson(Map<String, dynamic> jsonRes) =>
      BootMapGroupsItems(
        id: asT<int>(jsonRes['id'])!,
        mapType: asT<int>(jsonRes['mapType'])!,
        mapName: asT<String>(jsonRes['mapName'])!,
        mapImg: asT<String>(jsonRes['mapImg'])!,
      );

  int id;
  int mapType;
  String mapName;
  String mapImg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'mapType': mapType,
        'mapName': mapName,
        'mapImg': mapImg,
      };

  BootMapGroupsItems copy() {
    return BootMapGroupsItems(
      id: id,
      mapType: mapType,
      mapName: mapName,
      mapImg: mapImg,
    );
  }
}
