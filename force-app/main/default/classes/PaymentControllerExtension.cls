public class PaymentControllerExtension {
	    public String Page {get; set;}
	    public String OpenPageURL {get; set;}    
        String instId = Label.worldpayID; 
    private final Payment__c paym;
 	    public PaymentControllerExtension(ApexPages.StandardController stdController) {
	        this.paym = (Payment__c)stdController.getRecord();

	    }
       // public String amount = String.valueOf(paym.Payment_Amount__c);    
	    public PageReference redirect()

	    {
	        if(Page == 'pay')
	        {
	            OpenPageURL = 'https://secure-test.worldpay.com/wcc/purchase?instId=' + instId + '&cartId='+ paym.Name +'&amount=' + String.valueOf(paym.Payment_Amount__c) + '&currency=GBP&desc=Broker+Test&testMode=100' ;
	        	system.debug(OpenPageURL);
            }
	        return null;
	    }    
}