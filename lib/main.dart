import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: startpage());
  }
}

class startpage extends StatefulWidget {
  const startpage({super.key});

  @override
  State<startpage> createState() => _startpageState();
}

class _startpageState extends State<startpage> {
  final PlayerAcontroller = TextEditingController();
  final PlayerBcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090914),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 55),

              // GAME TITLE
              const Text(
                "FINGER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
              ),

              const Text(
                "TAPPP",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "TAP FASTER. WIN HARDER.",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const Spacer(),

              // PLAYER A
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF17172A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.redAccent.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: PlayerAcontroller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    labelText: "PLAYER A",
                    labelStyle: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Enter your name",
                    hintStyle: const TextStyle(color: Colors.white30),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // VS
              const Text(
                "VS",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 18),

              // PLAYER B
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF17172A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: TextField(
                  controller: PlayerBcontroller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                    labelText: "PLAYER B",
                    labelStyle: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Enter your name",
                    hintStyle: const TextStyle(color: Colors.white30),
                  ),
                ),
              ),

              const Spacer(),

              // START BUTTON
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    String playerA = PlayerAcontroller.text.trim();
                    String playerB = PlayerBcontroller.text.trim();

                    if (playerA.isEmpty || playerB.isEmpty) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gamepage(
                          playerA: playerA,
                          playerB: playerB,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    elevation: 10,
                    shadowColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, size: 28),
                      SizedBox(width: 10),
                      Text(
                        "START GAME",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "⚡ READY TO TAP?",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
class Gamepage extends StatefulWidget {
  final String playerA;
  final String playerB;

  const Gamepage({
    super.key,
    required this.playerA,
    required this.playerB,
  });

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  double bluecardheight = 0;

  int playerAscore = 0;
  int playerBscore = 0;

  bool gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090914),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenheight = constraints.maxHeight;

            const double vsHeight = 35;

            final double availableHeight =
                screenheight - vsHeight;

            // Starting 50 / 50
            if (bluecardheight == 0) {
              bluecardheight = availableHeight / 2;
            }

            final double redcardheight =
                availableHeight - bluecardheight;

            return Column(
              children: [

                // =================================================
                // PLAYER B
                // =================================================

                GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onTap: () {
                    if (gameOver) return;

                    setState(() {
                      bluecardheight =
                          (bluecardheight + 30).clamp(
                        0.0,
                        availableHeight,
                      );

                      playerBscore += 5;
                    });

                    // PLAYER B WINS
                    if (bluecardheight >= availableHeight) {
                      gameOver = true;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            playerBscore,
                            widget.playerB,
                            Colors.blueAccent,
                          ),
                        ),
                      );
                    }
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,

                    width: double.infinity,
                    height: bluecardheight,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2563EB),
                          Color(0xFF3B82F6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.35),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),

                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Icon(
                              Icons.touch_app,
                              size: 55,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              widget.playerB,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "TAP!",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              "$playerBscore",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // =================================================
                // VS
                // =================================================

                Container(
                  height: vsHeight,
                  width: double.infinity,

                  color: const Color(0xFF090914),

                  child: const Center(
                    child: Text(
                      "VS",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                // =================================================
                // PLAYER A
                // =================================================

                GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onTap: () {
                    if (gameOver) return;

                    setState(() {
                      bluecardheight =
                          (bluecardheight - 30).clamp(
                        0.0,
                        availableHeight,
                      );

                      playerAscore += 5;
                    });

                    // PLAYER A WINS
                    final double newRedHeight =
                        availableHeight - bluecardheight;

                    if (newRedHeight >= availableHeight) {
                      gameOver = true;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            playerAscore,
                            widget.playerA,
                            Colors.redAccent,
                          ),
                        ),
                      );
                    }
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,

                    width: double.infinity,
                    height: redcardheight,

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFDC2626),
                          Color(0xFFEF4444),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),

                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.35),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),

                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Icon(
                              Icons.touch_app,
                              size: 55,
                              color: Colors.white,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              widget.playerA,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "TAP!",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              "$playerAscore",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class ResultPage extends StatelessWidget {
  final int score;
  final String Playername;
  final Color winnercolor;

  const ResultPage(
    this.score,
    this.Playername,
    this.winnercolor, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090914),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // TROPHY
                Container(
                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: winnercolor.withOpacity(0.15),
                    border: Border.all(
                      color: winnercolor.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: winnercolor.withOpacity(0.35),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),

                  child: Icon(
                    Icons.emoji_events,
                    size: 65,
                    color: winnercolor,
                  ),
                ),

                const SizedBox(height: 30),

                // WINNER
                const Text(
                  "WINNER!",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),

                const SizedBox(height: 10),

                // PLAYER NAME
                Text(
                  Playername,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: winnercolor,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 30),

                // SCORE CARD
                // SCORE
Column(
  children: [
    const Text(
      "FINAL SCORE",
      style: TextStyle(
        color: Colors.white38,
        fontSize: 13,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
    ),

    const SizedBox(height: 5),

    Text(
      "$score",
      style: TextStyle(
        color: winnercolor,
        fontSize: 52,
        fontWeight: FontWeight.w900,
        shadows: [
          Shadow(
            color: winnercolor.withOpacity(0.7),
            blurRadius: 20,
          ),
        ],
      ),
    ),

    const SizedBox(height: 4),

    Container(
      width: 70,
      height: 3,
      decoration: BoxDecoration(
        color: winnercolor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: winnercolor.withOpacity(0.6),
            blurRadius: 10,
          ),
        ],
      ),
    ),
  ],
),

                const SizedBox(height: 35),

                // PLAY AGAIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const startpage(),
                        ),
                        (route) => false,
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: winnercolor,
                      foregroundColor: Colors.white,
                      elevation: 10,
                      shadowColor: winnercolor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.replay,
                          size: 25,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "PLAY AGAIN",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "READY FOR ANOTHER ROUND?",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}