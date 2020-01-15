@RestResource(urlMapping='/project/*')
global with sharing class ProjectRESTService {
    @HttpPost
    global static String postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate, 
                                            Date EndDate, Double Amount, String Status){
     List<Opportunity> Opps = [Select Id, DeliveryInstallationStatus__c from Opportunity where Id = :OpportunityId];
                                                 String message = 'OK';                                               
                                                if (Opps.size() > 0){                                          
Savepoint savepoint = Database.setSavepoint();

                                                Try{                                                
     Project__c proj = new Project__c(Name = ProjectName, Billable_Amount__c = Amount, End_Date__c = EndDate, Opportunity__c = OpportunityId,
                                     ProjectRef__c = ProjectRef, Start_Date__c = StartDate, Status__c = Status);
     

     Opps[0].DeliveryInstallationStatus__c = 'In Progress';
                                                update Opps;
                                             upsert proj ProjectRef__c;       
                                                } catch (Exception ex) {
                                                    Database.rollback(savepoint);
                                                    message = ex.getMessage();
                                                }
                                                return message;
                                                }
                                            message = 'No Opp found';
                                            return message;}
}