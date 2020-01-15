/* *************************
  Controller for directoryResults page

************************* */
public class directoryResultController {

    public Account record;
    
    public directoryResultController(ApexPages.StandardController cont) {
        record = [Select Id, Name, Services__c, Location__c From Account Where Id = :cont.getId()];
    }
    
    public list<string> getServices() {
       if(record.Services__c != null) return record.Services__c.split(';');       
       return new list<string>{};
    }
    
}