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
  @override
  State<startpage> createState() => _startpageState();
}

class _startpageState extends State<startpage> {
  final PlayerAcontroller = TextEditingController();

  final PlayerBcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finger Tappp"),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),

      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: PlayerAcontroller,
              decoration: InputDecoration(
                labelText: "Enter Player A Name:",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: PlayerBcontroller,
              decoration: InputDecoration(
                labelText: "Enter Player B Name:",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),

            MaterialButton(
              onPressed: () {
                String playerA = PlayerAcontroller.text.trim();
                String playerB = PlayerBcontroller.text.trim();

                if (playerA.isEmpty || playerB.isEmpty) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Gamepage(playerA: playerA, playerB: playerB),
                  ),
                );
              },
              shape: CircleBorder(),
              padding: EdgeInsets.all(50),
              color: Colors.red,
              child: Text("START WOOO!"),
            ),
          ],
        ),
      ),
    );
  }
}

class Gamepage extends StatefulWidget {
  final String playerA;
  final String playerB;
  Gamepage({super.key, required this.playerA, required this.playerB});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  double bluecardheight = 0;
  int playerAscore = 0;

  int playerBscore = 0;
  bool heightset = false;
  bool gameOver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenheight = constraints.maxHeight;
          if (!heightset && screenheight > 0) {
            bluecardheight = screenheight / 2;

            heightset = true;
          }
          double winningheight = screenheight - 60;

          return Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (gameOver) return; // ignore taps after game ends

                  setState(() {
                    bluecardheight = (bluecardheight + 30).clamp(
                      0.0,
                      screenheight,
                    );
                    playerBscore += 5;
                  });

                  if (bluecardheight > winningheight) {
                    gameOver = true;
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ResultPage(
                              playerBscore,
                              widget.playerB,
                              Colors.blueAccent,
                            ),
                      ),
                    );
                  }
                },

                child: Container(
                  width: double.infinity,
                  height: bluecardheight,
                  color: Colors.blueAccent,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.playerB,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (gameOver) return; // ignore taps after game ends

                  setState(() {
                    bluecardheight = (bluecardheight - 30).clamp(
                      0.0,
                      screenheight,
                    );
                    playerAscore += 5;
                  });
                  double redcardheight = screenheight - bluecardheight;
                  if (redcardheight >= winningheight) {
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
                child: Container(
                  width: double.infinity,
                  height: screenheight - bluecardheight,
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.playerA,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final String Playername;
  final Color winnercolor;
  ResultPage(this.score, this.Playername, this.winnercolor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: winnercolor,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score.toString(),
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Text("$Playername WON!!", style: TextStyle(fontSize: 30)),

            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => startpage()),
                  (route) => false,
                );
              },
              color: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(),
              padding: EdgeInsets.all(10),
              child: Text(
                "Play Again!!",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
