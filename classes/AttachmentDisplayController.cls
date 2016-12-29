public class AttachmentDisplayController{
public list<Attachment> attLst{get;set;}
    public AttachmentDisplayController(){
        attLst = [select Name,ContentType from Attachment limit 20];
    }
}