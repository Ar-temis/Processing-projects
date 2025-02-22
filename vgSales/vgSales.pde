import java.util.*;
import processing.pdf.*;

Table table;
float maxSale = 0;
int maxSeller;
float graphStart = 100;
float graphEnd = 30;
List<Bar> publishers = new ArrayList<Bar>();

void setup(){
  size(1080, 1920, PDF, "graph.pdf");
  //size(1080, 1920);
  background(25, 25, 25);
  // Initializing the table and adding them into the arraylist
  for (int i=0; i<2016-1980+1; i++){
    publishers.add(new Bar("null", 0, "null", "null"));
  }
  table = loadTable("vgsales.csv", "header");
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    // ignoring the null value years and 2017, 2020 because there are only 4 games
    int year = row.getInt("Year");
    if (year == 0 || year == 2017 || year == 2020){
      continue;
    }
    String publisherName = row.getString("Publisher");
    String gameName = row.getString("Name");
    String genre = row.getString("Genre");
    float sale = row.getFloat("Global_Sales");
    if (sale > publishers.get(year - 1980).getSales()){
      publishers.set(year - 1980, new Bar(publisherName, sale, gameName, genre));
      if (sale > maxSale){
        maxSale = sale;
        maxSeller = year - 1980;
      }
    }
  }
  textAlign(CENTER);
  textSize(40);
  text("Top selling videogames of each year from 1980 to 2016", width/2, 80);
  textSize(20);
  text("Numbers are in millions", width/2, 120);
  normalize(publishers);
  pushMatrix();
  translate(0, 150);
  drawGraph(publishers);
  drawLegend();
  popMatrix();
}

void drawGraph(List<Bar> publishers){
  float offset = (height - 200) / publishers.size();
  // the measurement line above
  stroke(255);
  line(graphStart, 0, width-graphEnd, 0);
  line(graphStart, height-200, width-graphEnd, height-200);
  for (int i=1; i<18; i++){
    float interval = graphStart+(width-graphEnd-graphStart)/17*i;
    stroke(79, 78, 78, 100);
    line(interval, 0, interval, height-200);
    stroke(255);
    line(interval, -3, interval, 3);
    line(interval, height-203, interval, height-197);
    textSize(12);
    textAlign(CENTER);
    text(i*5, interval, -8);
    text(i*5, interval, height-185);
  }

  textSize(25);
  textAlign(LEFT);
  for (int i = 0; i < publishers.size(); i++) {
    stroke(0);
    fill(255);
    text(i+1980, 30, 40 + offset * i);
    chooseColor(publishers.get(i).genre);
    rect(graphStart, 10 + offset*i, publishers.get(i).width, offset);
    fill(255);
    if (publishers.get(i).sales < 25) {
      text(publishers.get(i).game, graphStart+publishers.get(i).width+10, 40+offset*i);
    }else{
      text(publishers.get(i).game, graphStart+10, 40+offset*i);
    }
  }
  stroke(255);
  line(graphStart, 0, graphStart, height-200);
}

void normalize(List<Bar> publishers){
  for (Bar p: publishers){
    p.width = p.sales*(width-graphStart-graphEnd)/85;
  }
}

void drawLegend(){
  String[] genres = {"Action","Sports","Role-Playing","Shooter","Platform","Misc","Racing","Simulation","Puzzle","Adventure","Strategy"};
  for (int i=0; i<genres.length; i++){
    chooseColor(genres[i]);
    rect(graphStart+(width-graphStart-graphEnd)/17*13-30, 100+i*30, 15, 15); 
    textSize(20);
    text(genres[i], graphStart+(width-graphStart-graphEnd)/17*13-10, 115+i*30);
  }
}

void chooseColor(String p){
  switch (p){
    case "Action":
      fill(255, 173, 96);
      break;
    case "Sports":
      fill(154, 203, 208);
      break;
    case "Shooter":
      fill(200, 75, 49);
      break;
    case "Role-Playing":
      fill(236, 219, 186);
      break;
    case "Platform":
      fill(41, 115, 178);
      break;
    case "Misc":
      fill(255,217,95);
      break;
    case "Racing":
      fill(184,213,118);
      break;
    case "Fighting":
      fill(252, 231, 200);
      break;
    case "Simulation":
      fill(126, 92, 173);
      break;
    case "Puzzle":
      fill(150, 206, 180);
      break;
    case "Adventure":
      fill(160, 35, 52);
      break;
    case "Strategy":
      fill(241, 158, 210);
      break;
  }


}
class Bar{
  String game;
  String name;
  float sales;
  float width;
  String genre;
  Bar(String name, float sale, String game, String genre){
    this.name = name;
    this.sales = sale;
    this.game = game;
    this.genre = genre;
  }

  float getSales() {
    return sales;
  }

  @Override
  public String toString() {
    System.out.println(String.format("Bar: %s, Sales: %f", name, sales));
    return "";
  }
}
