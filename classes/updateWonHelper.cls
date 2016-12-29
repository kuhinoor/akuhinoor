public class updateWonHelper{
    public static void updateField(list<A__C> newLst){
        for(A__c obj : newLst){
            if(obj.status__c == 'Closed'){
            obj.isWon__c = true;
        }else{
            obj.isWon__c = false;
        }   
        }
    }
}