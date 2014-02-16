import java.awt.Rectangle; 

public class Button extends java.awt.Rectangle {
  
    int w;
    int h;
    String text;
    int index;
    boolean isHidden = false;
    color col;
    color hover;
    color normal;
    
     /**
     * Default constructor that makes buttons
     *
     * @param  text  what text of button will say
     * @param  x  x coordinate on canvas
     * @param  y  y coordinate on canvas
     * @param  w  button width
     * @param  h  button height
     */
    public Button(String text, int x,int y, int w, int h, color col, color hover) {
      //call the java.awt.Polygon constructor
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      this.col = col;
      this.hover = hover;
      this.normal = col;
    }

    
    /**
     * Changes color of button
     * Used in Relative View button to denote active/unactive
     *
     * @param color  button background color
     */
    public void setColor(color col){
     this.col = col;
    }   
    
    /**
     * Draws the button
     *
     */
    void draw() {
      if (isHidden) {
        fill(0);
        stroke(0);
      } 
      else {
        fill(col); 
        noStroke();
        rect(x,y,w,h);
        fill(100); 
        textAlign(CENTER,CENTER);
        text(text,x+w/2,y+h/2);
      }
    }
    
    /**
     * Checks if button is hovered
     *
     * @return  ans  whether button has been pressed
     */
    public void hover(){
      boolean ans= false;
      if (mouseX >= x && mouseX < x+w && mouseY >= (y) && mouseY < (y+h)){
          this.col= hover;
        
      } 
      else{
        this.col = normal;
      }
      draw();
    }
    
    /**
     * Checks if button has been pressed, returns boolean
     *
     * @return  ans  whether button has been pressed
     */
    public boolean pressed(){
      boolean ans= false;
      if (mouseX >= x && mouseX < x+w) {
        if (mouseY >= (y) && mouseY < (y+h)){
          ans= true;
        }
      } 
      return ans;
    }
    
    /**
     * Changes visibility (hide) for Snapshot Delete Buttons
     */
    public void hide(){
      isHidden = true;
    }
    
     /**
     * Changes visibility (show) for Snapshot Delete Buttons
     */ 
    public void show(){
      isHidden = false;
    }
}
