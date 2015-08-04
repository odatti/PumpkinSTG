class CCharaMgr{
  // イメージを扱うためのもの
  private PImage  m_CharaRight = null;
  private PImage  m_CharaLeft  = null;
 
  private CCBullet[] m_CBullet    = new CCBullet[CBulletMax];// 弾の配列
  private CCBomb     m_CBomb      = new CCBomb(3);           // ボム
  private int        m_CBulletCnt = -1;                      // 弾の発射間隔
  private int        m_CBombCnt   = -1;                      // ボムの発射間隔
  
  CCharaMgr(){
    m_CharaRight = loadImage("dat/img/charaRight.png");
    m_CharaLeft  = loadImage("dat/img/charaLeft.png" );
    
    // x,y,r,muki,hp,spd
    if(MouseOrKeyboard == 0){
      data.iniCharaData(50,600,40,MukiR,200,0.05);
    }else{
      data.iniCharaData(50,100,25,MukiR,200,5);
    }
    data.CharaFlags[FCShow] = true;
    data.CharaFlags[FCBomb] = false;
    data.CharaFlags[FCDead] = false;
    // 弾丸の初期化
    for(int i = 0;i < m_CBullet.length;i++){ m_CBullet[i] = new CCBullet(i); }
  }
  
  private int searchBullet(){
    for(int i = 0;i < m_CBullet.length;i++){
      if(!m_CBullet[i].getCBulletFlag()){
        return i;
      }
    }
    return -1;
  }
  private void shotProcess(){
    int index = searchBullet();
    if(m_CBulletCnt == -1){
      if(0 <= index && index < m_CBullet.length){// 弾セット
        m_CBullet[index].setCBullet(data.CharaX,data.CharaY,data.CharaMuki);
        m_CBulletCnt = 0;
      }
    }
    data.CharaFlags[FCShot] = false;
  }
  private void inputProcess(){
    if(keyCtrl.getKeyCode('Z')){// Zキーでショット
      data.CharaFlags[FCShot] = true;
    }
    if(keyCtrl.getKeyCode('C') && m_CBombCnt < 0){// Cキーでボム
      if(m_CBomb.getBombNum() > 0){
        data.CharaFlags[FCBomb] = true;
      }
    }
    if(keyCtrl.getKeyCode('X')){// Xキー押し続けで後ろを向く
      data.CharaMuki = MukiL;
    }else {
      data.CharaMuki = MukiR;
    }
    if(MouseOrKeyboard == 0){
      // マウス追っかけ処理
      data.CharaX += (mouseX - data.CharaX) * data.CharaSpd;
      data.CharaY += (mouseY - data.CharaY) * data.CharaSpd;
    }else{
      // 移動制御
      if(keyCtrl.getKeyCode(LEFT)  && data.CharaX-data.CharaSpd > 0     )data.CharaX -= data.CharaSpd;
      if(keyCtrl.getKeyCode(RIGHT) && data.CharaX+data.CharaSpd < width )data.CharaX += data.CharaSpd;
      if(keyCtrl.getKeyCode(UP)    && data.CharaY-data.CharaSpd > 0     )data.CharaY -= data.CharaSpd;
      if(keyCtrl.getKeyCode(DOWN)  && data.CharaY+data.CharaSpd < height)data.CharaY += data.CharaSpd;
    }
  }
  private void updateChara(){
    if(data.CharaFlags[FCShot]){shotProcess();}
    if(data.CharaHP < 0){data.CharaFlags[FCDead] = true;}
    
    // 死亡フラグが立ったのなら
    if(data.CharaFlags[FCDead] && data.CharaFlags[FCShow]){// 終了処理へ？
      data.fSound[1] = true;
      data.CharaFlags[FCShow] = false;
      data.CharaX = -100;
      data.CharaY = width / 2;
    }
  }
  private void drawChara(){
    if(data.CharaFlags[FCShow]){// 表示するフラグが立ってるなら
      // キャラクター表示
      if(data.CharaMuki == MukiL) image(m_CharaLeft, (data.CharaX - m_CharaLeft.width/2), (data.CharaY - m_CharaLeft.height/2));
      else if(data.CharaMuki == MukiR) image(m_CharaRight, (data.CharaX - m_CharaRight.width/2), (data.CharaY - m_CharaRight.height/2));
 
      // 半透明のあたり判定
      noStroke();fill(#ff9090,128);
      if(DEBUGMODE)
        ellipse(data.CharaX,data.CharaY,data.CharaR,data.CharaR);// あたり判定
      noFill();
      
    }
  }
  public void plusScore(){
    data.Score += m_CBomb.getBombNum() * 50;
    data.Score += data.CharaHP;
  }
  // メイン関数
  public void Main(){
    if(data.CharaFlags[FCBomb]){// 爆弾の処理
      // 初期化
      if(!m_CBomb.getFShow()){
        m_CBomb.Initialize(data.CharaX-50,data.CharaY);
        m_CBomb.useBomb();
        m_CBombCnt = 0;
      }
        m_CBomb.setFShow(true);
        m_CBomb.Main();
    }else if(m_CBombCnt >= 0){
      m_CBombCnt++;
      if(m_CBombCnt == 50)m_CBombCnt = -1;
    }
    if(m_CBulletCnt >= 0){m_CBulletCnt++;}
    if(m_CBulletCnt == CShotTime){m_CBulletCnt = -1;}
    for(int i = 0;i < m_CBullet.length;i++){if(m_CBullet[i].getCBulletFlag()){m_CBullet[i].Main();}}
    if(data.CharaFlags[FCShow]){
      updateChara();
      drawChara();
      if(data.GameCount >= GoalLine){// ゴールしたら
        // マウス追っかけ処理
        data.CharaX += (width/2+50 - data.CharaX) * data.CharaSpd/2;
        data.CharaY += (height/2   - data.CharaY) * data.CharaSpd/2;
      }else inputProcess();
    }
  }
}
