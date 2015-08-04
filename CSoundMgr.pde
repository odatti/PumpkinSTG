Minim minim = new Minim(this);
class CSoundMgr{
  private AudioSample[] se = new AudioSample[SoundMax];
  
  public CSoundMgr(){

    for(int i = 0;i < SoundMax;i++){ data.fSound[i] = false; }
    se[0] = minim.loadSample("dat/sound/cshot.wav");// 自機が攻撃する音
    se[1] = minim.loadSample("dat/sound/don.wav");  // 爆破音！？
  }
  private void triggerSound(){
    for(int i = 0;i < SoundMax;i++){
      if(data.fSound[i]){
        se[i].trigger();
        data.fSound[i] = false;
      }
    }
  }
  public void Main(){
    triggerSound();// 効果音を鳴らす
  }
}
