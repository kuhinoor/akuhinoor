trigger updateAccounts on contact(after insert, after update){    
    map<id,list<contact>> contactMap = new map<id,list<contact>>();
    list<Account> acclist = new list<Account>();
    set<id> ids = new set<id>();
    for(contact con : trigger.new){
        ids.add(con.accountId);
    }
    for( Account acc :[select id,(select lastname from contacts) from account where id IN : ids]){
        contactMap.put(acc.id,acc.contacts);
        system.debug('************ map: '+acc.contacts.size());
    }    
     
    for(Contact c : trigger.new){
        Account acc = new Account();
        acc.id = c.accountId;
        acc.count__c = contactMap.get(c.accountId).size();  
        system.debug('************'+contactMap.get(c.accountId).size());
        acclist.add(acc);
    }
    update acclist;
}