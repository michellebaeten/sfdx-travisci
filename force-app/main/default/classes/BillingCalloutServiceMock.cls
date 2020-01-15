@isTest
global class BillingCalloutServiceMock implements WebServiceMock{
   global void doInvoke(
   	           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType){
       BillingServiceProxy.billProjectResponse_element resp = new BillingServiceProxy.billProjectResponse_element();
               resp.status = 'OK';
               response.put('response_x', resp);
   }
}