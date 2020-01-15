public class generateXML {
    public static void createXMLfiles (List<XML_tool__c> xmls){
        String emailto = [Select Email from User where Username = :Userinfo.getUserName() limit 1].Email;
        Id folder = [Select Id from Folder where Name = 'XML' limit 1].Id;
        for (XML_tool__c xml : xmls){
        String xmllong = xml.XML_file__c;
        String MDtype = xml.custom_metadata_type__c;
        List<String> xmlfiles = xmllong.split('<label>');
        xmlfiles.remove(0);
        List<Document>filestoinsert = new List<Document>();
        List<Messaging.EmailFileAttachment> docslist = new List<Messaging.EmailFileAttachment>();
        for (String xm : xmlfiles){
           Document d = new Document(); 
            string name = xm.substringBefore('</');
            system.debug('name would be '+ name);
            d.Name = MDtype + '.' + name;
            d.ContentType = 'text/plain';
            d.FolderId = folder;
            d.Type = 'md';
            d.DeveloperName = MDtype + name;
            xm = '<?xml version="1.0"?>'+ '\n' + '<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+ '\n' +'<label>' + xm + '\n' +'</CustomMetadata>';
			d.Body = Blob.valueOf(xm);
            filestoinsert.add(d);
            Messaging.EmailFileAttachment doc = new Messaging.EmailFileAttachment();
            doc.setContentType('text/plain');
            doc.setFileName(MDtype + '.' + name + '.md');
            doc.setInline(false);
            doc.Body = Blob.valueOf(xm);
            docslist.add(doc);
        }
      //  insert filestoinsert;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {emailto});
        email.setSubject('XML files');
        email.setHTMLBody('files attached');
        email.setFileAttachments(docslist);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }}

}