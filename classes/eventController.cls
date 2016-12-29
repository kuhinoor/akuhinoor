public class eventController{
    public string eventStr{get;set;}
    public eventController(){
        list<event__c> eventList = [select Name,Start_Date__c,End_Date__c from event__c ];
         eventStr = '[';
         string coma = '';
        for(event__c evObj : eventList ){           
            eventStr += '{';
            eventStr +=  'title:'+'\''+evObj.Name+'\''+',';
            eventStr +=  'start:'+'\''+evObj.Start_Date__c+'7:30'+'\''+',';
            eventStr +=  'end:'+'\''+evObj.End_Date__c+'8:30'+'\'';
            eventStr += '},';
        }
        eventStr += ']';
    }
}