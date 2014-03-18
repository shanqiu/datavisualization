import com.temboo.core.*;
import com.temboo.Library.NYTimes.BestSellers.*;

TembooSession session = new TembooSession("wentong", "myFirstApp", "7863cf202c1a463dae8f467a58a7707b");
JSONObject searchResult;
PFont fontTitle,fontContent,fontYear;
Table myTable;
boolean switchRuler=false;
boolean switchText=false;
float paddingR=50;
float paddingL=170;
PImage photo;
int width=1050;
int height=700;
float heightRank=height/10+height/4;
float heightAuthor=height/10+height/4+height/7;
float heightAward=height/10+height/4+height/7+height/7;


String[]author=new String[28];
float[]authorYearP = new float[28];
String[]award=new String[28];
float[]awardYearP = new float[28];

float[]yearsP= new float[28];

StringList bookname = new StringList();
ArrayList<RankObject> rankObject = new ArrayList<RankObject>();

int[]lengthRank=new int[8];
void setup() {
  
  size(width,height);
    if (frame != null) {
    frame.setResizable(true);
  }
  smooth();
  textAlign(CENTER);
  rectMode(CENTER);
  myTable= new Table("book.csv");
  photo=loadImage("photo.png");
  fontTitle=createFont("HelveticaNeueLTPro-BdCn-40",30);
  fontContent=createFont("HelveticaNeueLTPro-LtExO-12",14);
  fontYear=createFont("HelveticaNeueLTPro-LtExO-12",8);
  runGetBestSellerHistoryChoreo();
  getRank();
  getAuthorAward();
  
}

void draw(){
  background(253);
  title();
  lines();
  
}
void title(){
    photo.resize(width/5,width/5);
    image(photo,width/6,10);
    fill(0);
    textFont(fontTitle);
    text("GEORGE R R MARTIN",width/1.6,height/10);
    textFont(fontContent);
    //textAlign(CORNER);
    text("He is an American novelist and short story writer in the fantasy, horror, and science fiction genres, as well as a screenwriter and television producer.This Data Visulization shows his selected publications, his awards and his NY Times Bestsellers for 2014",width/1.6,height/2.5,width/2.4,height/2);
    //textAlign(CENTER);
    fill(240);
    noStroke();
    rect(0,heightRank,300,30);
    rect(0,heightRank,width*2,5);
    rect(0,heightAuthor,300,30);
    rect(0,heightAuthor,width*2,5);
    rect(0,heightAward,300,30);
    rect(0,heightAward,width*2,5);
    rect(0,550,300,30);
    rect(0,550,width*2,5);

    textFont(fontContent);
    fill(255,75,55);
    text("NYT Best Seller[2014]",75,heightRank+3);
    fill(20,130,20);
    text("Author",75,heightAuthor+3);
    fill(100,90,230);
    text("Award",75,heightAward+3);
    fill(0);
    text("Years",75,550+3);
}

