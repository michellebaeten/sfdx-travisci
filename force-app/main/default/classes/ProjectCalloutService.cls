global class ProjectCalloutService {
       static Id OppId;
    
    @future(callout=true)
    public static void doCallout(Id oid)
    {
        Opportunity Opp = [Select Id, Name, Account.Name, CloseDate, Amount from Opportunity where Id = :oid];
        String token = ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
        Http http = new Http();
        HttpRequest request = new Httprequest();
        request.setEndpoint('callout:ProjectService');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/json');
        request.setHeader('token', token);
        String body = '{"opportunityId":"' + oid + '", "opportunityName":"' + Opp.Name + '","accountName":"' + Opp.Account.Name + '","closeDate":"' + Opp.CloseDate + '","amount":' + Opp.Amount + '}';
        Request.setBody(body);
        HttpResponse response = Http.send(request);
        if (response.getStatusCode() != 201){
            system.debug('there was an issue');
            Opp.StageName = 'Resubmit Project';
        } else {
            Opp.StageName = 'Submitted Project';
            system.debug(response.getBody());
        }
        Update Opp;
    }

 @InvocableMethod
	public static void postOpportunityToPMS(List<Id> OppIds){
        OppId = OppIds[0];
      ID jobID = System.enqueueJob(new QueueablePMSCall(OppId));
            
    }
global class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{
        Id oId;
        public QueueablePMSCall(Id inOppId){           
            this.oId = inOppId;
        }
 
        public void execute(QueueableContext context)
        {                                  
            ProjectCalloutService.doCallout(oId);
        }
    }
    
}