public class BillingCalloutService {
    public static void callBillingService(List<Project__c> projs, Map<Id, Project__c> oldprojs){
        for (Project__c proj : projs){
            if (proj.Status__c == 'Billable' && oldprojs.get(proj.Id).Status__c != 'Billable'){
                makeCallout(proj.ProjectRef__c, proj.Billable_Amount__c);
            }
        }
    }
    @future(callout=true)
    public static void makeCallout(String ProjectRef, Decimal Amount){
        ServiceCredentials__c credentials = ServiceCredentials__c.getValues('BillingServiceCredential');
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.username = credentials.Username__c;
        project.password = credentials.Password__c;
        project.projectRef = ProjectRef;
        project.billAmount = Amount;
        BillingServiceProxy.InvoicesPortSoap11 invoices = new BillingServiceProxy.InvoicesPortSoap11();
        String response = invoices.billProject(project);
        if (response == 'OK'){
            Project__c proj = [Select Id, Status__c from Project__c where ProjectRef__c = :ProjectRef Limit 1];
            proj.Status__c = 'Billed';
            update proj;
        }
    }
}