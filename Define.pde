// 定数宣言領域
// 0:mouse,1:keyboard
final int MouseOrKeyboard = 0;

// デバッグモード、あたり判定の表示とか
final boolean DEBUGMODE = false;

final int FCShow = 0;
final int FCDead = 1;
final int FCShot = 2;
final int FCBomb = 3;

static final int SoundMax = 2;   // 効果音の最大数  
static final int EnemyMax = 100; // 敵の最大数
static final int EBulletMax = 10000;// 敵ショットの最大数
final int CBulletClrMax = 3;  // 自機ショットのカラーパターン
final int EBulletClrMax = 3;  // 敵ショットのカラーパターン
final int CBulletMax    = 20; // 自機ショットの最大数
final int CShotTime     = 10; // 自機ショットの間隔
final int GoalLine = 3600 * 2 + 100;// ゴールのライン出現時間(1分:3600cnt)


final int MukiR = 1; // 右向きは -1
final int MukiL = -1;// 左向きは  1
final int MukiU = -1; // 右向きは -1
final int MukiD = 1;// 左向きは  1

