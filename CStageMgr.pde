// 体力ゲージの処理も含む
class CStageMgr{
  // イメージを扱うためのもの
  private PImage m_StageBack1 = null;
  private PImage m_StageBack2 = null;
  private int    m_StageCount = 0;
  private int    m_BackCount  = 0;
  private int    m_HPL = -1,m_CharaFrameL = 80,m_EnemyFrameL = 50;
  private PImage m_CharIcon   = null;
  
  CStageMgr(){
    // イメージファイルの読み込み
    m_StageBack1 = loadImage("dat/img/back01.png");
    m_StageBack2 = loadImage("dat/img/back01.png");
    m_CharIcon   = loadImage("dat/img/char_icon.png");
  }
  public void drawStage(){
    updateStage();// 情報更新
//    background(255);// ステージの代わりに使う背景
    // 流れる背景の描画処理-------------------------------------------------
    image(m_StageBack1, -1 * (m_BackCount%700 - 700), 0);
    image(m_StageBack2, -1 * (m_BackCount%700      ), 0);
  }
  // フレーム毎にする計算
  private void updateStage(){
    m_StageCount++;
    if(m_StageCount%4 == 0){m_BackCount++;}
  }
  
  public void drawData(){
    // 体力ゲージの描画処理-------------------------------------------------
    if(data.CharaFlags[FCShow]){
      fill(0);
      text(data.CharaHP+" / "+data.CharaHPMax, data.CharaX-38,data.CharaY+40);
      fill(255,64,64);noStroke();
      m_HPL = m_CharaFrameL * data.CharaHP / data.CharaHPMax;
      rect(data.CharaX-38,data.CharaY+45, m_HPL   , 5);
    }
    for (int i = 0;i < EnemyMax;i++) {
      if (data.EnemyFlag[i]) {
        fill(255,64,64);noStroke();
        if(data.EFBoss[i]){
          m_HPL = m_EnemyFrameL * data.EnemyHP[i] / data.EnemyHPMax[i];
          rect(data.EnemyX[i]-55,data.EnemyY[i]+105, m_HPL *3 , 5);
        }else{
          m_HPL = m_EnemyFrameL * data.EnemyHP[i] / data.EnemyHPMax[i];
          rect(data.EnemyX[i]-25,data.EnemyY[i]-45, m_HPL   , 5);
        }
      }
    }
    noFill();
    // 体力ゲージ処理ここまで-------------------------------------------------
    
    /*
    // ゴールライン表示処理  -------------------------------------------------
    if(data.GameCount >= GoalLine){
      stroke(0);strokeWeight(5);
      line(width - (data.GameCount - GoalLine)*2,0,width - (data.GameCount - GoalLine)*2,height);
      noStroke();
    }
    // ゴールラインここまで  -------------------------------------------------
    */
    
    // ステージライン処理ここから---------------------------------------------
    stroke(100,218,128);strokeWeight(5);
    line(50,20,width-50,20);
    strokeWeight(10);
    stroke(255);point(50,20);point(width-50,20);
    image(m_CharIcon,data.GameCount*(width - 100)/GoalLine+25 , -5);
    noStroke();
    // ステージライン処理ここまで---------------------------------------------
    
    
    
//    fill(0);stroke(1);strokeWeight(5);
//    line(width - (data.GameCount - 500),0,width - (data.GameCount - 500),height);
//    noFill();noStroke();
  }
  /*
  // GameMgrで初期化
  data.TimeCnt = 0;   // 時間初期化
  data.TimeDown = 300;// 制限時間

  
  // 時間を計算する関数
  public void funcTime(){
    data.TimeCnt++;// 時間用のカウントを進める
    if(data.TimeCnt == 60){
      data.TimeCnt = 0;
      data.TimeDown--;
    }
    fill(0);
    text("残り時間："+(data.TimeDown%3600)/60+"分"+data.TimeDown%60+"秒",0,40);
    noFill();

  }
  */
  
  
  public void Main(){
    drawStage();
    drawData();
//    funcTime();// 時間
  }
}
