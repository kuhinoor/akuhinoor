Public with sharing class vfpagelayoutcls12
{
    //Get Comma-separated Apiname of fields found on a pagelayout
    public string rectypefld {get;set;}  
    //Get SObject Selected if any
    public string objectselected {get;set;} 
   
    //list of fields with values
    public list<objectfieldinfo> objectfieldlist {get;set;}
    //Enable/disable edit mode  
    public vfpagelayoutcls12()
    {   
        //Initializing Variables
        id tempid=ApexPages.currentPage().getParameters().get('id');
       // objectselected = tempid.getSObjectType().getDescribe().getName();  
        objectselected  = [SELECT  SobjectType FROM RecordType where Id = :tempid].SobjectType ;
        objectfieldlist = new list<objectfieldinfo>();
    }   
       
    //method called on onload of page to showdata fields with data dynamically
    public void calledonload()
    {
        list<String> reqfldlist=new list<String>();     
        list<string> reqfldlist_temp=rectypefld.split('%kuhi%');
        if(reqfldlist_temp.size()!=1)
        reqfldlist=reqfldlist_temp[1].split(',');
        rectypefld=reqfldlist_temp[0];
        list<string> rlist=new list<string>();  //list to split recordtype fields
        if(rectypefld!='' || rectypefld!=null)
        {
            rlist=rectypefld.split(','); 
        }
        objectfieldinfo sfld;                
        for(string r1 :rlist)
        {
            sfld=new objectfieldinfo(); 
            if(r1!='' || r1!=null)
            {  
                 //check if required
                 sfld.apiname=r1;
                 sfld.isrequired=false;
                 for(String req:reqfldlist)
                 {
                     if(r1.trim()==req.trim())
                        sfld.isrequired=true;
                 }                                   
                 objectfieldlist.add(sfld);
            }
        }   
    }
    //wrapper class for storing field apiname
    public class objectfieldinfo
    {
        public string apiname{get;set;}             // for storing apiname of the field
        public boolean isrequired{get;set;}         // to check if the particular field is required or not
    }
}