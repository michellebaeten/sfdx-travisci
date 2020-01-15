@isTest
private class BillingCalloutServiceTest {
    @testSetup static void createData(){
        Opportunity Opp1 = new Opportunity(Name = 'New Opp1', Type = 'New Project', Amount = 100, 
                                           StageName = 'Prospecting', CloseDate = date.today());
        insert Opp1;
        Project__c Proj1 = new Project__c(Opportunity__c = Opp1.Id, ProjectRef__c = '12345678', Name = 'New Project1',
                                         Start_Date__c = Date.today(), End_Date__c = Date.today(), Billable_Amount__c = 100,
                                         Status__c = 'Running');
        insert Proj1;
         Project__c Proj2 = new Project__c(Opportunity__c = Opp1.Id, ProjectRef__c = '87654321', Name = 'New Project2',
                                         Start_Date__c = Date.today(), End_Date__c = Date.today(), Billable_Amount__c = 100,
                                         Status__c = 'Running');
        insert Proj2;       
        ServiceCredentials__c credentials = new ServiceCredentials__c();
        credentials.Name = 'BillingServiceCredential';
        credentials.Username__c = 'username';
        credentials.Password__c = 'password';
        insert credentials;        
    }
    @isTest static void testCallout (){
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        Project__c proj = [Select Id, Status__c from Project__c where ProjectRef__c = '12345678' limit 1];
        Test.startTest();
        proj.Status__c = 'Billable';
        update proj;
        Test.stopTest();
        Project__c proj2 = [Select Id, Status__c from Project__c where ProjectRef__c = '12345678' limit 1];
system.assert(proj2.Status__c == 'Billed');      
    }
    @isTest static void testCalloutFailure (){
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
        Project__c proj = [Select Id, Status__c from Project__c where ProjectRef__c = '87654321' limit 1];
        Test.startTest();
        proj.Status__c = 'Billable';
        update proj;
        Test.stopTest();
        Project__c proj2 = [Select Id, Status__c from Project__c where ProjectRef__c = '87654321' limit 1];
system.assert(proj2.Status__c != 'Billed');           
    }    
}