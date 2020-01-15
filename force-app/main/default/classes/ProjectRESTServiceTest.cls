@isTest
private class ProjectRESTServiceTest {
    @testSetup static void createTestData(){
                Opportunity Opp1 = new Opportunity(Name = 'New Opp1', Type = 'New Project', Amount = 100, 
                                           StageName = 'Submitted Project', CloseDate = date.today());
        insert Opp1;
        Project__c Proj1 = new Project__c(Opportunity__c = Opp1.Id, ProjectRef__c = '12345678', Name = 'New Project1',
                                         Start_Date__c = Date.today(), End_Date__c = Date.today(), Billable_Amount__c = 100,
                                         Status__c = 'Running');
        insert Proj1;
    }
    @isTest static void TestRestServiceInsert(){
        Opportunity Opp1 = [Select Id from Opportunity where Name = 'New Opp1' Limit 1];
        String Outcome = ProjectRESTService.PostProjectData('abcdef', 'Insert New', Opp1.Id, Date.today(), 
                                            Date.today(), 1234, 'Running');
        System.assert(Outcome == 'OK');
    }
    @isTest static void TestRestServiceUpdate(){
        Opportunity Opp1 = [Select Id from Opportunity where Name = 'New Opp1' Limit 1];
        String Outcome = ProjectRESTService.PostProjectData('12345678', 'Insert New', Opp1.Id, Date.today(), 
                                            Date.today(), 1234, 'Running');
        System.assert(Outcome == 'OK');
    } 
    @isTest static void TestRestServicenoOpp(){
        String Outcome = ProjectRESTService.PostProjectData('12345678', 'Insert New', '11111111111', Date.today(), 
                                            Date.today(), 1234, 'Running');
        System.assert(Outcome != 'OK');
    }      
    @isTest static void TestRestServicefailure(){
         Opportunity Opp1 = [Select Id from Opportunity where Name = 'New Opp1' Limit 1];       
        String Outcome = ProjectRESTService.PostProjectData('lkjhgf', 'Insert New', Opp1.Id, Date.today(), 
                                            Date.today(), 1234, 'Failure');
        System.assert(Outcome != 'OK');
    }  
}