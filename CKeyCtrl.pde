/*
** 複数のキーを同時に押しても対応できるキー制御クラス
** <使い方>
** getKeyCode('A') …… Aが押されたら　getKeyCode(UP) …… 十字キーの↑が押されたら
** CKeyCtrl,KeyCodePressed,KeyCodeReleasedはそれぞれsetup,keyPressed,keyReleasedに置いてください
*/

class CKeyCtrl{
  private boolean[] m_KeyCode = new boolean[256];
  // 初期化
  CKeyCtrl(){for(int i = 0;i < 256;i++){m_KeyCode[i] = false;}}
  // キーが押されたらtrueに
  public void keyCodePressed(){
    if(0 < keyCode && keyCode < 256){m_KeyCode[keyCode] = true;}
    else println("キーコードが範囲外です。");
  }
  // キーが離されたらfalseに
  public void keyCodeReleased(){
    if(0 < keyCode && keyCode < 256){m_KeyCode[keyCode] = false;}
    else println("キーコードが範囲外です。");
    keyCode = 0;
  }
  // 引数に大文字か特殊キーのキーコードを指定することで、そのキーが使われているか確認
  public boolean getKeyCode(int iKeyCode){
    if(0 < iKeyCode && iKeyCode < 256){return m_KeyCode[iKeyCode];}
    else println("キーコードが範囲外です。");
    return false;
  }
}
