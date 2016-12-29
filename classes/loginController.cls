public class loginController{
    public Registration__c registration{get;set;}
    public String userName{get;set;}
    public String passwrd{get;set;}
    public loginController(){
        registration = new Registration__c();
    }    
    public void register(){
        insert registration;
    }
    
    // check login process
    public void loginProcess(){
        Registration__c reg = [SELECT User_Name__c,Password__c FROM Registration__c where User_Name__c= : userName];
        
    }
}