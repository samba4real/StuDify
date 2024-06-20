import 'dart:convert';
import 'package:flutter/foundation.dart';

class Profile {
  final String gender;
  final int age;
  final String favTimeToRead;
  final List<String> goals;
  final List<String> areasToElevate;
  final String timeSpendOnBooks;
  final List<String> mentors;
  Profile({
    required this.gender,
    required this.age,
    required this.favTimeToRead,
    required this.goals,
    required this.areasToElevate,
    required this.timeSpendOnBooks,
    required this.mentors,
  });

  Profile copyWith({
    String? gender,
    int? age,
    String? favTimeToRead,
    List<String>? goals,
    List<String>? areasToElevate,
    String? timeSpendOnBooks,
    List<String>? mentors,
  }) {
    return Profile(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      favTimeToRead: favTimeToRead ?? this.favTimeToRead,
      goals: goals ?? this.goals,
      areasToElevate: areasToElevate ?? this.areasToElevate,
      timeSpendOnBooks: timeSpendOnBooks ?? this.timeSpendOnBooks,
      mentors: mentors ?? this.mentors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'age': age,
      'favTimeToRead': favTimeToRead,
      'goals': goals,
      'areasToElevate': areasToElevate,
      'timeSpendOnBooks': timeSpendOnBooks,
      'mentors': mentors,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      gender: map['gender'] ?? '',
      age: map['age']?.toInt() ?? 0,
      favTimeToRead: map['favTimeToRead'] ?? '',
      goals: List<String>.from(map['goals']),
      areasToElevate: List<String>.from(map['areasToElevate']),
      timeSpendOnBooks: map['timeSpendOnBooks'] ?? '',
      mentors: List<String>.from(map['mentors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(gender: $gender, age: $age, favTimeToRead: $favTimeToRead, goals: $goals, areasToElevate: $areasToElevate, timeSpendOnBooks: $timeSpendOnBooks, mentors: $mentors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.gender == gender &&
        other.age == age &&
        other.favTimeToRead == favTimeToRead &&
        listEquals(other.goals, goals) &&
        listEquals(other.areasToElevate, areasToElevate) &&
        other.timeSpendOnBooks == timeSpendOnBooks &&
        listEquals(other.mentors, mentors);
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        age.hashCode ^
        favTimeToRead.hashCode ^
        goals.hashCode ^
        areasToElevate.hashCode ^
        timeSpendOnBooks.hashCode ^
        mentors.hashCode;
  }
}
