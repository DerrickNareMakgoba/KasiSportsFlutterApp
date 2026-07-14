import 'package:flutter/material.dart';
import 'game_detail_screen.dart';
import 'tournament_detail_screen.dart';
import 'create_tournament_screen.dart';
import 'team_stats_screen.dart';

// Models
class Game {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final String time;
  final String venue;
  final double distance;
  final String status; // 'LIVE', 'UPCOMING', 'FINISHED'

  Game({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.time,
    required this.venue,
    required this.distance,
    required this.status,
  });
}

class Tournament {
  final String id;
  final String name;
  final String image;
  final String startDate;
  final String endDate;
  final String location;
  final double distance;
  final int teamsCount;

  Tournament({
    required this.id,
    required this.name,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.distance,
    required this.teamsCount,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeGameIndex = 0;
  int _activeTournamentIndex = 0;
  late PageController _gamePageController;
  late PageController _tournamentPageController;

  // Mock data for games
  final List<Game> games = [
    Game(
      id: '1',
      homeTeam: 'Ramongwana Pirates',
      awayTeam: 'Old Rock',
      homeTeamLogo: '⚽',
      awayTeamLogo: '⚽',
      time: '14:30',
      venue: 'GaRamogwana , Movers Stadium',
      distance: 2.3,
      status: 'LIVE',
    ),
    Game(
      id: '2',
      homeTeam: 'All Star',
      awayTeam: 'Bakwena FC',
      homeTeamLogo: '⚽',
      awayTeamLogo: '⚽',
      time: '16:00',
      venue: 'Moletjie Mabokelele',
      distance: 3.1,
      status: 'UPCOMING',
    ),
    Game(
      id: '3',
      homeTeam: 'Ramongwana Swallows',
      awayTeam: 'Staty Juventus',
      homeTeamLogo: '⚽',
      awayTeamLogo: '⚽',
      time: '18:30',
      venue: 'The Kgadi Stadium',
      distance: 4.5,
      status: 'UPCOMING',
    ),
    Game(
      id: '4',
      homeTeam: 'Semenya All Star',
      awayTeam: 'Thobejane FC',
      homeTeamLogo: '⚽',
      awayTeamLogo: '⚽',
      time: '20:00',
      venue: 'GaMabitsela Stadium',
      distance: 5.2,
      status: 'UPCOMING',
    ),
  ];

  // Mock data for tournaments
  final List<Tournament> tournaments = [
    Tournament(
      id: '1',
      name: 'The Kgadi tournament',
      image: '🏆',
      startDate: 'Jul 15',
      endDate: 'Aug 20',
      location: 'Gahlahla',
      distance: 1.8,
      teamsCount: 16,
    ),
    Tournament(
      id: '2',
      name: 'Summer Cup',
      image: '🏆',
      startDate: 'Jul 22',
      endDate: 'Aug 30',
      location: 'Thembisa',
      distance: 2.5,
      teamsCount: 24,
    ),
    Tournament(
      id: '3',
      name: 'Katlehong Tournament',
      image: '🏆',
      startDate: 'Aug 01',
      endDate: 'Oct 15',
      location: 'Katlehong',
      distance: 6.3,
      teamsCount: 12,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _gamePageController = PageController(viewportFraction: 0.85);
    _tournamentPageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _gamePageController.dispose();
    _tournamentPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Find games near you',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Live Games Section
                  Text(
                    'Live Games Near You',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Games Stack
                  SizedBox(
                    height: 320,
                    child: PageView.builder(
                      controller: _gamePageController,
                      onPageChanged: (index) {
                        setState(() {
                          _activeGameIndex = index;
                        });
                      },
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GameDetailScreen(game: games[index]),
                              ),
                            );
                          },
                          child: _buildGameCard(games[index], index),
                        );
                      },
                    ),
                  ),

                  // Indicator Dots for Games
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          games.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _activeGameIndex == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _activeGameIndex == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tournaments Section
                  Text(
                    'Tournaments Near You',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tournaments Stack
                  SizedBox(
                    height: 280,
                    child: PageView.builder(
                      controller: _tournamentPageController,
                      onPageChanged: (index) {
                        setState(() {
                          _activeTournamentIndex = index;
                        });
                      },
                      itemCount: tournaments.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TournamentDetailScreen(
                                  tournament: tournaments[index],
                                ),
                              ),
                            );
                          },
                          child: _buildTournamentCard(
                            tournaments[index],
                            index,
                          ),
                        );
                      },
                    ),
                  ),

                  // Indicator Dots for Tournaments
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          tournaments.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _activeTournamentIndex == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _activeTournamentIndex == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: _buildEndDrawer(context),
    );
  }

  Widget _buildEndDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade900],
          ),
        ),
        child: ListView(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'My Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),

            // Menu Items
            _buildMenuTile(
              context,
              icon: Icons.add_circle_outline,
              label: 'Create Tournament',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTournamentScreen(),
                  ),
                );
              },
            ),
            _buildMenuTile(
              context,
              icon: Icons.sports_soccer_outlined,
              label: 'Team & Player Stats',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamStatsScreen(),
                  ),
                );
              },
            ),
            _buildMenuTile(
              context,
              icon: Icons.person_search_outlined,
              label: 'Browse Players',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamStatsScreen(),
                  ),
                );
              },
            ),
            _buildMenuTile(
              context,
              icon: Icons.favorite_outline,
              label: 'My Favorites',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Favorites coming soon!')),
                );
              },
            ),
            _buildMenuTile(
              context,
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings coming soon!')),
                );
              },
            ),

            const Spacer(),
            const Divider(color: Colors.white24),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildGameCard(Game game, int index) {
    bool isLive = game.status == 'LIVE';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isLive
              ? [Colors.red.shade400, Colors.red.shade700]
              : [Colors.blue.shade400, Colors.blue.shade700],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      if (isLive)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(right: 6),
                        ),
                      Text(
                        game.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${game.distance} km',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            // Time
            Text(
              game.time,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        game.homeTeamLogo,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game.homeTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'vs',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        game.awayTeamLogo,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game.awayTeam,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Venue
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.stadium_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  game.venue,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            // Tap to view details
            Text(
              'Tap to view details',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentCard(Tournament tournament, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.amber.shade400, Colors.orange.shade700],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo and distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tournament.image, style: const TextStyle(fontSize: 32)),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${tournament.distance} km',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Tournament Name
            Text(
              tournament.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Date Range
            Text(
              '${tournament.startDate} - ${tournament.endDate}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),

            // Location
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tournament.location,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Teams Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${tournament.teamsCount} Teams',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Tap to view details
            Text(
              'Tap to view details',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
