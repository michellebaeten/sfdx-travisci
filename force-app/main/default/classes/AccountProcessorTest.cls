@isTest
public class AccountProcessorTest {

    @isTest static void TestAccount() { 
        List<Contact> testcontacts = RandomContactFactory.generateRandomContacts(6, 'Test Name');
        List<Account> testaccounts = new List<Account>();
        Account acct1 = new Account(Name = 'Test Account 1');   
        testaccounts.add(acct1);
        Account acct2 = new Account(Name = 'Test Account 2');
        testaccounts.add(acct2);
        insert testaccounts;
        List<Id> acctids = new List<Id>();
        testaccounts = [Select Id from Account];
        for (Account act : testaccounts){
            acctids.add(act.Id);
        }
        testcontacts[0].AccountId = acctids[0];
        testcontacts[1].AccountId = acctids[1];
        testcontacts[2].AccountId = acctids[0];
        testcontacts[3].AccountId = acctids[1];
        testcontacts[4].AccountId = acctids[0];
        testcontacts[5].AccountId = acctids[0];        
        insert testcontacts;   
        Test.startTest();
        AccountProcessor.countContacts(acctids);
        Test.stopTest();
    }

}