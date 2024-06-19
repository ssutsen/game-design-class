import java.net.URLDecoder; //載入Java家族的net元件URLDecoder
import java.net.URLEncoder; //載入Java家族的net元件URLEncoder
import java.io.UnsupportedEncodingException; //載入Java家族的io元件，處理意外程序
import http.requests.*; //載入網路物件 https://github.com/runemadsen/HTTP-Requests-for-Processing
PostRequest runQuery; //建立PostRequest物件

import controlP5.*; //https://www.sojamo.de/libraries/controlP5/#examples
ControlP5 cp5; //載入ControlP5元件
Textfield uID, uName, uPoint, uAge; //建立建檔用文字輸入框 uID, uName, uPoint

PFont TCfont; //建立字型物件

String WriteURL = "https://docs.google.com/forms/d/1m5EeFk9RlMmKNZnKTyoU7cOaAyS5PbXTVpAAZR6v4s4/formResponse"; //寫入的URL位址
String UID, name, point, age;

String ReadUrl = "https://docs.google.com/spreadsheets/d/1YgmxcOUUk16WmLyz6ctpjcar4vu3Dl-K_mQT_UlBUtY/export?format=csv";
String QueryUrl = "https://docs.google.com/spreadsheets/u/0/d/1YgmxcOUUk16WmLyz6ctpjcar4vu3Dl-K_mQT_UlBUtY/gviz/tq?gid=114192704&tqx=out:csv&tq=";
String TQStr, SaveTQ, CallWriteURL, CallQueryURL; //TQStr = 查詢字串，須經過URLEncode編碼；SaveTQ = 寫入字串的參數；CallWriteURL = 呼叫寫入的完整URL；CallQueryURL = 呼叫讀取的完整URL

String LastRec, KeyinNum = "請輸入大寫A~E"; //LastRec = 最後筆數、KeyinNum = 輸入的鍵盤鍵值
boolean blnDataFillChk = false;

void setup(){
  size(1000, 800);
  TCfont = createFont("NotoSansTC-Regular.otf", 28); //建立字形庫
  textFont(TCfont);
  PImage[] imgs = {loadImage("button_a.png"),loadImage("button_b.png"),loadImage("button_c.png")}; //按鈕圖案替換(變色)
  LastRec = "";
  
  cp5 = new ControlP5(this); //建立CP5元件
  cp5.addButton("Save") //設定送出按鈕(Save)
  .setValue(128)
  .setPosition(800,220)
  .setImages(imgs) //按鈕狀態變化，預設水藍，Focus綠，Click紅
  .updateSize() //自動依據圖片尺寸更新顯示尺寸
  ;
  cp5.addBang("Clear") //設定清除按鈕
  .setPosition(860,220)
  .setSize(80,50)
  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  ;
  uID = cp5.addTextfield("uID") //設定會員帳號輸入欄位
  .setPosition(800,20)  //標示位置
  .setSize(150,25) //設定輸入框大小
  .setFocus(false) //設定是否為預設焦點(OnFocus)
  .setFont(createFont("arial",16)) //設定字體大小
  .setColorBackground(color(240,240,240)) //設定框內背景顏色
  .setColorForeground(color(87,33,252)) //設定框線顏色
  .setColorCaptionLabel(color(252,33,227)) //設定底部欄位標籤文字顏色
  .setColorValueLabel(color(0,0,255)) //設定文字顏色
  .setColorActive(color(255,0,0)) //設定被選取的輸入框反應的顏色(OnFocus)
  ;
  uName = cp5.addTextfield("uName") //設定會員名字輸入欄位
  .setPosition(800,70)
  .setSize(150,25)
  .setFocus(false)
  .setFont(createFont("arial",16))
  .setColorBackground(color(240,240,240))
  .setColorForeground(color(87,33,252))
  .setColorCaptionLabel(color(252,33,227))
  .setColorValueLabel(color(0,0,255))
  .setColorActive(color(255,0,0))
  ;
  uAge = cp5.addTextfield("uAge") //設定會員名字輸入欄位
  .setPosition(800,120)
  .setSize(150,25)
  .setFocus(false)
  .setFont(createFont("arial",16))
  .setColorBackground(color(240,240,240))
  .setColorForeground(color(87,33,252))
  .setColorCaptionLabel(color(252,33,227))
  .setColorValueLabel(color(0,0,255))
  .setColorActive(color(255,0,0))
  ;
  uPoint = cp5.addTextfield("uPoint") //設定玩家點數輸入欄位
  .setPosition(800,170)
  .setSize(150,25)
  .setFocus(false)
  .setFont(createFont("arial",16))
  .setColorBackground(color(240,240,240))
  .setColorForeground(color(87,33,252))
  .setColorCaptionLabel(color(252,33,227))
  .setColorValueLabel(color(0,0,255))
  .setColorActive(color(255,0,0))
  ;
  //.setColor(color(0,0,255) //設定輸入文字的顏色(同setColorValueLabel)
}

void draw(){
  background(#E0E0E0);
  UID = uID.getText();
  name = uName.getText();
  age = uAge.getText();
  point = uPoint.getText();
  
  textSize(18);
  fill(#9100DB);
  text("操作指令：", 30, 50);
  text("(A). 列出現在總筆數。", 30, 75);
  text("(B). 調閱出會員帳號 bebe 依時間排序取出最新一筆資料。", 30, 100);
  text("(C). 調出會員帳號 jenny 依積分排序取出最高一筆。", 30, 125);
  text("(D). 列出最新寫入資料的前十筆，並且依據日期排序。", 30, 150);
  textSize(20);
  fill(#0000FF);
  text("輸入的查詢命令為："+KeyinNum, 30, 200);
  if(UID.length() > 0 && name.length() > 0 && point.length() > 0){
    text("uID："+UID+". uName："+name+". uAge："+age+". uPoint："+point, 30, 230);
    if(isInteger(point)){
      blnDataFillChk = true;
    } else {
      blnDataFillChk = false;
      fill(#FF0000);
      text("UPOINT field must be an integert!", 30, 260);
      fill(#0000FF);
    }
  }
  text("最後寫入的資料是：", 30, 290);
  text(LastRec, 30, 290); //列出CSV的資料
}
