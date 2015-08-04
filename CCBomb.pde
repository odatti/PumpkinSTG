class CCBomb{
  private PImage  m_Candy = null;
  private int     m_CCBombNum;
  private int     m_CCBombMuki;
  private int     m_CCBombX;
  private int     m_CCBombY;
  private int     m_CCBombS;// 発射時の自機との距離
  private int     m_CCBombT;// 発射時の自機との距離
  private int     m_CCBombR = 50;// 当たり判定
  private double  m_CCBombA     = 1.0*(1.0 / 256.0);// 傾き
  private boolean m_CCBombFShow = false;
  
  CCBomb(int x){
    setBombNum(x);
    m_Candy = loadImage("dat/img/Ame01.png");
  }
  
  public void Initialize(int x,int y){
    m_CCBombY = 0;m_CCBombMuki = data.CharaMuki; m_CCBombT = y - 50;
    if(data.CharaMuki == 1){
      m_CCBombX = -70;
      m_CCBombS = x + 90;
    }else{
      m_CCBombX = 70;
      m_CCBombS = x - 90;
    }
  }
  private void setBombNum(int x){m_CCBombNum = x;}
  public void useBomb(){m_CCBombNum--;}
  public int getBombNum(){return m_CCBombNum;}
  private void Calc(){
    m_CCBombY = (int)(m_CCBombA * m_CCBombX * m_CCBombX);
    m_CCBombX += 3*m_CCBombMuki;
    for(int i = 0;i < EnemyMax;i++){
      if(data.EnemyFlag[i]){
        if(data.EFBoss[i]){
            if((m_CCBombR + data.EnemyR[i])/2 > abs(sqrt((data.EnemyX[i]-m_CCBombX - m_CCBombS)*(data.EnemyX[i]-m_CCBombX - m_CCBombS)+(data.EnemyY[i]-m_CCBombY - m_CCBombT - 55)*(data.EnemyY[i]-m_CCBombY - m_CCBombT - 55)))){
            data.EnemyHP[i]-=20;
            m_CCBombFShow = false;
            data.CharaFlags[FCBomb] = false;
            data.fSound[1] = true;
          }
        }else{
          if((m_CCBombR + data.EnemyR[i])/2 > abs(sqrt((data.EnemyX[i]-m_CCBombX - m_CCBombS)*(data.EnemyX[i]-m_CCBombX - m_CCBombS)+(data.EnemyY[i]-m_CCBombY - m_CCBombT)*(data.EnemyY[i]-m_CCBombY - m_CCBombT)))){
            data.EnemyHP[i]-=100;
            m_CCBombFShow = false;
            data.CharaFlags[FCBomb] = false;
            data.fSound[1] = true;
          }
        }
      }
    }
    if(m_CCBombX + m_CCBombS > width + 100 || m_CCBombY + m_CCBombT > height + 100){
      m_CCBombFShow = false;
      data.CharaFlags[FCBomb] = false;
    }
  }
  private void drawFunc(){
    noStroke();
    fill(0);
    image(m_Candy, m_CCBombX + m_CCBombS,m_CCBombY + m_CCBombT);
//    ellipse(m_CCBombX + m_CCBombS,m_CCBombY + m_CCBombT,m_CCBombR,m_CCBombR);
  }
  public void Main(){
    if(m_CCBombFShow){
      Calc();
      drawFunc();
    }
//    println("x1:" + (m_CCBombX + m_CCBombS) + "_y1:" + (m_CCBombY + m_CCBombT) + "_Flag1:" + data.CharaFlags[FCBomb]);
//    println("x2:" + (width + 100) + "_y2:" + (height + 100) + "_Flag2:" + m_CCBombFShow);
  }
  public boolean getFShow(){return m_CCBombFShow;}
  public void    setFShow(boolean f){m_CCBombFShow = f;}
  
}
