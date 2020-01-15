public class OnLoadController {
	    public String Page {get; set;}
	    public String OpenPageURL {get; set;}
        String instId = Label.worldpayID;  
	    public void OnLoadController()

	    {
	        Page = '' ;
	        OpenPageURL = '' ;
	    }
	    public PageReference redirect()

	    {
	        if(Page == 'google')
	        {
	            OpenPageURL = 'https://free-12415f14c3a-124e539428a-130e60e552a.secure.force.com/' ;
	        }
	        if(Page == 'blog')
	        {
	            OpenPageURL = 'https://secure-test.worldpay.com/wcc/purchase?instId=' + instId + '&cartId=WorldPay+Test&amount=40.00&currency=GBP&desc=WorldPay+Test&testMode=100' ;
	        }
	        return null;
	    }
	 
	}