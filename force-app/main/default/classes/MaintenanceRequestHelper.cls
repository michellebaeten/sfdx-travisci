public class MaintenanceRequestHelper {
    
  public static void updateWorkOrders(List<Case> oldCases, List<Case> newCases, Map<Id, Case> newMap, Map<Id, Case> oldMap){
 List<Case>newCasestoInsert = new List<Case>();
      List<Id> CaseIDs = new List<Id>();
      Map<Id, Case> Oldcasemap = new Map<Id, Case>();
      List<Work_Part__c> newwps = new List<Work_Part__c>();
      for (Case cas : newCases){
            if (cas.Status == 'Closed' && oldmap.get(cas.Id).Status != 'Closed' && (cas.Type == 'Repair' || cas.Type == 'Routine Maintenance')){
               CaseIDs.add(cas.Id) ;
            }}
          Map<Id, Case> caseWorkOrdermap = new Map<Id, Case>([SELECT Case.Id, Case.Equipment__c, 
                                                              Case.Product__c, Case.ContactId, Case.CaseNumber, 
                                                              Case.Vehicle__c, Case.Date_Due__c, (SELECT Work_Part__c.Id, Work_Part__c.Equipment__c,
                                                                                                 Work_Part__c.Equipment__r.Maintenance_Cycle__c from
                                                                                                 Work_Parts__r) from Case
                                                             where Id in :CaseIDs]);
      for (Case cas : caseWorkOrdermap.values()){
      Case newCase = new Case();
                newCase.Type = 'Routine Maintenance';
                newCase.Subject = 'Routine Maintenance case created for '+ cas.CaseNumber;
                newCase.Vehicle__c = cas.Vehicle__c;
                newCase.Date_Reported__c = date.today();
          		newCase.ContactId = cas.ContactId;
          		newCase.Product__c = cas.Product__c;
          		newCase.Equipment__c = cas.Equipment__c;
                for (Work_Part__c wp : cas.Work_Parts__r){
                    Work_Part__c newwp = new Work_Part__c();
                    newwp.Equipment__c = wp.Equipment__c;
                    newwp.Maintenance_Request__c = cas.Id;
                    if ( newCase.Date_Due__c == null || date.today().addDays(Integer.valueof(wp.Equipment__r.Maintenance_Cycle__c)) < newCase.Date_Due__c) {
                        newCase.Date_Due__c = date.today().addDays(Integer.valueof(wp.Equipment__r.Maintenance_Cycle__c));
                    }
                    newwps.add(newwp);    
                    system.debug(newwp);
                }
//                newCasestoInsert.add(newCase);
          		Oldcasemap.put(cas.Id, newCase);
      }
 
      insert Oldcasemap.values();
      for (Work_Part__c wp : newwps){
          wp.Maintenance_Request__c = Oldcasemap.get(wp.Maintenance_Request__c).Id;
      }
      insert newwps;
    }        
    
}