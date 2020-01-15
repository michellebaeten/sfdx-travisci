@isTest
private class WarehouseCalloutServiceTest {
    @isTest static void testCallout(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
        List<Product2> newprods = [Select Id, Warehouse_SKU__c, Current_Inventory__c, Name from Product2];
        system.assertEquals(2, newprods.size());
        system.assert(newprods[0].Current_Inventory__c == 1234);
    }
  // implement your mock callout test here
}