public class sendEmailWithImage 
{
    public string strImageBlob {get;set;}

    public void sendEmail()
    {
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        List<String> lstString = new List<String>();
        mail.setToAddresses(new String[]{'kuhinoor.alam@ibirdsservices.com'});
        mail.setSubject('Email found');
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('image/png');
        attach.setFileName('Test.png');
        attach.setInline(false);
        attach.Body = EncodingUtil.base64Decode(strImageBlob.replaceFirst('data:image/png;base64,',''));
        mail.setHtmlBody('Please find the attached Image');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}