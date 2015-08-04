class CGameMgr{
  private CStageMgr m_StageMgr = null;
  private CSoundMgr m_SoundMgr = null;
  private CStartEnd m_StartEnd = null;
  private CEnemyMgr m_EnemyMgr = null;
  private CCharaMgr m_CharaMgr = null;
  
  private int m_GameState = 0;// ゲームの状態を司る変数
  
  CGameMgr(){
    data.GameCount = 0;
    data.Score     = 0;
    if(m_StageMgr == null){m_StageMgr = new CStageMgr();}
    if(m_SoundMgr == null){m_SoundMgr = new CSoundMgr();}
    if(m_StartEnd == null){m_StartEnd = new CStartEnd();}
    if(m_CharaMgr == null){m_CharaMgr = new CCharaMgr();}
    if(m_EnemyMgr == null){m_EnemyMgr = new CEnemyMgr();}
    // インスタンス化に失敗したら
    if(m_StageMgr == null || m_SoundMgr == null || m_EnemyMgr == null || m_CharaMgr == null || m_StartEnd == null){m_GameState = -1;println("メモリを確保できませんでした from CGameMgr()");}
  }
  private void iniRetry(){
    m_GameState = 0;
    data.GameCount = 0;
    data.Score     = 0;
    m_CharaMgr = new CCharaMgr();
    m_EnemyMgr = new CEnemyMgr();
    m_StartEnd = new CStartEnd();
    // インスタンス化に失敗したら
    if(m_EnemyMgr == null || m_CharaMgr == null || m_StartEnd == null){m_GameState = -1;println("メモリを確保できませんでした from CGameMgr()");}
  }
  public void MainLoop(){
    switch(m_GameState){
      case 0:
        m_StageMgr.drawStage(); // 背景描画
        if(m_StartEnd.StartMain()){
          m_GameState = 1;
        }
      break;
      case 1:
        data.GameCount++;  // ゲームカウントプラス
        m_StageMgr.drawStage(); // ステージの処理
        m_EnemyMgr.Main(); // 敵の処理
        m_StageMgr.drawData(); // 情報描画
        m_CharaMgr.Main(); // キャラクターの処理
        m_SoundMgr.Main(); // 音を鳴らす処理
        if(DEBUGMODE && keyCtrl.getKeyCode('Y'))   { m_GameState = 2; }
        if((data.GameCount - GoalLine)*2 > width/2 || data.CharaFlags[FCDead]){ m_GameState = 2; }// ゴールするか、キャラが死んだら
        break;
      case 2:
        m_CharaMgr.plusScore();
        m_GameState = 3;// ここは一度しか通らない
        break;
      case 3:
        m_StageMgr.drawStage(); // 背景描画
        // リトライするなら初期化
        if(m_StartEnd.EndMain()){
          iniRetry();
        }
        break;
      default:
        System.out.println("MainLoop_Switch_default");
        break;
    }
    
    // ゲームカウント表示処理----------------
//    fill(0);text(data.GameCount,width-40,height - 5);
    // --------------------------------------
  }
}
