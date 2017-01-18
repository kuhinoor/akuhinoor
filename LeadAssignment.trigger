trigger LeadAssignment on Lead (after insert,after update) {
    set<id> ids = new set<id>();    
    map<String,list<Admission_Advisor__c>> universitymap = new map<String,list<Admission_Advisor__c>>();
    
    list<Admission_Advisor__c> admissionAdvisorsLst = [SELECT lightingprefix__No_of_Assign_Lead__c,lightingprefix__Last_Assigned__c,lightingprefix__University__c,lightingprefix__User__c from Admission_Advisor__c order By LastModifiedDate asc];
    //admissionAdvisorsLst.remove(admissionAdvisorsLst.size()-1);
    
    for(Admission_Advisor__c adObj : admissionAdvisorsLst){
         list<Admission_Advisor__c> temp =  universitymap.get(adObj.lightingprefix__University__c);
         if(temp  == null ){
             temp = new  list<Admission_Advisor__c>();
         }
         temp.add(adObj);
         universitymap.put(adObj.lightingprefix__University__c,temp);   
    }
    decimal count= 0;
    system.debug('#########'+universitymap);
    list<Admission_Advisor__c> leadAdmissionList = new list<Admission_Advisor__c>();
    Set<Id> admissionSet = new Set<Id>();
    for(Lead ld : Trigger.new){
         if(universitymap.containsKey(ld.lightingprefix__University__c)){
              boolean isAssigned = false;
              for(Admission_Advisor__c admissionObj : universitymap.get(ld.lightingprefix__University__c)){
                  If(admissionSet.add(admissionObj.Id) && !isAssigned){
                   
                   if(admissionObj.lightingprefix__No_of_Assign_Lead__c == null){
                    count = 1;
                   }else{
                        count = admissionObj.lightingprefix__No_of_Assign_Lead__c + 1;
                   }
                      
                      leadAdmissionList.add(new Admission_Advisor__c(Id = admissionObj.Id, lightingprefix__Last_Assigned__c = datetime.now(),lightingprefix__No_of_Assign_Lead__c = count ));
                      isAssigned = true;
                  }
              }
         }    
    } 
       
    If(leadAdmissionList.size()>0){
        update leadAdmissionList;
    }
    
}