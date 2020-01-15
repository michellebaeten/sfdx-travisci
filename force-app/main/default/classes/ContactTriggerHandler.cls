public class ContactTriggerHandler {
    // *** PART A - Receive a list of records that have been updated  ***
    public static void updateAccounts(List<Contact> listContacts){

        Set<Id> setAccountIDs = new Set<Id>();

        for(Contact c : listContacts){
            setAccountIDs.add(c.AccountId);
        }

        Map<Id,Account> accountMap = new Map<Id,Account>( [Select Id, Has_Private_Contacts__c from Account where Id in :setAccountIDs]);
        system.debug(accountMap);

        List<Contact> privateContacts = [Select Id, AccountId from Contact where Private__c = TRUE AND AccountId in :setAccountIDs];

        List<Account> accountsToUpdate = new List<Account>();
        for(Contact c : privateContacts ){
            system.debug(accountMap.containsKey(c.AccountId));
            if (accountMap.containsKey(c.AccountId)){  
                if (accountMap.get(c.AccountId).Has_Private_Contacts__c == false){
                accountMap.get(c.AccountId).Has_Private_Contacts__c = true;
                accountsToUpdate.add(accountMap.remove(c.AccountId));                
                }
            else accountMap.remove(c.AccountId);} 

        }
        for (Account a : accountMap.values()){
            if (a.Has_Private_Contacts__c == true){
            a.Has_Private_Contacts__c = false;
            accountsToUpdate.add(a);
            }
        }       

        If(accountsToUpdate.Size() > 0) {
            Update accountsToUpdate;
        }
    }
}