void lines(){
  //draw lines
  for(int i=0;i<28;i++){
    if((mouseX-authorYearP[i]<6)&&(mouseX-authorYearP[i]>-6)&&(mouseY-heightAuthor<6)&&(mouseY-heightAuthor>-6)){
    switchText=true;
    switchRuler=true;
    }else{
    switchText=false;
    switchRuler=false;
    }
    //pop up text
    if(switchText==true){
    fill(240); 
    textFont(fontYear);
    float tempWidth=textWidth(author[i]);
    rect(width/2,heightAuthor+10,tempWidth+tempWidth/1.5,15);
    fill(0);
    text(author[i],width/2,heightAuthor+10);
    }
    //---------------------------------
  stroke(200);
  strokeWeight(1);
    if(awardYearP[i]!=0){
      if(switchRuler==true){
      line(awardYearP[i],heightAward,awardYearP[i],height); 
      }
      //pop up text
      if(switchText==true){
      fill(240);
      noStroke();
      textFont(fontYear);
      float tempWidth=textWidth(award[i]);
      rect(width/2,heightAward+10,tempWidth+tempWidth/1.5,15);
      fill(0);
      text(award[i],width/2,heightAward+10);
      }
      stroke(200);
      strokeWeight(1);
      //------------------------
      line(authorYearP[i],heightAuthor,awardYearP[i],heightAward);
      fill(100,90,230);
      noStroke();
      ellipse(awardYearP[i],heightAward,5,5);
    }
  for(int j=0;j<bookname.size();j++){
    if(author[i].equals(bookname.get(j))){ 
      stroke(200);
      strokeWeight(1);
      if(switchRuler==true){
      line(width-paddingR-(width-paddingL-paddingR)/40,heightRank,width-paddingR-(width-paddingR-paddingL)/40,height);
    }
    //pop up text
    if(switchText==true){
       fill(240);
       noStroke();
       rect(width/2-40,heightRank+10,10,15);
       rect(width/2+10*(rankObject.get(j).rank.size()+1)-40,heightRank+10,10,15);
      for(int m=0;m<rankObject.get(j).rank.size();m++){
       fill(240);
       noStroke();
       textFont(fontYear);
       rect(width/2+10*m-30,heightRank+10,10,15);
       fill(0);
       text(rankObject.get(j).rank.get(m),width/2+10*m-30,heightRank+10);
      }
    }
  stroke(200);
  strokeWeight(1);
  //-----------------------
  line(authorYearP[i],heightAuthor,width-paddingR-(width-paddingL-paddingR)/40,heightRank);
  fill(255,75,55);
  noStroke();
  ellipse(width-paddingR-(width-paddingR-paddingL)/40,heightRank,5,5);
  //println(rankObject.get(j).rankYear.get(0));
  //println(rankObject.get(j).rank);
  }
  }
  if(switchRuler==true){
  stroke(200);
  strokeWeight(1);
  line(authorYearP[i],heightAuthor,authorYearP[i],height);fill(140,255,85); }
  else{fill(20,130,20);}
  noStroke();
  ellipse(authorYearP[i],heightAuthor,5,5); 
  }
  //draw base axie
  for(int i=0;i<39;i++){
    fill(0);
    //ellipse((i+1)*(width-paddingR-paddingL)/40+paddingL,600,5,5);
    stroke(200);
    strokeWeight(1);
    line((i+2)*(width-paddingR-paddingL)/40+paddingL-(width-paddingR-paddingL)/80,545,(i+2)*(width-paddingR-paddingL)/40+paddingL-(width-paddingR-paddingL)/80,555);
    textFont(fontYear);
    text(1975+i+1,(i+1)*(width-paddingR-paddingL)/40+paddingL,550);
  }
}

void getAuthorAward(){
  for(int i=0;i<28;i++){
    authorYearP[i]=map(myTable.getInt(i,1)-1975,0,40,0,width-paddingL-paddingR)+paddingL;
      if(i>0){
        if(authorYearP[i]==authorYearP[i-1]){
          authorYearP[i]=authorYearP[i]+8;
        }
      }
    author[i]=myTable.getString(i,0);
    if(myTable.getInt(i,3)!=0){
    awardYearP[i]=map(myTable.getInt(i,3)-1975,0,40,0,width-paddingL-paddingR)+paddingL;
    }
    award[i]=myTable.getString(i,2);
    //println(authorYearP[i]);
    // println(awardYearP[i]);
  }
}  

void runGetBestSellerHistoryChoreo() {
  GetBestSellerHistory getBestSellerHistoryChoreo = new GetBestSellerHistory(session);
  getBestSellerHistoryChoreo.setCredential("nytime");
  getBestSellerHistoryChoreo.setAuthor("George R R Martin");
  GetBestSellerHistoryResultSet getBestSellerHistoryResults = getBestSellerHistoryChoreo.run();  
  searchResult=parseJSONObject(getBestSellerHistoryResults.getResponse());
}
void getRank(){
  JSONArray book=searchResult.getJSONArray("results");
  
  for(int i=0;i<book.size();i++){
   bookname.append(book.getJSONObject(i).getString("title"));
   JSONArray rankHistory=searchResult.getJSONArray("results").getJSONObject(i).getJSONArray("ranks_history");
    rankObject.add(new RankObject());  
    for(int j=0;j<rankHistory.size();j++){
    RankObject R=(RankObject)rankObject.get(i);
    R.rank.append(rankHistory.getJSONObject(j).getInt("rank"));
    String rankDate=rankHistory.getJSONObject(j).getString("bestsellers_date");
    rankDate=rankDate.substring(0,rankDate.length()-6);
    int rankYear=int(rankDate);
    R.rankYear.append(rankYear);
    }
   // println(bookname.get(i));
    println(rankObject.get(i).rank.get(0));   
   // println(rankObject.get(i).rankYear.get(0));
  } 
}

