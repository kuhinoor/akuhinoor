public class surveyController{
    public List<Survey_Question__c> surveyQuestionLst{get;set;}
    public Survey_Question__c surveyQuestion{get;set;}
    public map<id,survey_Question_Response__c> surveyQuestionMap{get;set;}
    public Integer slno{get;set;}
    public String answer{get;set;}
    private id ids;
    public surveyController(){
        slno = 0;
        answer = '';
        surveyQuestion = new Survey_Question__c();        
        surveyQuestionMap = new map<id,survey_Question_Response__c>();
        ids = apexpages.currentpage().getparameters().get('surveyid');
        id quesId = apexpages.currentpage().getparameters().get('quesId');
        surveyQuestionLst = [SELECT Id,survey__r.Name,Correct_Answer__c,lightingprefix__survey__c, lightingprefix__Question__c, lightingprefix__Option_A__c, lightingprefix__Option_B__c, Question_No__c FROM lightingprefix__Survey_Question__c where survey__c = : ids ORDER BY Question_No__c ];
         for(lightingprefix__survey_Question_Response__c  obj : [select lightingprefix__Survey_Question_id__c,id,lightingprefix__Student_Answer__c from lightingprefix__survey_Question_Response__c where lightingprefix__survey_Id__c =:ids]){
                    surveyQuestionMap.put(obj.lightingprefix__Survey_Question_id__c,obj);
                }       
         if(quesId !=null){
             for(lightingprefix__Survey_Question__c  quesObj : [SELECT Id,survey__r.Name,Correct_Answer__c,lightingprefix__survey__c, lightingprefix__Question__c, lightingprefix__Option_A__c, lightingprefix__Option_B__c, Question_No__c FROM lightingprefix__Survey_Question__c where survey__c = : ids ORDER BY Question_No__c] ){
                if(quesObj.id == quesId ){
                     surveyQuestion = quesObj;
                     integer no = (integer)quesObj.Question_No__c;
                     slno = no-1;
                      answer = surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c ;
                }                 
             }
            
         }else{
             //surveyQuestionLst = [SELECT Id,survey__r.Name,Correct_Answer__c,lightingprefix__survey__c, lightingprefix__Question__c, lightingprefix__Option_A__c, lightingprefix__Option_B__c, Question_No__c FROM lightingprefix__Survey_Question__c where survey__c = : ids ORDER BY Question_No__c ];
             surveyQuestion = surveyQuestionLst[slno];
         }
        system.debug('------>>'+surveyQuestionMap);
       /* system.debug('------>>'+surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c);
        system.debug('------>>'+answer);
        system.debug('----surveyQuestionLst.id-->>'+ surveyQuestionLst[slno].id);
        */
        system.debug('=================>>'+slno);
    }
    
    // NEXT question-----
    public void next(){
           if(surveyQuestionMap.containsKey(surveyQuestionLst[slno].id) ){
               surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c = answer;
               surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__isCorrect__c = (answer==surveyQuestionLst[slno].Correct_Answer__c);
               update surveyQuestionMap.get(surveyQuestionLst[slno].id);
               
           }else{
                survey_Question_Response__c quesResponse = new survey_Question_Response__c(
                                                            lightingprefix__survey_Id__c = ids,
                                                            lightingprefix__Student_Answer__c = answer,
                                                            lightingprefix__Survey_Question_id__c = surveyQuestionLst[slno].id,
                                                            lightingprefix__isCorrect__c = (answer==surveyQuestionLst[slno].Correct_Answer__c));
          
                insert quesResponse;
                 surveyQuestionMap.put(surveyQuestionLst[slno].id,quesResponse);
                 system.debug('############'+surveyQuestionMap);
                //surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c = answer;
           }            
          
          slno = slno +1;
          if(slno == surveyQuestionLst.size()){
              slno =0;
          }
          surveyQuestion = surveyQuestionLst[slno];
         
          if(surveyQuestionLst[slno].id!=null && surveyQuestionMap.containsKey(surveyQuestionLst[slno].id)){
           answer = surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c;
         }else{
             answer='';
         }         
    }
    
    public void pre(){
        slno = slno-1;
        system.debug('*************Pre : '+surveyQuestionMap);
         system.debug('=================>>'+slno);
       
        surveyQuestion = surveyQuestionLst[slno];
        if(surveyQuestionMap.containsKey(surveyQuestionLst[slno].id)){
            answer = surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c;
        }
        //system.debug('*************Pre : '+surveyQuestionMap.get(surveyQuestionLst[slno].id).lightingprefix__Student_Answer__c);
        system.debug('*************ques id: '+surveyQuestionLst[slno].id);
    }
}