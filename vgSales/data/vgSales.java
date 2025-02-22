import java.util.*;

Table table;
float maxSale = 0;
int maxSeller;
List<Publisher> publishers = new ArrayList<Publisher>();

void setup(){
  size(1080, 1920);
  background(25, 25, 25);
  // Initializing the table and adding them into the arraylist
  for (int i=0; i<2016-1980+1; i++){
    publishers.add(new Publisher("null", 0, "null"));
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
    float sale = row.getFloat("Global_Sales");
    if (sale > publishers.get(year - 1980).getSales()){
      publishers.set(year - 1980, new Publisher(publisherName, sale, gameName));
      if (sale > maxSale){
        maxSale = sale;
        maxSeller = year - 1980;
      }
    }
  }   
  drawGraph(publishers);
}

void drawGraph(List<Publisher> publishers){
  float offset = (height - 80) / publishers.size();
  textSize(30);
  fill(255);
  line(100, 10, 100, height-10);
  for (int i = 0; i < publishers.size(); i++) {
    stroke(0);
    text(i+1980, 50, 40 + offset * i);

  }
}

class Publisher{
  String game;
  String name;
  float sales;

  Publisher(String name, float sale, String game){
    this.name = name;
    this.sales = sale;
    this.game = game;
  }

  float getSales() {
    return sales;
  }

  @Override
  public String toString() {
    System.out.println(String.format("Publisher: %s, Sales: %f", name, sales));
    return "";
  }
}

