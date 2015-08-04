class CEnemy{
  private PImage  m_EnemyRight = null;
  private PImage  m_EnemyLeft  = null;
  private int     m_EnemyPoint = 0;
  
  // 敵の行動を制御する,敵の識別番号,敵の行動パターン
  public int Cnt = 0,E_ID,Ptn = -1,iPtn = -1;
  
  CEnemy(int id){
    E_ID = id;
    // 敵の種類で初期化を分けるつもり
    m_EnemyRight = loadImage("dat/img/enemy01Right.png");
    m_EnemyLeft  = loadImage("dat/img/enemy01Left.png" );
    resetEnemy(id);// 敵の情報を初期化
  }
  public void setEnemy(int iptn,int MPID, int hp,boolean bss){
    iPtn = iptn;
    Cnt = 0;Ptn = MPID;
    data.EnemyFlag[E_ID] = true;
    data.EnemyHP[E_ID] = data.EnemyHPMax[E_ID] = hp;
    m_EnemyPoint = hp/2;// 敵のスコア計算(体力の半分)
    data.EFBoss[E_ID] = bss;
    if(data.EFBoss[E_ID]){// ボスの時の初期化
      data.EnemyR[E_ID] = 100;
    }
  }
  public void resetEnemy(int id){Ptn = -1;data.iniEnemyData(id,width+width,-100,50,data.CharaMuki * -1,4,false);}// id,x,y,r,muki,hp,scl,flag
  private void updateEnemy(){
    if(data.EnemyFlag[E_ID]){
      // 敵の向きをキャラに向ける
      if(data.CharaX < data.EnemyX[E_ID])data.EnemyMuki[E_ID] = MukiL;
      else                               data.EnemyMuki[E_ID] = MukiR;
      Cnt++;// 敵の行動カウント
    }
    // 体力が尽きたら死(ここにスコアアップの処理でも)
    if(data.EnemyHP[E_ID] <= 0){
      data.EnemyFlag[E_ID] = false;
      if(data.EFBoss[E_ID])data.Score += 300;
      else data.Score += m_EnemyPoint;
    }
  }
  private void drawEnemy(){
    if(data.EnemyFlag[E_ID]){
      if(!data.EFBoss[E_ID]){
        if(data.EnemyMuki[E_ID] == MukiR){
          image(m_EnemyRight, (data.EnemyX[E_ID] - m_EnemyRight.width/2), (data.EnemyY[E_ID] - m_EnemyRight.height/2));
        }else{
          image(m_EnemyLeft , (data.EnemyX[E_ID] - m_EnemyLeft.width/2) , (data.EnemyY[E_ID] - m_EnemyLeft.height/2) );
        }
      }else{ drawEnemyLeft((int)(data.EnemyX[E_ID]),(int)(data.EnemyY[E_ID])); }
      if(DEBUGMODE && data.EFBoss[E_ID]) {stroke(128,255,128);noFill();strokeWeight(2);ellipse(data.EnemyX[E_ID],data.EnemyY[E_ID]-60,data.EnemyR[E_ID],data.EnemyR[E_ID]);}// あたり判定
      if(DEBUGMODE && !data.EFBoss[E_ID]){stroke(128,255,128);noFill();strokeWeight(2);ellipse(data.EnemyX[E_ID],data.EnemyY[E_ID],data.EnemyR[E_ID],data.EnemyR[E_ID]);}// あたり判定
    }
  }
  public void Main(){
    updateEnemy();
    drawEnemy();
  }
  // ボス(オリジナルキャラクター)
  public void drawEnemyLeft(int x,int y){
    // 引数はキャラクターの中心座標
    /* ------------体------------ */
    // マント
    fill(255);
    stroke(20);
    strokeWeight(2);
    beginShape();
    vertex(x-25,y-30);
    bezierVertex(x-30,y   , x-45,y+50, x-20,y+80);
    bezierVertex(x-18,y+76, x-16,y+73, x-14,y+70);
    bezierVertex(x-10,y+75, x-6 ,y+80, x   ,y+85);
    bezierVertex(x+1 ,y+80, x+2 ,y+75, x+5 ,y+70);
    bezierVertex(x+12,y+76, x+18,y+81, x+23,y+83);
    bezierVertex(x+23,y+78, x+23,y+74, x+24,y+69);
    bezierVertex(x+30,y+73, x+32,y+77, x+39,y+80);
    bezierVertex(x+39,y+76, x+38,y+71, x+39,y+65);
    bezierVertex(x+47,y+67, x+56,y+68, x+60,y+67);
    bezierVertex(x+59,y+64, x+54,y+60, x+53,y+58);
    bezierVertex(x+61,y+57, x+65,y+55, x+70,y+53);
    bezierVertex(x+67,y+51, x+63,y+49, x+60,y+46);
    bezierVertex(x+63,y+44, x+68,y+41, x+72,y+37);
    bezierVertex(x+69,y+34, x+64,y+31, x+60,y+29);
    bezierVertex(x+63,y+26, x+65,y+23, x+68,y+20);
    bezierVertex(x+33,y+13, x+25,y-13, x+20,y-20);
    endShape(CLOSE);
    // 影の部分
    fill(200);
    noStroke();
    beginShape();
    vertex(x+20,y-20);
    bezierVertex(x+10,y+10, x+49,y+36, x+60,y+46);
    bezierVertex(x+63,y+44, x+68,y+41, x+71,y+37);
    bezierVertex(x+68,y+34, x+63,y+31, x+59,y+29);
    bezierVertex(x+62,y+26, x+64,y+23, x+66,y+21);
    bezierVertex(x+32,y+13, x+24,y-13, x+20 ,y-20);
    endShape(CLOSE);
    /* ------------顔(かぼちゃ)------------ */
    strokeWeight(1);// 初期値に戻す
    noStroke();
    // かぼちゃオレンジ影↓
    fill(175,101,1);
    ellipse(x + 20,y - 55,60,80);
    ellipse(x -  2,y - 60,60,80);
    // かぼちゃオレンジ
    fill(230,133,2);
    ellipse(x - 20,y - 55,60,80);
    ellipse(x     ,y - 50,70,80);
    // へた
    fill(33,69,12);
    stroke(23,49,2);
    ellipse(x,y-91,12,6);
    fill(230,133,2);
    noStroke();
    // 目
    fill(50);
    stroke(0);
    triangle(x-35,y-68, x-45,y-56, x-33,y-54);
    triangle(x   ,y-58, x-10,y-48, x+3 ,y-44);
    // 口
    fill(0);
    beginShape();
    vertex(x-40,y-44);
    vertex(x-43,y-30);
    vertex(x-36,y-23);
    vertex(x-8 ,y-18);
    vertex(x-4 ,y-26);
    vertex(x-7 ,y-38);
    vertex(x-14,y-34);
    vertex(x-36,y-38);
    endShape(CLOSE);
    // 口の中の光
    fill(253,55,62);
    stroke(253,55,62);
    quad(x-35,y-35, x-37,y-32, x-35,y-29, x-33,y-32);
    quad(x-14,y-31, x-16,y-28, x-14,y-25, x-12,y-28);
    /* ------------顔の輪郭太線------------ */
    noFill();
    stroke(20);
    strokeWeight(2);
    beginShape();
    vertex(x-18,y-16);
    bezierVertex(x-59,y-16 , x-61,y-92 , x-18,y-96);
    bezierVertex(x-3 ,y-102, x+3 ,y-101, x+13,y-95);
    bezierVertex(x+61,y-100, x+58,y-16 , x+18,y-16);
    bezierVertex(x+5 ,y-9  , x-4 ,y-10 , x-18,y-16);
    endShape(CLOSE);
    /* // 中心座標の表示
    stroke(255,0,25);
    point(x,y);
    */
  }
}

