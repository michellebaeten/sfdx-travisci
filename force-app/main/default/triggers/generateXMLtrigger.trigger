trigger generateXMLtrigger on XML_tool__c (before insert) {
        generateXML.createXMLfiles(Trigger.New);
    
}