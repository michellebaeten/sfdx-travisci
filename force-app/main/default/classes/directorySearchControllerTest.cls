@isTest
public class directorySearchControllerTest {

    static testMethod void testSearch()
    {
        		 Account testAccount = new Account();
 				testAccount.Name='Test Account record' ;
        		testAccount.Status__c = 'Approved';
        		testAccount.Services__c = 'Service1';
        		testAccount.Location__c = 'UK';
 				insert testAccount;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] =  testAccount.Id;
        System.Test.setFixedSearchResults(fixedSearchResults);

        
        Test.startTest();
        PageReference pageRef = Page.directorySearch;
        Test.setCurrentPage(pageRef);
        directorySearchController controller = new directorySearchController();
        controller.searchString = 'Test Account';
        controller.selectedServices.put('Service1', true);
        controller.selectedLocations.put('UK', true);   
        controller.search();
        System.assertEquals(1, controller.getResultSize());
        controller.home();
        List<Account> results = new List<Account>();
        results = controller.getResults();
        System.assertEquals(1, results.size());
        controller.next();   
        system.assertEquals(false,controller.getHasNext());
        controller.previous();   
        system.assertEquals(false,controller.getHasPrevious());    
        controller.searchString = '';
        controller.selectedServices.remove('Service2');
        controller.selectedServices.put('Service2', true);        
        controller.search();             
        Test.stopTest();
        
    }
}