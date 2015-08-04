import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;



// Global
//Minim minim = new Minim(this);
CGameMgr  game    = null;// ゲーム制御クラス
CDetaBase data    = null;// データクラス
CKeyCtrl  keyCtrl = null;// キー制御クラス
// システム初期化関数
void setup(){
  game    = new CGameMgr();
  data    = new CDetaBase();
  keyCtrl = new CKeyCtrl();
  size(700,500);   // サイズ指定
  smooth();        // スムージング
  background(255); // 背景描画
  frameRate(60);   // 一秒間に60フレーム
}
// 詳しくはGameMgrで！
void draw(){game.MainLoop();}
void keyPressed(){keyCtrl.keyCodePressed();}
void keyReleased(){keyCtrl.keyCodeReleased();}
