@isTest
private class ProjectCalloutServiceTest {
    @testSetup static void createData(){
        Opportunity Opp1 = new Opportunity(Name = 'New Opp1', Type = 'New Project', Amount = 100, 
                                           StageName = 'Submitted Project', CloseDate = date.today());
        insert Opp1;
        Opportunity Opp2 = new Opportunity(Name = 'New Opp2', Type = 'New Project', Amount = 100, 
                                           StageName = 'Resubmit Project', CloseDate = date.today());
        insert Opp2;
        ServiceTokens__c token = new ServiceTokens__c();
        token.Name = 'ProjectServiceToken';
        token.Token__c = 'kljhsldkgjlasglkjlkjsdg';
        insert token;        
    }
    @isTest static void testPostCalloutSucccess(){
        Opportunity Opp1 = [Select Id from Opportunity where Name = 'New Opp1' limit 1];
        List<id> oppids = new List<Id>();
        oppids.add(Opp1.Id);
    Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Test.startTest();
    ProjectCalloutService.postOpportunityToPMS(oppids);
        Test.stopTest();
        Opp1 = [Select StageName from Opportunity where id = :Opp1.Id];
        system.assert(Opp1.StageName == 'Submitted Project');
    }
    @isTest static void testPostCalloutFailure(){
        Opportunity Opp2 = [Select Id from Opportunity where Name = 'New Opp2' limit 1];
        List<id> oppids = new List<Id>();
        oppids.add(Opp2.Id);
    Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Test.startTest();
    ProjectCalloutService.postOpportunityToPMS(oppids);
        Test.stopTest();
        Opp2 = [Select StageName from Opportunity where id = :Opp2.Id];
        system.assert(Opp2.StageName == 'Resubmit Project');
    }    
}