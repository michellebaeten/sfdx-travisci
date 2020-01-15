public with sharing class WarehouseCalloutService {
    

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        system.debug('starting Callout');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response = ' + response);
        if (response.getStatusCode() == 200){
     List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());   
            List<Product2> upsertprod = new List<Product2>();
            for (Object ob : results){
                Map<String, Object> equipment = (Map<String, Object>)ob;
                Product2 newprod = new Product2(Warehouse_SKU__c = (String)equipment.get('sku'), 
                                               Current_Inventory__c = (Decimal)equipment.get('quantity'),
                                               Replacement_Part__c = True, 
                                               Cost__c = (Decimal)equipment.get('cost'),
                                               Lifespan_Months__c = (Decimal)equipment.get('lifespan'),
                                               Maintenance_Cycle__c = (Decimal)equipment.get('maintenanceperiod'),
                                                Name = (String)equipment.get('name')
                                               );
                upsertprod.add(newprod);
            }
            upsert upsertprod Warehouse_SKU__c;
        }
        
    }

}