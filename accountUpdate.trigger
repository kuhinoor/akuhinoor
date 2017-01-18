trigger accountUpdate on Contact (after update,after insert,after delete) {
    list<id> ids = new list<id>();
    list<account> updateLst = new list<account>();   
    if(trigger.isInsert || trigger.isUpdate){
       for(contact con : trigger.new){
         ids.add(con.accountId);
       }
    }
    if(trigger.isDelete|| trigger.isUpdate){
       for(contact con : trigger.old){
         ids.add(con.accountId);
     }
   }    
    for(account acc : [ select id,count__c,(select id,lastname from contacts) from account where id IN : ids]){
         acc.count__c = acc.contacts.size();   
         updateLst.add(acc);
    }
    update updateLst;
  }