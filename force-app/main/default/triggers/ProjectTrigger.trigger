trigger ProjectTrigger on Project__c (after update) {
    if (Trigger.isUpdate && Trigger.isAfter){
	BillingCalloutService.callBillingService(Trigger.new, Trigger.OldMap);
    }
}