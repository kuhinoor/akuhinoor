public class popupController{
    public boolean displayPopup {get;set;}        
    public void showPopup(){
        displayPopup= true;
    }
    public void closePopup(){
        displayPopup = false;
    }
}