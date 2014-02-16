import java.io.*;

void fileChoose(){
   selectFolder("Select a folder to process:", "fileChosen");  // Opens file chooser

}

void fileChosen(File folderPath){
    if (folderPath == null) {
    // If a folder was not selected
      println("No folder was selected...");
      //fileChoose();
    } 
  else {
    // If a folder was selected, print path to folder
    //println(folderPath);
    getJPG(folderPath);
  }
}

void getJPG(File folder){
  String folderString =  null;
  String folderName =  null;
  try{
     folderString = folder.getCanonicalPath();
     folderName = folderString.substring(folderString.lastIndexOf("/"));
     if(folderName==null){
       //for Windows users
       folderName = folderString.substring(folderString.lastIndexOf("\\"));
     }
  }
  catch(Exception e){
    println("No folder selected");
  }
  // let's set a filter (which returns true if file's extension is .jpg)
  FilenameFilter jpgFilter = new FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".jpg") || name.toLowerCase().endsWith(".jpeg");
    }
  };
   
    // list the files in the data folder, passing the filter as parameter
    String[] filenames = folder.list(jpgFilter);
     
    // get and display the number of jpg files

    
     
    Table table = new Table();
    
      
    table.addColumn("name");
    table.addColumn("brightness");
    // display the filenames
    for (int i = 0; i < filenames.length; i++) {   
      String filename = folderString + "/"+filenames[i];
      
      TableRow newRow = table.addRow();
      newRow.setString("name", filenames[i]);
      newRow.setInt("brightness", findBrightness(filename));
      saveTable(table, "data/"+folderName+".csv");
  }
  println(filenames.length + " jpg files in specified directory");
  text("Done!", width/2, height/2); 
  //fileChoose();
}
