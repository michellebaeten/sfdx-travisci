@isTest
private class WarehouseSyncScheduleTest {
	public static String CRON_EXP = '0 0 0 15 3 ?';
    
@isTest    static void testScheduledJob(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());    
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new WarehouseSyncSchedule());
        List<Product2> equipment = [Select Id from Product2];
        system.assertEquals(0, equipment.size());
        Test.stopTest();
         List<Product2> equipment2 = [Select Id from Product2]; 
//        system.assertEquals(2, equipment2.size());
    }
}