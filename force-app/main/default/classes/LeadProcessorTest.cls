@isTest
public class LeadProcessorTest {
    
    @testSetup
    static void TestLeads() { 
        List<Lead> lds = new List<Lead>();
        for (Integer i=0; i<200; i++){
            Lead ld = new Lead(LastName = 'Name '+ i, Company = 'Company '+i);
            lds.add(ld);
        }
        insert lds;
        
    }
    static testmethod void test(){
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
               System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
        }