class CStartEnd{
  private int m_Cnt = 0;
  private int m_Cnt2 = 0;
  private boolean m_Flag = false;
  
  CStartEnd(){
  }
  public boolean StartMain(){
    fill(#000000,128 - m_Cnt);
    quad(0,0,width,0,width,height,0,height);
    noFill();
    if(!m_Flag){
      fill(255);
      scale(4.0);
      text("Enterを押してスタート！",22,33);
      scale(0.25);
      scale(2.0);
      text("Zキー : 星を撃つ",100,110);
      text("Cキー : アメを投げる",100,130);
      text("Xキー : 向きを変える",100,150);
      text("カーソル移動 : キャラがついていく",100,170);
      scale(0.5);
      if(keyCtrl.getKeyCode(ENTER))m_Flag = true;
    }else {
      m_Cnt+=2;
      if(m_Cnt == 128){
        m_Cnt = 0;
        return true;
      }
    }
    return false;
  }
  public boolean EndMain(){
    noStroke();
    if(m_Flag){
      fill(#000000,m_Cnt);
      quad(0,0,width,0,width,height,0,height);
      noFill();
      if(m_Cnt <= 126){
        m_Cnt+=2;
      }else{
        m_Flag = false;
        m_Cnt = 0;
      }
    }else{
      fill(#000000,128);
      quad(0,0,width,0,width,height,0,height);
      noFill();
      fill(255);
      scale(4.0);
      text("Score : " + data.Score,width/8 - 25,height/8 - 10);
      scale(0.25);
      scale(2.0);
      fill(#ff9999);
      text("リトライ：Rキー",width/4 - 50,height/4 + 50);
      noFill();
      scale(0.5);
      if(keyCtrl.getKeyCode('R'))return true;// リトライ
      m_Cnt2++;
      if(m_Cnt2 > 300){
        fill(#000000,m_Cnt);
        quad(0,0,width,0,width,height,0,height);
        noFill();
        if(m_Cnt <= 251){
          m_Cnt += 4;
        }else{
          exit(); 
        }
      }
    }
    return false;
  }
}
