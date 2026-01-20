import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double kDefaultPadding = 20.0;
const double kGridSpacing = 16.0;

class User {
  final String name;
  final String role;
  final String profileImagePath;

  const User({
    required this.name,
    required this.role,
    required this.profileImagePath,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _currentUser = User(
    name: 'Ghifari Atallah',
    role: 'Fullstack Developer',
    profileImagePath: 'assets/images/profile.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        top: false, // ← Biarkan appbar di atas safe area
        bottom: true, // ← Hanya aktifkan di bawah
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // AppBar
            SliverAppBar(
              expandedHeight: 150,
              floating: true, // ← Ubah jadi true
              snap: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: null, // ← Tambahkan ini untuk menghapus tombol back
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.2,
                title: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade600.withOpacity(0.9),
                          Colors.purple.shade600.withOpacity(0.9),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade200.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: const Color.fromARGB(255, 255, 0, 0),
                          size: 27,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'QRizz',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade100, Colors.purple.shade50],
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade400, Colors.red.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),

            // Main content - PAKAI SliverList agar lebih fleksibel
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    top: 24, // ← Kurangi dari 24
                    bottom:
                        MediaQuery.of(context).padding.bottom +
                        40, // ← Tambah dynamic padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Profile Card
                      Container(
                        padding: const EdgeInsets.all(20), // ← Kurangi dari 24
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.purple.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.8),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.shade100.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Profile Avatar
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.purple.shade400,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade300.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: FutureBuilder<ByteData>(
                                future: rootBundle.load(
                                  _currentUser.profileImagePath,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      radius: 34, // ← Kecilkan sedikit
                                      backgroundColor: Colors.black,
                                      backgroundImage: AssetImage(
                                        _currentUser.profileImagePath,
                                      ),
                                    );
                                  } else {
                                    return CircleAvatar(
                                      radius: 34,
                                      backgroundColor: Colors.blue.shade100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 36, // ← Kecilkan
                                            color: Colors.blue.shade600,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _currentUser.name
                                                .split(' ')
                                                .first[0],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16), // ← Kurangi dari 20
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, Ghifari Atallah! 👋',
                                    style: TextStyle(
                                      fontSize: 20, // ← Kecilkan dari 22
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green.shade100,
                                          Colors.teal.shade100,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _currentUser.role,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.teal.shade900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24), // ← Kurangi dari 32
                      // Welcome Text
                      Container(
                        padding: const EdgeInsets.all(16), // ← Kurangi dari 20
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.orange.shade100,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.celebration,
                                  color: Colors.orange.shade700,
                                  size: 24, // ← Kecilkan
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Welcome to',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16, // ← Kecilkan
                                    color: Colors.orange.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'QRizz ',
                                    style: TextStyle(
                                      fontSize: 30, // ← Kecilkan dari 36
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader =
                                            LinearGradient(
                                              colors: [
                                                Colors.blue.shade700,
                                                Colors.purple.shade700,
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0,
                                                0,
                                                200,
                                                70,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '🤫',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12), // ← Jangan pakai 100!
                            Text(
                              'Create, Scan & Manage QR Codes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Grid Menu
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: kGridSpacing,
                        crossAxisSpacing: kGridSpacing,
                        childAspectRatio: 0.95, // ← Kurangi dari 1.0
                        children: const [
                          _MenuButton(
                            icon: Icons.qr_code_2,
                            label: 'Create QR',
                            color: Color(0xFF3B82F6),
                            gradientColors: [
                              Color(0xFF3B82F6),
                              Color(0xFF1D4ED8),
                            ],
                            iconColor: Colors.white,
                            route: '/create',
                          ),
                          _MenuButton(
                            icon: Icons.qr_code_scanner,
                            label: 'Scan QR',
                            color: Color(0xFFEF4444),
                            gradientColors: [
                              Color(0xFFEF4444),
                              Color(0xFFDC2626),
                            ],
                            iconColor: Colors.white,
                            route: '/scan',
                          ),
                          _MenuButton(
                            icon: Icons.send,
                            label: 'Share QR',
                            color: Color(0xFF10B981),
                            gradientColors: [
                              Color(0xFF10B981),
                              Color(0xFF059669),
                            ],
                            iconColor: Colors.white,
                            route: '',
                          ),
                          _MenuButton(
                            icon: Icons.print,
                            label: 'Print QR',
                            color: Color(0xFF8B5CF6),
                            gradientColors: [
                              Color(0xFF8B5CF6),
                              Color(0xFF7C3AED),
                            ],
                            iconColor: Colors.white,
                            route: '/print',
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Quick Stats
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.teal.shade50, Colors.blue.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.teal.shade100,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              icon: Icons.qr_code,
                              value: '+100',
                              label: 'Created',
                              color: Colors.blue,
                            ),
                            _StatItem(
                              icon: Icons.scanner,
                              value: '+500',
                              label: 'Scanned',
                              color: Colors.green,
                            ),
                            _StatItem(
                              icon: Icons.share,
                              value: '+100',
                              label: 'Shared',
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ),

                      // Tambah EXTRA SPACE di bawah
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 32,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.gradientColors,
    required this.iconColor,
    required this.route,
  });

  final IconData icon;
  final String label;
  final Color color;
  final List<Color> gradientColors;
  final Color iconColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: route.isNotEmpty
          ? () => Navigator.pushNamed(context, route)
          : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20), // ← Kecilkan dari 24
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60, // ← Kecilkan dari 70
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 32,
                  ), // ← Kecilkan dari 36
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14, // ← Kecilkan dari 16
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                if (route.isEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3), width: 2),
          ),
          child: Icon(icon, color: color, size: 20), // ← Kecilkan
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 20, // ← Kecilkan dari 24
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}
