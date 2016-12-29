public with sharing class Attachradiocls1 {
    public Contact contobj{get;set;}
    public Attachradiocls1 (ApexPages.Standardcontroller stdcontroller){
        contobj=new Contact();
        String id=ApexPages.CurrentPage().getParameters().get('id');
        if(id!=null && id!=''){
            Attachment att=[select id,name,parentId,body from attachment where id=:id];
            //body=att.body.tostring();
            contobj=[select id,name,Email,LeadSource from Contact where id=:att.parentId];
        }
        
    }
}