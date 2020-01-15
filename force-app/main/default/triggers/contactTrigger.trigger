trigger contactTrigger on Contact (after insert, after update, after undelete, after delete){
    // Run the updateAccounts method in the ContactTriggerHandler class
    if (Trigger.isDelete && Trigger.isAfter){
        ContactTriggerHandler.updateAccounts(Trigger.old);
    } else {
        ContactTriggerHandler.updateAccounts(Trigger.new);
    }
}