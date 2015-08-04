class CCBullet{
  private int     m_CBulletX;
  private int     m_CBulletY;
  private float   m_CBulletScl       = 0.125;
  private int     m_CBulletID        = -1;
  private int     m_CBulletR         = (int)(200 * m_CBulletScl);
  private int     m_CBulletSpd       = 8;
  private int     m_CBulletCnt       = 0;
  private int     m_CBulletTurnAngle = 16;
  private int     m_CBulletMuki      = 1;
  private int     m_CBulletClrType   = -1;
  private boolean m_CBulletFlag      = false;
  private boolean m_FCBuleltAttack   = false;
  CCBullet(int id){m_CBulletID = id;}
  private void setCBullet(int tmpX,int tmpY,int tmpMk){
    m_CBulletFlag = true;
    m_CBulletX = tmpX;
    m_CBulletY = tmpY;
    m_CBulletCnt = 0;
    m_CBulletMuki = tmpMk;
    m_CBulletClrType = (int)(Math.random() * CBulletClrMax);
//    data.fSound[0] = true;
  }
  private void moveCBullet(){
    if(m_CBulletX < -10 || m_CBulletX > width + 10){m_CBulletFlag = false;}// 範囲外なら消す
    if(m_CBulletFlag){m_CBulletX += m_CBulletSpd*m_CBulletMuki;}// 表示されてるなら進める
  }
  private void updateCBullet(){
    for(int i = 0;i < EnemyMax;i++){
      if(data.EnemyFlag[i]){
        if(data.EFBoss[i]){
          if((m_CBulletR + data.EnemyR[i])/2 > abs(sqrt((data.EnemyX[i]-m_CBulletX)*(data.EnemyX[i]-m_CBulletX)+(data.EnemyY[i]-60-m_CBulletY)*(data.EnemyY[i]-60-m_CBulletY)))){
            data.EnemyHP[i]--;
            m_CBulletFlag = false;
          }
        }else{
          if((m_CBulletR + data.EnemyR[i])/2 > abs(sqrt((data.EnemyX[i]-m_CBulletX)*(data.EnemyX[i]-m_CBulletX)+(data.EnemyY[i]-m_CBulletY)*(data.EnemyY[i]-m_CBulletY)))){
            data.EnemyHP[i]--;
            m_CBulletFlag = false;
          }
        }
      }
    }
  }
  private void drawCBullet(){
    if(m_CBulletFlag){// 回転処理
      translate((int)m_CBulletX,(int)m_CBulletY);
      rotate((PI/m_CBulletTurnAngle) * m_CBulletCnt);
      drawFuncCBullet(0,0,m_CBulletScl,m_CBulletClrType);
      rotate(-1*((PI/m_CBulletTurnAngle) * m_CBulletCnt));
      translate(-1 * (int)m_CBulletX,-1 * (int)m_CBulletY);
    }
    if(DEBUGMODE){stroke(0,255,68);strokeWeight(2);ellipse(m_CBulletX,m_CBulletY,m_CBulletR,m_CBulletR);}// あたり判定
  }
  
  public void Main(){
    m_CBulletCnt++;
    updateCBullet();
    moveCBullet();
    drawCBullet();
  }
  public boolean getCBulletFlag(){return m_CBulletFlag;}// フラグ取得
  
  private void drawFuncCBullet(int x,int y,float scl,int clr){
    if(scl == 0.0)return;
    x *= 1.0 / scl;
    y *= 1.0 / scl;
    scale(scl);
    strokeWeight(20);
    noFill();
    stroke(255);
    beginShape();
    vertex(x    ,y-100);
    vertex(x-28 ,y-25 );
    vertex(x-100,y-25 );
    vertex(x-45 ,y+25 );
    vertex(x-60 ,y+100);
    vertex(x    ,y+60 );
    vertex(x+60 ,y+100);
    vertex(x+45 ,y+25 );
    vertex(x+100,y-25 );
    vertex(x+28 ,y-25 );
    endShape(CLOSE);
    strokeWeight(8);
         if(clr == 0) stroke(40,100,200);
    else if(clr == 1) stroke(80,150,80);
    else if(clr == 2) stroke(200,40,100);
    else              stroke(0,0,0);
    beginShape();
    vertex(x    ,y-100);
    vertex(x-28 ,y-25 );
    vertex(x-100,y-25 );
    vertex(x-45 ,y+25 );
    vertex(x-60 ,y+100);
    vertex(x    ,y+60 );
    vertex(x+60 ,y+100);
    vertex(x+45 ,y+25 );
    vertex(x+100,y-25 );
    vertex(x+28 ,y-25 );
    endShape(CLOSE);
    scale(1.0 / scl);
  }
}
