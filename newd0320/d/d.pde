Table myTable;
Table timeTable;
Table locationTable;
int[] time=new int[282];
int[] timeBar = new int[282];
float[] money = new float[290];
String[] location= new String[290];
int[] locationBar = new int[290];
String[] id = new String[5];
String[] arcIntro = new String[5];
float tempWidth;
float totalMoney=18608;
float totalTime=674;
float totalLocation=774;
float[] degree = new float[3];
float[] percent = new float[3];
String[] percentPrint= new String[3];


int multi=3;
int count;
int countText=0;
color c = color(179, 19, 25);
color d = color(0,50);
color e = color(100);
color line;
color curve;
color idColor;
int paddingRight=115;
PFont fontA,fontB,fontC;
int paddingLeft=160;
int paddingTop=150;
int[] yPos={paddingTop-7,paddingTop+65,paddingTop+95,paddingTop+385,paddingTop+415};
int[] arcPos={paddingTop-7,paddingTop+65,paddingTop+415};
boolean showDataTexts=false;
float num=140;
float total=331;
String[] intro =new String[5];

void setup() {
  size(1300, 800);
  smooth();
  cursor(ARROW);
  textAlign(CENTER);
  rectMode(CORNER);
  myTable= new Table("all.tsv");
  timeTable= new Table("time.tsv");
  locationTable= new Table("location.tsv");
  fontA=loadFont("HelveticaNeueLT-Light-26.vlw");
  fontB=loadFont("HelveticaNeueLTPro-Lt-12.vlw");
  fontC=loadFont("HelveticaNeueLTPro-Lt-10.vlw");
  
  intro[0]="The total expenditures for each location";
  intro[1]="The total consumption times for each location";
  intro[2]="The locations you have spend money on";
  intro[3]="The date from 2012/05/29(left) to 2013/03/02(right) ";
  intro[4]="The total consumption times for each day";

  id[0]="Consumption Amount";
  id[1]="Consumption Times";
  id[2]="Consumption Location";
  id[3]="Consumption Date";
  id[4]="Consumption Times";
  
  arcIntro[0]="Each Location`s Cosumption Amount/ Total Comsumption Amount";
  arcIntro[1]="Each Location`s Cosumption Times/ Total Comsumption Times";
  
  for(int i=0;i<locationTable.rowsLength;i++){
    location[i]=locationTable.getString(i,0);
    locationBar[i]=locationTable.getInt(i,1);  
  }
  for(int i=0; i<timeTable.rowsLength;i++){
    time[i]=timeTable.getInt(i,0);
    timeBar[i] =timeTable.getInt(i,1);
  }
  for(int z=0;z<locationTable.rowsLength;z++){
    money[z]=0;
    for(int i=0;i<myTable.rowsLength; i++) {
    if(myTable.getString(i,1).equals(location[z]) == true){
    money[z]+=myTable.getFloat(i,2);
      }
    }    
  }

}

// draw ///////////////////////////////////////////////////////////////////////
void draw() {
  background(250);
  lines("myTable");
  leftTexts();
  drawPies();
}

void lines(String tableObject) {
  fill(253);
  stroke(d);
  strokeWeight(1);
  rect(paddingLeft, 600,850,150);
  stroke(0,50);
  strokeWeight(1);
  noFill();
  
      for(int z=0;z<locationTable.rowsLength;z++){
        countText=0;
          for (int i = 0; i < myTable.rowsLength; i++) { 
          if(myTable.getString(i,1).equals(location[z]) == true){
             
           for(int j=0; j<timeTable.rowsLength;j++){
            if(myTable.getInt(i,0)==time[j]){
     
            if(count==z){
            curve=c;
            line=c;
            showTexts(z,j,countText);    
            }else{
            line=e;
            curve=d;
            }
            
            float temz=z;
            float temj=j;
            stroke(curve);
            bezier(temz*multi+paddingLeft,paddingTop+83,temz*multi+paddingLeft,paddingTop+300,temj*multi+paddingLeft,paddingTop+200,temj*multi+paddingLeft,paddingTop+400);
            stroke(line);   
            translate(j*multi+paddingLeft,paddingTop+403);
            line(0,0,0,timeBar[j]);
            translate(-j*multi-paddingLeft,-paddingTop-403);
            
            translate(z*multi+paddingLeft,paddingTop+80);
            line(0,0,0,-locationBar[z]);
            translate(-z*multi-paddingLeft,-paddingTop-80);
            if(money[z]<0){money[z]=0;}
            if(money[z]>2000){money[z]=2000;}
            translate(z*multi+paddingLeft,paddingTop);
            line(0,0,0,-money[z]/50);
            translate(-z*multi-paddingLeft,-paddingTop);
            stroke(e);
            
            countText++;
         
              }       
            }          
          }    
        }
      }    
}
void leftTexts(){
  
  fill(e);
  textFont(fontA);
  textAlign(CENTER);
  text("Data Visualization for expenditures from 2012/05/29 to 2013/03/04",width/2-70,50);
  for(int i=0;i<5;i++){    
  println(tempWidth);
    if(mouseX-(paddingLeft-30)<15&&mouseX-(paddingLeft-30)>-15&&mouseY-yPos[i]<15&&mouseY-yPos[i]>-15){
    noStroke();
    fill(c);
    rect(paddingLeft-30,yPos[i],14,7);
    idColor=c;
    popupTexts(i);
    if(i==4)showDataTexts=true;
    else showDataTexts=false;
    }else idColor=e;
  noFill();
  stroke(c);
  strokeWeight(1);
  rect(paddingLeft-30,yPos[i],14,7);
  fill(idColor);
  textAlign(RIGHT,TOP);
  textFont(fontC);
  text(id[i],paddingLeft-35,yPos[i]);
  textAlign(CENTER);
  
  }
}

