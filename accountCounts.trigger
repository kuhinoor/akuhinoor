trigger accountCounts on Contact (after insert,after update,after delete) {   
    map<id,list<contact>> contactMap = new map<id,list<contact>>();
    set<id> ids = new set<id>();
    list<account> accLst = new list<Account>();
   if(trigger.isInsert || trigger.isUpdate){
       for(contact con : Trigger.new){
        ids.add(con.accountId);
       } 
    }
   
   
   if(trigger.isDelete || trigger.isUpdate ){
       for(contact con : Trigger.old){
        ids.add(con.accountId);
    }  
   }          
    for(Account acc : [ select id,count__c,(select lastname from contacts) from account where id IN : ids]){
        contactMap.put(acc.id,acc.contacts);
    }
     
    if(trigger.isInsert || trigger.isUpdate){   
    for(contact con : trigger.new){
        if(con.accountId != null){
            Account accObj = new Account();
            accObj.id = con.accountId;           
            accObj.count__c = contactMap.get(con.accountId).size();
            accLst.add(accObj);
            system.debug('*************'+contactMap.get(con.accountId).size());
        }
    }
    }
    
     if(trigger.isDelete || trigger.isUpdate){
        for(contact con : trigger.old){
        if(con.accountId != null){
            Account accObj = new Account();
            accObj.id = con.accountId;
            accObj.count__c = contactMap.get(con.accountId).size();
            accLst.add(accObj);
        }
    } 
     }
     
    if(accLst.size() > 0){
        update accLst;
    }
    
    
 }