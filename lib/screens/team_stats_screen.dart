import 'package:flutter/material.dart';
import 'player_stats_screen.dart';

class Player {
  final String id;
  final String name;
  final int number;
  final String position;
  final int goals;
  final int assists;
  final int matches;
  final double rating;

  Player({
    required this.id,
    required this.name,
    required this.number,
    required this.position,
    required this.goals,
    required this.assists,
    required this.matches,
    required this.rating,
  });
}

class Team {
  final String id;
  final String name;
  final String logo;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final List<Player> players;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.players,
  });

  int get points => (wins * 3) + draws;
}

class TeamStatsScreen extends StatefulWidget {
  const TeamStatsScreen({super.key});

  @override
  State<TeamStatsScreen> createState() => _TeamStatsScreenState();
}

class _TeamStatsScreenState extends State<TeamStatsScreen> {
  late List<Team> teams;
  int _selectedTeamIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    teams = [
      Team(
        id: '1',
        name: 'Manchester United',
        logo: '⚽',
        wins: 12,
        draws: 3,
        losses: 2,
        goalsFor: 45,
        goalsAgainst: 15,
        players: [
          Player(
            id: '1',
            name: 'Marcus Rashford',
            number: 10,
            position: 'Forward',
            goals: 18,
            assists: 5,
            matches: 15,
            rating: 8.5,
          ),
          Player(
            id: '2',
            name: 'Bruno Fernandes',
            number: 8,
            position: 'Midfielder',
            goals: 8,
            assists: 12,
            matches: 17,
            rating: 8.7,
          ),
          Player(
            id: '3',
            name: 'Harry Maguire',
            number: 5,
            position: 'Defender',
            goals: 2,
            assists: 0,
            matches: 15,
            rating: 7.2,
          ),
          Player(
            id: '4',
            name: 'David de Gea',
            number: 1,
            position: 'Goalkeeper',
            goals: 0,
            assists: 0,
            matches: 17,
            rating: 7.8,
          ),
        ],
      ),
      Team(
        id: '2',
        name: 'Liverpool',
        logo: '⚽',
        wins: 14,
        draws: 1,
        losses: 2,
        goalsFor: 52,
        goalsAgainst: 12,
        players: [
          Player(
            id: '5',
            name: 'Mohamed Salah',
            number: 11,
            position: 'Forward',
            goals: 22,
            assists: 8,
            matches: 16,
            rating: 8.9,
          ),
          Player(
            id: '6',
            name: 'Sadio Mané',
            number: 7,
            position: 'Forward',
            goals: 15,
            assists: 6,
            matches: 14,
            rating: 8.4,
          ),
          Player(
            id: '7',
            name: 'Virgil van Dijk',
            number: 4,
            position: 'Defender',
            goals: 3,
            assists: 1,
            matches: 17,
            rating: 8.6,
          ),
          Player(
            id: '8',
            name: 'Alisson',
            number: 1,
            position: 'Goalkeeper',
            goals: 0,
            assists: 0,
            matches: 17,
            rating: 8.1,
          ),
        ],
      ),
      Team(
        id: '3',
        name: 'Chelsea',
        logo: '⚽',
        wins: 10,
        draws: 4,
        losses: 3,
        goalsFor: 38,
        goalsAgainst: 18,
        players: [
          Player(
            id: '9',
            name: 'Cole Palmer',
            number: 20,
            position: 'Forward',
            goals: 14,
            assists: 4,
            matches: 14,
            rating: 8.2,
          ),
          Player(
            id: '10',
            name: 'Enzo Fernández',
            number: 8,
            position: 'Midfielder',
            goals: 5,
            assists: 8,
            matches: 15,
            rating: 7.9,
          ),
          Player(
            id: '11',
            name: 'Reece James',
            number: 24,
            position: 'Defender',
            goals: 2,
            assists: 3,
            matches: 12,
            rating: 7.5,
          ),
          Player(
            id: '12',
            name: 'Robert Sánchez',
            number: 1,
            position: 'Goalkeeper',
            goals: 0,
            assists: 0,
            matches: 17,
            rating: 7.3,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedTeam = teams[_selectedTeamIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade900],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Team Stats',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),

                // Team Selection
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedTeamIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTeamIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.1),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                teams[index].logo,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                teams[index].name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.deepPurple.shade600
                                      : Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Team Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Title
                        Text(
                          '${selectedTeam.name} Statistics',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Stats Grid
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.5,
                          children: [
                            _buildStatCard(
                              'Wins',
                              '${selectedTeam.wins}',
                              Colors.green.shade400,
                            ),
                            _buildStatCard(
                              'Draws',
                              '${selectedTeam.draws}',
                              Colors.yellow.shade600,
                            ),
                            _buildStatCard(
                              'Losses',
                              '${selectedTeam.losses}',
                              Colors.red.shade400,
                            ),
                            _buildStatCard(
                              'Points',
                              '${selectedTeam.points}',
                              Colors.blue.shade400,
                            ),
                            _buildStatCard(
                              'Goals For',
                              '${selectedTeam.goalsFor}',
                              Colors.amber.shade400,
                            ),
                            _buildStatCard(
                              'Goals Against',
                              '${selectedTeam.goalsAgainst}',
                              Colors.orange.shade400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Players Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Squad Players',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...selectedTeam.players.map((player) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlayerStatsScreen(player: player),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withValues(alpha: 0.1),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Player Number
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade500,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${player.number}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Player Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        player.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        player.position,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withValues(
                                            alpha: 0.7,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Player Stats
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '⚽ ${player.goals}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '⭐ ${player.rating}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Tap for details',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withValues(
                                          alpha: 0.5,
                                        ),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
