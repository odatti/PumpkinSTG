class CEnemyMgr {
  private CEnemy[]    m_Enemy      = new CEnemy[EnemyMax];
  private CEBulletMgr m_EBulletMgr = new CEBulletMgr();

  // 敵コンストラクタ
  CEnemyMgr() { for (int i = 0;i < EnemyMax;i++) {m_Enemy[i] = new CEnemy(i);}}
  // 敵の登録関数(座標とパターンを登録する)
  private void setEnemy(int mp, int ini, int bp, int time, int hp,boolean boss) {
    for (int i = 0;i < EnemyMax;i++) {
      if(!data.EnemyFlag[i]){
        m_Enemy[i].setEnemy(ini,mp,hp,boss);
        m_EBulletMgr.setEBullet(i, bp, time);
        return;
      }
    }
    println("出現させられる敵がいません");
  }
  // メイン関数
  public void Main() {
    CountMgr();// 敵や弾幕の制御関数
    EnemyJudge();// 敵のメイン処理
    m_EBulletMgr.Main();// 弾幕の処理
  }
  // いろいろな判定
  private void EnemyJudge() {
    for (int i = 0;i < EnemyMax;i++) {
      if (data.EnemyFlag[i]) {// 表示フラグがONなら
        EPatternMain(i, m_Enemy[i].Ptn, m_Enemy[i].Cnt);// 敵の行動パターンに従って移動する
        m_Enemy[i].Main();// 敵のメイン処理
        
        if (data.EnemyHP[m_Enemy[i].E_ID] <= 0) { data.EnemyFlag[i] = false;data.fSound[1] = true;}// 体力が尽きたら
        if (!data.EnemyFlag[i]) {m_Enemy[i].resetEnemy(i);}// 上の処理で表示フラグが消されたら、敵の情報をリセットする
      }
    }
  }

/*
** ゲームの進行を司る関数()
** setEnemy(敵の行動、行動の初期化選択、敵の弾幕、発射時間、敵の体力);
** if(data.GameCount == NUMBER ){setEnemy();}
*/
  private void CountMgr() {
//    data.CharaHP = 100;
    switch(data.GameCount){
        case  100: setEnemy(2, 0, 0,  50, 16, false); break;
        case  200: setEnemy(2, 1, 0,  50, 16, false); break;
        case  300: setEnemy(2, 0, 0,  50, 16, false); break;
        case  400: setEnemy(2, 1, 0,  50, 16, false); break;
        
        case 1200: setEnemy(0, 0, 1, 150, 30, false);
                   setEnemy(0, 1, 1, 150, 30, false); break;
        case 1900: setEnemy(1, 1, 4,  50, 20, false); break;
        case 2400: setEnemy(1, 0, 4,  50, 20, false); break;
        case 2900: setEnemy(1, 1, 4,  50, 20, false); break;
        case 3400: setEnemy(1, 0, 4,  50, 20, false); break;
        case 4400: setEnemy(0, 0, 3, 150, 16, false);
                   setEnemy(0, 2, 2, 150, 18, false);
                   setEnemy(0, 1, 3, 150, 16, false); break;//next5000

        case 5300: setEnemy(10, 2, 2, 200, 180,  true); break;// ボス
    }
  }

/*
** パターン作成メソッド
** ここに敵の移動処理を記述する
** ｶﾞﾝﾊﾞﾚ
*/
  private void EPatternMain(int id, int ptn, int cnt) {// id:敵の識別番号、ptn:敵の行動パターン、cnt:敵の行動タイミング
    switch(ptn) {
    case 0:// 出てきて停止し、時間が来たら帰ってく (待機時間：500cnt)
      if (cnt == 0) {// 初期化
        data.EnemyX[id] = width + 100;
        if(m_Enemy[id].iPtn == 0){data.EnemyY[id] = height/4;}   // 上半分
        if(m_Enemy[id].iPtn == 1){data.EnemyY[id] = height/4*3;} // 下半分
        if(m_Enemy[id].iPtn == 2){data.EnemyY[id] = height/2;} // 下半分
      }
      if (cnt <= 100){                     // 前進
        if (cnt%2 == 0)data.EnemyX[id]-=5;
      }else if (100 < cnt && cnt <= 600) { // 待機
      }else if (600 < cnt && cnt <= 700) { // 後進
        if (cnt%2 == 0)data.EnemyX[id]+=5;
      }else {data.EnemyFlag[id] = false;}  // 削除
      break;
    case 1:// 上からheight/2分だけ下に下がった状態で100の範囲をサイン波の動き
      if (cnt == 0) {// 初期化
//        data.EnemyY[id] = height/2;
        if(m_Enemy[id].iPtn == 0){data.EnemyY[id] = height/4;}   // 上半分
        if(m_Enemy[id].iPtn == 1){data.EnemyY[id] = height/4*3;} // 下半分
        if(m_Enemy[id].iPtn == 2){data.EnemyY[id] = height/2;} // 半分
        data.EnemyX[id] = width + 100;
      }
      data.EnemyY[id] = (int)(100 * sin((PI/64)*m_Enemy[id].Cnt));
      if(m_Enemy[id].iPtn == 0){data.EnemyY[id] += height/4;}   // 上半分
      if(m_Enemy[id].iPtn == 1){data.EnemyY[id] += height/4*3;} // 下半分
      if(m_Enemy[id].iPtn == 2){data.EnemyY[id] += height/2;} // 半分
      data.EnemyX[id]--;
      if (data.EnemyX[id] < -100) {
        data.EnemyFlag[id] = false;
      }
      break;
    case 2:// 上からheight/2分だけ下に下がった状態で100の範囲をサイン波の動き
      if (cnt == 0) {// 初期化
        if(m_Enemy[id].iPtn == 2){println("引数ミスってるよ＠えねみーむーぶけーす２");} // 半分
        data.EnemyX[id] = width + 100;
        data.EnemyY[id] = (int)(0.25*(data.EnemyX[id]-width/2)*(data.EnemyX[id]-width/2))/100 + 100;
      }
      if(data.EnemyX[id] > width/2){
        data.EnemyY[id] = (int)(0.25*(data.EnemyX[id]-width/2)*(data.EnemyX[id]-width/2))/100 + 100;
        if(m_Enemy[id].iPtn == 0){
          data.EnemyY[id] *= 1;
        }else{
          data.EnemyY[id] *= -1;
          data.EnemyY[id] += height;
        }
      }
      data.EnemyX[id]--;
      if (data.EnemyX[id] < -100) {
        data.EnemyFlag[id] = false;
      }
      break;
    case 10:// 出てきて停止し、時間が来たら帰ってく (待機時間：2000cnt)(ボス！)
      if (cnt == 0) {// 初期化
        data.EnemyX[id] = width + 100;
        if(m_Enemy[id].iPtn == 0){data.EnemyY[id] = height/4;}   // 上半分
        if(m_Enemy[id].iPtn == 1){data.EnemyY[id] = height/4*3;} // 下半分
        if(m_Enemy[id].iPtn == 2){data.EnemyY[id] = height/2;} // 下半分
      }
      if (cnt <= 100){                     // 前進
        if (cnt%2 == 0)data.EnemyX[id]-=5;
      }else if (100 < cnt && cnt <= 1800){
        if( 500 == cnt){m_EBulletMgr.setEBullet(id, 5,10);}
        if( 900 == cnt){m_EBulletMgr.setEBullet(id, 5,10);m_EBulletMgr.setEBullet(id, 2,10);m_EBulletMgr.setEBullet(id, 3,10);}
        if(1100 == cnt){m_EBulletMgr.setEBullet(id, 2,10);}
      }else if (1800 < cnt && cnt <= 2100) { // 後進
        if (cnt%2 == 0)data.EnemyX[id]+=5;
      }else {data.EnemyFlag[id] = false;}  // 削除
      break;
    default:
      println("UnknownEBPattern");
      break;
    }
  }
}

