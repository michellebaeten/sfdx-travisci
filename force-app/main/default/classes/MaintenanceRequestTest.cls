@isTest
private class MaintenanceRequestTest {
    
    @isTest static void TestcloseMR(){
        Contact newContact = new Contact(LastName = 'Test Contact');
        insert newContact;
        Vehicle__c newvehicle = new Vehicle__c(Name = 'Test Vehicle');
        insert newvehicle;
        Product2 newequip = new Product2(Name = 'Test Equipment' ,Replacement_Part__c = True, Maintenance_Cycle__c = 10);
        insert newequip;

        Case newcase = new Case(Type = 'Routine Maintenance', Subject = 'Test',
                               Vehicle__c = newvehicle.Id,
                               Date_Reported__c = date.today(),
                               ContactId = newContact.Id,
                               Product__c = 'GC1040',
                               Equipment__c = newequip.Id
                              );
        insert newcase;
        Work_Part__c newwp = new Work_Part__c(Equipment__c = newequip.Id, Maintenance_Request__c = newcase.Id);  
        insert newwp;
        Test.startTest();
        newcase.Status = 'Closed';
        newcase.Reason = 'Installation';
        update newcase;
        Test.stopTest();
        List<Case> existingcases = [Select Id, Type, Vehicle__c from Case];
        system.assertEquals(2, existingcases.size());
        system.assertEquals(existingcases[0].Vehicle__c, existingcases[1].Vehicle__c);
        
    }

}