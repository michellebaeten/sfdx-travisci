public class AccountProcessor {
    
    @future
    public static void countContacts (List<Id> acctids){
        List<Contact> linkedcontacts = [Select Id, AccountId from Contact where AccountId in :acctids];
        List<Account> acctsToUpdate = new List<Account>();
        Map<Id, Integer> acctidmap = new Map<Id, Integer>();
        for (Contact cont : linkedcontacts){
            if (acctidmap.containskey(cont.AccountId)){
                acctidmap.put(cont.AccountId, acctidmap.get(cont.AccountId)+1);
            }else acctidmap.put(cont.AccountId, 1);
        }
        Map<Id, Account> acctmap = new Map<Id, Account>([Select Id, Number_of_Contacts__c from Account where Id in :acctids]);
        for (Id acctid : acctidmap.keySet()){
            Account acct = acctmap.get(acctid);
            acct.Number_of_Contacts__c = acctidmap.get(acctid);
            acctsToUpdate.add(acct);
            
        }
		update(acctstoUpdate);        
    }

}