global class productListController
{

    //get all the products in the org along with their attachments.
    @remoteAction
    global static remoteObject getProducts()
    {
        remoteObject returnObj = new remoteObject();

        try
        {

            list<Product2> products = [select 
                                                Name,
                                                ProductCode,
                                               Description,
                                               Family,
                                               isActive,
                                               (SELECT Attachment.Name, Attachment.Id FROM Product2.Attachments)
                                               from product2
                                               where isActive = true];
            returnObj.sObjects = products;
        }
        catch(Exception e)
        {
            returnObj.success = false;
            returnObj.message = 'Error getting products';
            returnObj.data = 'Error Type: ' + e.getTypeName() + ' ' + e.getCause() + ' ' + ' on line: ' +e.getLineNumber(); 
        }

        return returnObj;       
    }

    //gets a single attachment (photo) by id. The data is returned as a base64 string that can be plugged into an html img tag to display the image.
    @RemoteAction
    global static remoteObject getAttachment(id attachmentId)
    {   
        remoteObject returnObj = new remoteObject();
        try
        {
            list<Attachment> docs = [select id, body from Attachment where id = :attachmentId limit 1]; 
            if(!docs.isEmpty())
            {
                returnObj.data = EncodingUtil.base64Encode(docs[0].body); 
            }    
        }
        catch(exception e)
        {
            returnObj.success = false;
            returnObj.message = e.getMessage();
            returnObj.data = 'Error Type: ' + e.getTypeName() + ' ' + e.getCause() + ' ' + ' on line: ' +e.getLineNumber();        
        } 
        return returnObj;    
    }   

    global class remoteObject
    {
        public boolean success = true;
        public string message = 'operation successful';
        public string data = null;
        public list<sObject> sObjects = new list<sObject>();
    }    
}