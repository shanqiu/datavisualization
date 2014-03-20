float num=140;
float total=331;
color c= color(179, 19, 25);
PFont fontA,fontB,fontC;
String percentPrint;
float speed=0.1;
float end=0;
void setup(){
size(500,500);
fontA=createFont("HelveticaNeueLTPro-Lt-16",16);
fontB=createFont("HelveticaNeueLTPro-Lt-12",12);
fontC=createFont("HelveticaNeueLTPro-Lt-10",10);
textAlign(CENTER);
strokeCap(SQUARE);
strokeJoin(MITER);
}

void draw(){
background(255);
noFill();
stroke(c);
strokeWeight(1);

//ellipse(width/2,height/2,80,80);
float degree = map(num,0,total,0,TWO_PI);
float percent = num*100/total;
percentPrint=String.format("%.3f", percent);
println(percentPrint);

arc(width/2,height/2,80,80,0,end,PIE);
arc(width/2,height/2,70,70,0,end);
fill(255);
noStroke();
ellipse(width/2,height/2,68,68);
fill(c);
textFont(fontA);
text(percentPrint+"%",width/2,height/2);
if(end<degree)end+=speed;
else end=end;

dateLines();
}
void dateLines(){
noFill();
stroke(c);

for(int i=0;i<10;i++){
beginShape();
vertex(width/3+i*10,height/2);
vertex(width/2+i*10,height/3);
vertex(width/2+i*10,height/4);
endShape();
}
}
