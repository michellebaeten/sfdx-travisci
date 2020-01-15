@isTest
private class DailyLeadProcessorTest {
    
        public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob(){
        List<Lead> leadstoinsert = new List<Lead>();
        for (Integer i = 0; i < 200; i++){
            leadstoinsert.add(new Lead(LastName = 'Test Lead', Company ='Test Company'));
        }
        insert leadstoinsert;
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        system.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }

}