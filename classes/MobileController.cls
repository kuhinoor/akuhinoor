global with sharing class MobileController {
    //Used to fetch Contact for mobile user lookup using auto complete
    @RemoteAction
    global static List<Contact> queryContacts(String keyword) {
        List<Contact> contactList = new List<Contact>();
        if (keyword != null && keyword.trim() != '') {
            keyword = '%' + keyword + '%';
            contactList = [Select Id, FirstName, LastName from Contact where Name like :keyword limit 5];
        }
        return contactList;
    }
}