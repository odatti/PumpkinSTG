
final int EBPatternMax = 10;
class CEBulletMgr{
  private CEBullet[] m_EB = new CEBullet[EBulletMax];// 弾の配列
  private int[] m_EBUseNum = new int[EBPatternMax];

  // 弾の登録
  private void setEBullet(int EID,int Pattern,int Time){
    int PID = 0;
    for(int i = 0;i < EBulletMax;i++){
      if(!m_EB[i].EBulletFUse){
        if(data.EnemyFlag[EID]){
          m_EB[i].setEBullet(EID,PID,Pattern,Time);
          PID++;
        }
        if(PID == m_EBUseNum[Pattern])return;// 弾が確保できたら
      }
    }
    println("弾切れなんです許してください");
  }
  // 弾発射時に向きとか角度の計算をするとか
  private void setEBMuki(int id,boolean fRL,boolean fUD,boolean fANG){
    if(fRL){
      if     (data.CharaX <  m_EB[id].EBulletX) m_EB[id].EBulletMukiRL = MukiL;
      else if(data.CharaX == m_EB[id].EBulletX) m_EB[id].EBulletMukiRL = 0;
      else                                      m_EB[id].EBulletMukiRL = MukiR;
    }if(fUD){
      if     (data.CharaY <  m_EB[id].EBulletY) m_EB[id].EBulletMukiUD = MukiU;
      else if(data.CharaY == m_EB[id].EBulletY) m_EB[id].EBulletMukiUD = 0;
      else                                      m_EB[id].EBulletMukiUD = MukiD;
    }if(fANG){m_EB[id].EBulletAng = atan2(data.CharaY - m_EB[id].EBulletY,data.CharaX - m_EB[id].EBulletX);}
  }
  
  
  
  
  public void Main(){
//    println();
//    println();
    for(int i = 0;i < EBulletMax;i++){
      if(m_EB[i].EBulletFShow)m_EB[i].Judge();
      if(m_EB[i].EBulletFUse){
        if(!m_EB[i].EBulletFShot){
          m_EB[i].EB_TCnt++;
          if(m_EB[i].EB_TCnt == m_EB[i].EB_Time){
            m_EB[i].EBulletFShot = true;// Fire!
          }
        }else if(m_EB[i].EBulletFShot){// 発射処理を行ってもよいのなら
          EBPatternMain(i,m_EB[i].EB_Ptn,m_EB[i].EB_EID,m_EB[i].EB_PID,m_EB[i].EB_MCnt);// 弾幕ごとの移動
          if(m_EB[i].EBulletFShow)m_EB[i].drawEBullet();// 弾表示
//          m_EB[i].EBulletX += m_EB[i].EBulletXSpd * m_EB[i].EBulletMukiRL;
//          m_EB[i].EBulletY += m_EB[i].EBulletYSpd * m_EB[i].EBulletMukiUD;
          m_EB[i].EB_MCnt++;
        }//print(i + " ");
      }
    }//println();
  }
  
  
  // EBulletのコンストラクタ
  CEBulletMgr(){
    for(int i = 0;i < EBulletMax;i++){m_EB[i] = new CEBullet();}// 弾の初期化
    for(int i = 0;i < EBPatternMax;i++){m_EBUseNum[i] = 0;}// 先ずは初期化
    m_EBUseNum[0] = 100;// Pattern00：
    m_EBUseNum[1] = 50;// Pattern01：
    m_EBUseNum[2] = 200;// Pattern02：
    m_EBUseNum[3] = 150;// Pattern03：
    m_EBUseNum[4] = 100;// Pattern04：
    m_EBUseNum[5] = 540;// Pattern05：
  }
  
  
  public void EBPatternMain(int id,int ptn,int eid,int pid,int cnt){
    switch(m_EB[id].EB_Ptn){
      // ------------------------------------------------------------------------------------------------------------------------
      case 0:// 通常連続ショット(5発の散弾)
      if(pid * 5  == cnt){
        m_EB[id].EBulletFShow = true;
        m_EB[id].EBulletRSpd = 2.0;
        m_EB[id].EBulletX    = data.EnemyX[eid];
        m_EB[id].EBulletY    = data.EnemyY[eid];
        setEBMuki(id,true,false,true);
//        m_EB[id].EBulletAng = (PI/180.0);
        m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
        m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
      }else {
        if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
          if(cnt%25 == 0){// 加速
            m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng)*2;
            m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng)*2;
          }
          m_EB[id].EBulletX += m_EB[id].EBulletXSpd;
          m_EB[id].EBulletY += m_EB[id].EBulletYSpd;
        }
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      case 1:// 通常散弾ショット(50発)
      if(pid * 5  == cnt){
        m_EB[id].EBulletFShow = true;
        m_EB[id].EBulletRSpd = 2.0;
        m_EB[id].EBulletX    = data.EnemyX[eid];
        m_EB[id].EBulletY    = data.EnemyY[eid];
        setEBMuki(id,true,false,false);
        m_EB[id].EBulletAng = (float)(PI/180.0*(Math.random()*60.0-30.0));
        m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
        m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
      }else {
        if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
          if(cnt%5 == 0){// 加速
            m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng)/2;
            m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng)/2;
          }
          m_EB[id].EBulletX += m_EB[id].EBulletXSpd * m_EB[id].EBulletMukiRL;
          m_EB[id].EBulletY += m_EB[id].EBulletYSpd * m_EB[id].EBulletMukiUD;
        }
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      case 2:// 回転弾幕
      if(pid == cnt){
        m_EB[id].EBulletFShow = true;
        m_EB[id].EBulletRSpd = 2.0;
        m_EB[id].EBulletX    = data.EnemyX[eid];
        m_EB[id].EBulletY    = data.EnemyY[eid];
        m_EB[id].EBulletAng = (float)(PI/10.0*(float)pid - 90);
        m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
        m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
      }else {
        if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
          m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng)/15;
          m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng)/15;
        }
        m_EB[id].EBulletX += m_EB[id].EBulletXSpd * m_EB[id].EBulletMukiRL;
        m_EB[id].EBulletY += m_EB[id].EBulletYSpd * m_EB[id].EBulletMukiUD;
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      case 3:// 自機方位にばらまき弾幕
      if(pid * 3 == cnt){
        m_EB[id].EBulletFShow = true;
        m_EB[id].EBulletRSpd = 2.0;
        m_EB[id].EBulletX    = data.EnemyX[eid];
        m_EB[id].EBulletY    = data.EnemyY[eid];
        setEBMuki(id,true,false,false);
        m_EB[id].EBulletAng = (float)(PI/180.0*(Math.random()*90.0)-45.0);
        m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
        m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
      }else {
        if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
          if(cnt%15 == 0){// 加速
            m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
            m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
          }
        }
        m_EB[id].EBulletX += m_EB[id].EBulletXSpd * m_EB[id].EBulletMukiRL;
        m_EB[id].EBulletY += m_EB[id].EBulletYSpd * m_EB[id].EBulletMukiUD;
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      case 4:// ホーミング
      if(pid * 10 == cnt){
        m_EB[id].EBulletFShow = true;
        m_EB[id].EBulletX    = data.EnemyX[eid];
        m_EB[id].EBulletY    = data.EnemyY[eid];
        m_EB[id].EBulletRSpd = (float)data.CharaY-m_EB[id].EBulletY;
        setEBMuki(id,true,true,true);
        m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng)/60.0;
        m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng)/60.0;
        m_EB[id].EBulletRSpd = 2.0;
      }else {
        if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
          if((m_EB[id].EBulletXSpd < 10 || m_EB[id].EBulletXSpd > -10) && (m_EB[id].EBulletYSpd < 10 || m_EB[id].EBulletYSpd > -10) && cnt%15 == 0){// 加速
          int fx = 0,fy=0;
          if(data.CharaX - m_EB[id].EBulletX < 0)fx = -1;
          else                                   fx = 1;
          if(data.CharaY - m_EB[id].EBulletY < 0)fy = -1;
          else                                   fy = 1;
            m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng) * fx;
            m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng) * fy;
          }
        }
        m_EB[id].EBulletX += m_EB[id].EBulletXSpd * m_EB[id].EBulletMukiRL;
        m_EB[id].EBulletY += m_EB[id].EBulletYSpd * m_EB[id].EBulletMukiUD;
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      case 5:// 全方向へ一斉ショット
      for(int i = 0;i < 15;i++){
        if(cnt == i*20 && 36*i <= pid && pid < 36 + 36*i){
          m_EB[id].EBulletFShow = true;
          m_EB[id].EBulletRSpd = 3.0;
          m_EB[id].EBulletX    = data.EnemyX[eid];
          m_EB[id].EBulletY    = data.EnemyY[eid];
          m_EB[id].EBulletAng = (float)(PI/10.0*(float)pid + 45 * (cnt/20));
          m_EB[id].EBulletXSpd = m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
          m_EB[id].EBulletYSpd = m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
        }
      }
      if(m_EB[id].EBulletFShow){// 表示されているのなら処理を行う
        if(cnt%15 == 0){// 加速
          m_EB[id].EBulletXSpd += m_EB[id].EBulletRSpd*cos(m_EB[id].EBulletAng);
          m_EB[id].EBulletYSpd += m_EB[id].EBulletRSpd*sin(m_EB[id].EBulletAng);
        }
        m_EB[id].EBulletX += m_EB[id].EBulletXSpd * m_EB[id].EBulletMukiRL;
        m_EB[id].EBulletY += m_EB[id].EBulletYSpd * m_EB[id].EBulletMukiUD;
      }
      break;
      // ------------------------------------------------------------------------------------------------------------------------
      default:println("UnknownEBPattern");break;
    }
  }
}
