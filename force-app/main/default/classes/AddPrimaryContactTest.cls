@isTest
public class AddPrimaryContactTest {

    @testSetup
    static void setup(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState = 'CA'
            ));}
         for (Integer i = 50; i < 100; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState = 'NY'
            ));}
        insert accounts;
        Contact testcontact = new Contact(LastName = 'Test Contact');
        insert testcontact;
    }
    static testmethod void testQueueable(){
        Contact testct = [Select Id, LastName from Contact where LastName = 'Test Contact' Limit 1];
        AddPrimaryContact adding = new AddPrimaryContact(testct, 'CA');
        Test.startTest();
        System.enqueueJob(adding);
        Test.stopTest();
        System.assertEquals(50, [Select count() from Contact where Account.BillingState = 'CA']);
    }
}