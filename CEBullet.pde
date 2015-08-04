class CEBullet{
  public boolean EBulletFShot,EBulletFShow,EBulletFUse;
  public float   EBulletX,EBulletY;
  public float   EBulletXSpd,EBulletYSpd,EBulletRSpd;
  public int     EBulletR = 12;
  public int     EBulletMukiRL,EBulletMukiUD;
  public float   EBulletAng;
  public int     EB_EID,EB_PID;
  public int     EB_Ptn,EB_Time,EB_TCnt,EB_MCnt;
  
  private int    m_Color;
  
  CEBullet(){resetEBullet();}
  // 初期化関数達
  private void iniEBullet(float x,float y,float ang,float sx,float sy,float sr,int mukiRL,int mukiUD,boolean fShow,boolean fShot,boolean fUse){EBulletX = x;EBulletY = y;EBulletAng = ang;EBulletXSpd = sx;EBulletYSpd = sy;EBulletRSpd = sr;EBulletMukiRL = mukiRL;EBulletMukiUD = mukiUD;EBulletFUse = fUse;EBulletFShot = fShot;EBulletFShow = fShow;}
  public void setEBullet(int eid,int pid,int ptn,int time){ EB_EID=eid; EB_PID=pid; EB_Ptn=ptn; EB_Time=time; EB_TCnt=0; EB_MCnt=0; m_Color=(int)(Math.random()*EBulletClrMax);  EBulletFUse=true;}// 弾セット&UseフラグON
  public void resetEBullet(){EB_EID=0; EB_PID=0; EB_Ptn=0; EB_Time=0; EB_TCnt=0; EB_MCnt=0; iniEBullet(0.0, 0.0, 1.0, 0, 0, 0, MukiL,MukiU,false,false,false);}
  
  
  
  public void Judge(){
    if((EBulletR + data.CharaR)/2 > (int)abs(sqrt((EBulletX-data.CharaX)*(EBulletX-data.CharaX)+(EBulletY-data.CharaY)*(EBulletY-data.CharaY)))){
      if(data.EFBoss[EB_EID]){
        data.CharaHP-=2;// 当たり判定処理
      }else{
        data.CharaHP--;// 当たり判定処理
      }
      resetEBullet();// リセットしてフラグOFF
    }
    if(EBulletX < 0 || width < EBulletX || EBulletY < 0 || height < EBulletY){
      resetEBullet();// 画面外に出たら情報をリセットしてフラグOFF
    }
    for(int i = 0;i < EnemyMax;i++){
      if(!data.EnemyFlag[EB_EID] && !EBulletFShow){
        resetEBullet();
      }
    }
  }
  
  // 弾丸表示
  private void drawEBullet(){// カラーパターン
    noFill();strokeWeight(5);stroke(255);
    ellipse(EBulletX,EBulletY,EBulletR,EBulletR);
    if(m_Color == 0){stroke(255,0,0);}
    if(m_Color == 1){stroke(0,255,0);}
    if(m_Color == 2){stroke(0,0,255);}
    strokeWeight(1);
    ellipse(EBulletX,EBulletY,EBulletR,EBulletR);
  }
}