void popupTexts(int whichOne){
  textFont(fontB);
  tempWidth=textWidth(intro[whichOne]);
  fill(253,180);
  stroke(d);
  strokeWeight(1);
  beginShape();
  vertex(paddingLeft-80,yPos[whichOne]+10);
  vertex(paddingLeft-80,yPos[whichOne]+50+10);
  vertex(paddingLeft+tempWidth+70-80,yPos[whichOne]+50+10);
  vertex(paddingLeft+tempWidth+70-80,yPos[whichOne]+20+10);
  vertex(paddingLeft-75,yPos[whichOne]+20+10);
  endShape(CLOSE);
  fill(c);
  textFont(fontB);
  textAlign(CORNER);
  text(intro[whichOne],paddingLeft-70,yPos[whichOne]+50);
  textAlign(CENTER);
}
void showTexts(int indexZ, int indexJ, int count){ 
  //because not in void draw, it will overlay its self , to draw a rect cover is crutial
  fill(253);
  noStroke();
  rect(paddingLeft+1, 601,848,50);
  textAlign(LEFT);
  fill(0);
  textFont(fontB);
  text("You have spend  ",paddingLeft-100+260,630);
  fill(c); 
  text(money[indexZ], paddingLeft-100+350,630);
  float tempMoney  = 60;
  fill(0);
  text(" at ",paddingLeft-100+tempMoney+350,630);
  fill(c);
  text(location[indexZ], paddingLeft-100+tempMoney+350+20,630);
  float tempLocation= textWidth(location[indexZ]);
  fill(0);
  text(" for ",paddingLeft-100+tempMoney+350+20+tempLocation,630);
  fill(c);
  text(locationBar[indexZ], paddingLeft-100+tempMoney+350+20+tempLocation+20,630);
  float tempLocationBar= 50;
  fill(0);
  text(" times",paddingLeft-100+tempMoney+350+20+tempLocation+20+20,630);
 // if(showDataTexts==true){
  textFont(fontC);
  textAlign(CENTER);
  translate(paddingLeft+30+count*15,720);
  rotate(-PI/4);
  text(time[indexJ],0,0);
  rotate(PI/4);
  translate(-paddingLeft-30-count*15,-720);
  noFill();
  stroke(c);
  beginShape();
  vertex(paddingLeft+30+count*15-20+2,740);
  vertex(paddingLeft+30+count*15+20+2,700);
  vertex(paddingLeft+30+count*15+20+2,680);
  endShape();
  text(timeBar[indexJ],paddingLeft+30+count*15+22,677);

 // }else{
 // fill(255);
 // rect(paddingLeft+1, 660,848,88);
 // }
  noFill();
}

void drawPies(){
  degree[0] = map(money[count],0,totalMoney,0,TWO_PI);
  percent[0] = money[count]*100/totalMoney;
  degree[1] = map(locationBar[count],0,totalLocation,0,TWO_PI);
  percent[1] = locationBar[count]*100/totalLocation;
  //degree[2] = map(timeBar[count],0,totalTime,0,TWO_PI);
  // percent[2] = timeBar[count]*100/totalTime;
  
 //println(percentPrint[0]);
  color fontColor;
  color arcColor=color(255);
  for(int i=0; i<2;i++){
      percentPrint[i]=String.format("%.3f", percent[i]);
      if(mouseX-1100<40&&mouseX-1100>-40&&mouseY-arcPos[i]<40&&mouseY-arcPos[i]>-40){
        popupArc(i);
        fontColor=c;
        arcColor=c;
      }else{
        fontColor=e;
        arcColor=color(255);
      }
      fill(arcColor);
      stroke(c);
      strokeWeight(1);
      arc(1100,arcPos[i],80,80,0,degree[i],PIE);
      arc(1100,arcPos[i],70,70,0,degree[i],PIE);
      fill(250);
      noStroke();
      ellipse(1100,arcPos[i],68,68);
      fill(fontColor);
      textFont(fontB);
      textAlign(CENTER);
      text(percentPrint[i]+"%",1100,arcPos[i]);

    }

}
void popupArc(int whichOne){
  fill(252,180);
  stroke(d);
  strokeWeight(1);
  beginShape();
  float tempWidthArc=300;
  vertex(1100-tempWidthArc-70-40,arcPos[whichOne]-80);
  vertex(1100-tempWidthArc-70-40,arcPos[whichOne]+30-80);
  vertex(1100-40-5,arcPos[whichOne]+30-80);
  vertex(1100-40,arcPos[whichOne]+60-80);
  vertex(1100-40,arcPos[whichOne]-80);
  endShape(CLOSE);
  fill(c);
  textFont(fontB);
  textAlign(LEFT);
  text(arcIntro[whichOne],1100-tempWidthArc-70-40+10,arcPos[whichOne]-80+20);
}
void keyPressed(){
  if(key=='w'){
  count=count+1;
  }else if(key=='s'){
  count=count-1;
  }
}
