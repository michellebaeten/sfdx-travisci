trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
List<BatchLeadConvertErrors__c> newErrors = new List<BatchLeadConvertErrors__c>();
    
    for (BatchApexErrorEvent event : Trigger.New) {
        BatchLeadConvertErrors__c newError = new BatchLeadConvertErrors__c();
        newError.AsyncApexJobId__c = event.AsyncApexJobId;
        newError.Records__c = event.JobScope;
        newError.StackTrace__c = event.StackTrace;
        newErrors.add(newError);
    }
    insert newErrors;
}