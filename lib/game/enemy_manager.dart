import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:twee_owl_adventure/game/enemy.dart';
import 'package:twee_owl_adventure/game/game.dart';

class EnemyManager extends Component with HasGameRef<TweeOwlGame> {
  Random? _random;
  Timer? _timer;
  late int _spawnLevel;

  EnemyManager() {
    _random = Random();
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomNumber = _random!.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(randomEnemyType);

    gameRef.addLater(newEnemy);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    _timer!.start();
  }

  @override
  void render(Canvas c) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
    _timer!.update(t);

    var newSpawnLevel = (gameRef.score! ~/ 400);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.1 * _spawnLevel)));

      // debugPrint(newWaitTime.toString());

      _timer!.stop();

      _timer = Timer(newWaitTime, repeat: true, callback: () {
        spawnRandomEnemy();
      });

      _timer!.start();
    }
  }

  void reset() {
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
    _timer!.start();
  }
}
