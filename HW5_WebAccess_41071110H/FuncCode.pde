void Clear() { //清除文字輸入框裡資料
  cp5.get(Textfield.class,"uID").clear();
  cp5.get(Textfield.class,"uName").clear();
  cp5.get(Textfield.class,"uAge").clear();
  cp5.get(Textfield.class,"uPoint").clear();
}

boolean isInteger(String s) { //判斷是否為整數
  boolean result = false;
  try {
    Integer.parseInt(s);
    result = true;
  }
  catch(NumberFormatException e) {
  }
  return result;
}

String URLEnc(String tqCode){ //Handle錯誤訊息用
  String EncTQCode;
  try{
    EncTQCode = URLEncoder.encode(tqCode, "UTF-8");
    return EncTQCode;
  }
  catch(UnsupportedEncodingException ex)
  { 
    return ex.getMessage();
  }
}

void mousePressed(){ //滑鼠點選按鈕元件，觸發程序
  if(cp5.get(Button.class,"Save").isMousePressed()){
    println("SaveBtn clicked!");
    if(UID.length() > 0 && name.length() > 0 && point.length() > 0 && age.length() > 0 && isInteger(point)){
      SaveTQ = "?entry.1180336147=" + URLEnc(UID);
      SaveTQ = SaveTQ + "&entry.433754554=" + URLEnc(name);
      SaveTQ = SaveTQ + "&entry.1243053095=" + URLEnc(age);
      SaveTQ = SaveTQ + "&entry.288394727=" + URLEnc(point);
      CallWriteURL = WriteURL + SaveTQ;
      println(CallWriteURL);
      
      runQuery = new PostRequest(CallWriteURL);
      runQuery.send(); //資料送出
      println("Data already saved!");
    }
  }
}

void keyPressed(){ //捕捉鍵盤被輸入的值
  if(keyPressed && key == 'A'){
    KeyinNum = "A";
    TQStr = "select count(A)";
  } else if(keyPressed && key == 'B'){
    KeyinNum = "B";
    TQStr = "select * where lower(B) = 'bebe' order by A desc limit 1";
  } else if(keyPressed && key == 'C'){
    KeyinNum = "C";
    TQStr = "select * where lower(B) = 'jenny' order by D desc limit 1";
  } else if(keyPressed && key == 'D'){
    KeyinNum = "D";
    TQStr = "select * order by A desc limit 10";
  } else {
    KeyinNum = "X";
    TQStr = "";
  }
  if(KeyinNum != "X"){
    CallQueryURL = QueryUrl + URLEnc(TQStr);
    println(KeyinNum + ". " + URLEnc(TQStr));
    println(CallQueryURL);
    LoadData();
  }
}

void LoadData(){ //依據TQ載入資料
  LastRec = ""; 
  String[] lines = loadStrings(CallQueryURL); //載入多行字串；也可以用loadTable("data.csv", "header, tsv")或loadJSONArray()來換
  for (int i = 0; i < lines.length; i++){
      LastRec = LastRec + "\n" + lines[i];
      //println(i + ". " + lines[i]);
  }
}
