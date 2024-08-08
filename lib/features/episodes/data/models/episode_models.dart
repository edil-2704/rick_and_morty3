// To parse this JSON data, do
//
//     final episodeModel = episodeModelFromJson(jsonString);

import 'dart:convert';

EpisodeModel episodeModelFromJson(String str) => EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());

class EpisodeModel {
    final EpisodeInfo? info;
    final List<EpisodeResult>? results;

    EpisodeModel({
        this.info,
        this.results,
    });

    factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        info: json["info"] == null ? null : EpisodeInfo.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<EpisodeResult>.from(json["results"]!.map((x) => EpisodeResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class EpisodeInfo {
    final int? count;
    final int? pages;
    final String? next;
    final dynamic prev;

    EpisodeInfo({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    factory EpisodeInfo.fromJson(Map<String, dynamic> json) => EpisodeInfo(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class EpisodeResult {
    final int? id;
    final String? name;
    final String? airDate;
    final String? episode;
    final List<String>? characters;
    final String? url;
    final DateTime? created;

    EpisodeResult({
        this.id,
        this.name,
        this.airDate,
        this.episode,
        this.characters,
        this.url,
        this.created,
    });

    factory EpisodeResult.fromJson(Map<String, dynamic> json) => EpisodeResult(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null ? [] : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null ? [] : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}
