Table myTable;
Table timeTable;
Table locationTable;
int[] time=new int[282];
int[] timeBar = new int[282];
float[] money = new float[290];
String[] location= new String[290];
int[] locationBar = new int[290];
int multi=3;
int count;
int countText=0;
color c = color(255, 0, 0);
color d = color(0,50);
color e = color(100);
color line;
color curve;
int paddingRight=115;
PFont fontA,fontB,fontC;

void setup() {
  size(1100, 600);
  smooth();
  cursor(ARROW);
  textSize(3);
  textAlign(CENTER);
  rectMode(CORNER);
  myTable= new Table("all.tsv");
  timeTable= new Table("time.tsv");
  locationTable= new Table("location.tsv");
  fontA=createFont("HelveticaNeueLTPro-Lt-16",16);
  fontB=createFont("HelveticaNeueLTPro-Lt-12",12);
  fontC=createFont("HelveticaNeueLTPro-Lt-10",10);

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
  popup();
}
void popup(){
fill(253);
noStroke();
rect(100,520,700,100);
fill(0);
textFont(fontA);
text("Data Visualization for expenditures from 2012/05/29 to 2013/03/04(Click 'w'and 's' to change selection)",width/2-70,30);
int[] yPos={90,170,200,490,520};
String[] intro =new String[5];
intro[0]="The total expenditures for each location";
intro[1]="The total consumption times for each location";
intro[2]="The locations you have spend money on";
intro[3]="The date from 2012/05/29(left) to 2013/03/02(right)";
intro[4]="The total consumption times for each day";
for(int i=0;i<5;i++){
noFill();
stroke(255,0,0);
strokeWeight(1);
ellipse(30,yPos[i],10,10);
if(mouseX-30<15&&mouseX-30>-15&&mouseY-yPos[i]<15&&mouseY-yPos[i]>-15){
noStroke();fill(230);ellipse(30,yPos[i],20,20);
fill(0);
text(intro[i],width/2-100,550);
}


}

}
void lines(String tableObject) {
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
            }else{line=e;curve=d;}
            float temz=z;
            float temj=j;
            stroke(curve);
            bezier(temz*multi+50,183,temz*multi+50,400,temj*multi+50,300,temj*multi+50,500);
            stroke(line);   
            translate(j*multi+50,503);
            line(0,0,0,timeBar[j]);
            translate(-j*multi-50,-503);
            
            translate(z*multi+50,180);
            line(0,0,0,-locationBar[z]);
            translate(-z*multi-50,-180);
            if(money[z]<0){money[z]=0;}
            if(money[z]>2000){money[z]=2000;}
            translate(z*multi+50,100);
            line(0,0,0,-money[z]/50);
            translate(-z*multi-50,-100);
            stroke(100,0);
            
            //println(j);
            countText++;
            //println(countText);
         
              }       
            }          
          }    
        }
      }    
}

void showTexts(int indexZ, int indexJ, int count){
  
rectMode(CORNER);
fill(250);
noStroke();
rect(width/2-500,0,width/2+500,50);
fill(240);
if(count%2==0){
rect(width-paddingRight-20,count*10+50,80,10);
}
println(count);
fill(0);
textFont(fontB);
text("You have spend  "+money[indexZ]+"  at  "+location[indexZ]+" for  "+locationBar[indexZ]+"times",width/2-100,50);
text("Date          Times",width-paddingRight+25,30);
textFont(fontC);
text(time[indexJ],width-paddingRight,count*10+60);
text(timeBar[indexJ],width-paddingRight+55,count*10+60);
noFill();
}


void keyPressed(){
  if(key=='w'){
  count=count+1;
  }else if(key=='s'){
  count=count-1;
  }
}
