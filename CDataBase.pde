static class CDetaBase{
  // グローバル変数------------------------------------------------------------------------------------------
  static int GameCount;// ゲームの進行を司る変数
  static boolean[] fSound = new boolean[SoundMax];// 鳴らす音の選択
  static int Score;
  // 時間用  ->  static int TimeCnt,TimeDown;
  
  // Charaのデータ------------------------------------------------------------------------------------------
  static int   CharaX;   // キャラのX座標
  static int   CharaY;   // キャラのY座標
  static int   CharaR;   // キャラのあたり判定
  static int   CharaMuki;// キャラの向き
  static int   CharaHP;  // キャラの体力
  static int CharaHPMax; // キャラの体力の最大値
  static float CharaSpd; // キャラのスピード
  // FCShow,FCDead,FCShot,FCBomb
  static boolean[] CharaFlags = {false,false,false,false};
  // キャラクター初期化関数
  static void iniCharaData(int x,int y,int r,int muki,int hp,float spd){
    CharaX = x;CharaY = y;CharaR = r;CharaMuki = muki;CharaHP = hp;CharaSpd = spd;CharaHPMax = hp;
  }
  
  // Enemyのデータ------------------------------------------------------------------------------------------
  static float[]   EnemyX     = new float[EnemyMax];    // 敵のX座標
  static float[]   EnemyY     = new float[EnemyMax];    // 敵のY座標
  static float[]   EnemyR     = new float[EnemyMax];    // 敵のあたり判定
  static int[]     EnemyMuki  = new int[EnemyMax];      // 敵の向き
  static int[]     EnemyHP    = new int[EnemyMax];      // 敵の体力
  static int[]     EnemyHPMax = new int[EnemyMax];      // 敵の体力最大値
  static boolean[] EFBoss     = new boolean[EnemyMax];    // ボスフラグ
  static boolean[] EnemyFlag  = new boolean[EnemyMax];  // 敵の出現フラグ
  // 敵の初期化関数
  static void iniEnemyData(int id,float x,float y,float r,int muki,int hp,boolean flag){
    EnemyX[id] = x;EnemyY[id] = y;EnemyR[id] = r;EnemyMuki[id] = muki;EnemyHP[id] = hp;EnemyHPMax[id] = hp;EnemyFlag[id] = flag;
  }
  
}
