public class myContactCtlr{
@AuraEnabled
public static List<Contact> getContacts() {
    return [Select Id, Name, Email, Title, Phone From Contact limit 10];
}
}