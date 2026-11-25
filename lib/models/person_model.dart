// ignore_for_file: deprecated_member_use
/// Followers / Following list ka aik banda
class Person {
  final String id;
  final String name;
  final String username;
  final String initials;

  /// UserAvatar ka style: 0 = sand, 1 = terracotta, 2 = charcoal
  final int avatarStyle;
  final bool isFollowing;

  const Person({
    required this.id,
    required this.name,
    required this.username,
    required this.initials,
    required this.avatarStyle,
    this.isFollowing = false,
  });

  Person copyWith({bool? isFollowing}) => Person(
    id: id,
    name: name,
    username: username,
    initials: initials,
    avatarStyle: avatarStyle,
    isFollowing: isFollowing ?? this.isFollowing,
  );

  ////  later on API use here (fromJson) ////
}

/// Dummy data later remove and we use api ////
const List<Person> dummyFollowers = [
  Person(
    id: '1',
    name: 'Sofia Marchetti',
    username: 'sofia.bites',
    initials: 'SM',
    avatarStyle: 0,
    isFollowing: true,
  ),
  Person(
    id: '2',
    name: 'Lucas Meyer',
    username: 'lucas.m',
    initials: 'LM',
    avatarStyle: 1,
  ),
  Person(
    id: '3',
    name: 'Hira Khan',
    username: 'hira.cooks',
    initials: 'HK',
    avatarStyle: 2,
    isFollowing: true,
  ),
  Person(
    id: '4',
    name: 'Priya Nair',
    username: 'priya.n',
    initials: 'PN',
    avatarStyle: 0,
  ),
  Person(
    id: '5',
    name: 'Omar Siddiqui',
    username: 'omar.s',
    initials: 'OS',
    avatarStyle: 1,
    isFollowing: true,
  ),
  Person(
    id: '6',
    name: 'Mei Tanaka',
    username: 'mei.tanaka',
    initials: 'MT',
    avatarStyle: 2,
  ),
  Person(
    id: '7',
    name: 'Amina Raza',
    username: 'amina.eats',
    initials: 'AR',
    avatarStyle: 1,
    isFollowing: true,
  ),
  Person(
    id: '8',
    name: 'Noah Reyes',
    username: 'noah.r',
    initials: 'NR',
    avatarStyle: 0,
  ),
];

/// "Following" tab ke liye (jin ko ye banda follow karta hai)
const List<Person> dummyFollowing = [
  Person(
    id: '1',
    name: 'Amina Raza',
    username: 'amina.eats',
    initials: 'AR',
    avatarStyle: 1,
    isFollowing: true,
  ),
  Person(
    id: '2',
    name: 'Hira Khan',
    username: 'hira.cooks',
    initials: 'HK',
    avatarStyle: 2,
    isFollowing: true,
  ),
  Person(
    id: '3',
    name: 'Sofia Marchetti',
    username: 'sofia.bites',
    initials: 'SM',
    avatarStyle: 0,
    isFollowing: true,
  ),
];
