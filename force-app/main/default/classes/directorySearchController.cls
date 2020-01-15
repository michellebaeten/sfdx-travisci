/* *************************
  Controller for directorySearch page

************************* */

public class directorySearchController {

    //Page Parameters
    public string action {get; set;}
    
    //Search Parameters
    public string searchString {get; set;}
    public map<string, boolean> selectedServices {get; set;}
    public map<string, boolean> selectedLocations {get; set;}
    
    //Results
    private ApexPages.StandardSetController setController {get; set;} 
    
    public directorySearchController() {
        //Page Parameters
        action = 'home';
        //Search Parameters 
        selectedServices = new map<string, boolean>{};
        selectedLocations = new map<string, boolean>{};
        
        Schema.DescribeFieldResult fieldResult = Account.Services__c.getDescribe();
        list<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                
        for(Schema.PicklistEntry f : ple) {
            selectedServices.put(f.getValue(), false);
        }       
        
        fieldResult = Account.Location__c.getDescribe();
        ple = fieldResult.getPicklistValues();
                
        for(Schema.PicklistEntry f : ple) {
            selectedLocations.put(f.getValue(), false);
        }
    }
    
    public void search() {
        action = 'search';
        
        string searchServices = mapToQueryString(selectedServices);
        list<string> searchLocations = mapToList(selectedLocations);
        
        // Specifies whether to use SOQL or SOSL for search
        boolean isSOSL = false;
        
        string queryString;
        if(searchString == '' || searchString == null) {
            queryString = 'Select Id, Name, Description, BillingStreet, BillingCity, BillingState, BillingPostalCode From Account ';
        } else {
            isSOSL = true;
            queryString = 'FIND \'%'+string.escapeSingleQuotes(searchString)+'%\' IN ALL FIELDS RETURNING Account (Id, Name, Description, BillingStreet, BillingCity, BillingState, BillingPostalCode ';
        }
        
        queryString += 'WHERE Status__c = \'Approved\' ';
        
        if(searchServices != null) {
            queryString += 'AND Services__c INCLUDES ('+searchServices+') ';
        }
        
        if(searchLocations.size() > 0) {
            queryString += 'AND Location__c IN :searchLocations ';
        }

        queryString += 'ORDER BY Name Asc ';
        
        system.debug('&&&&'+queryString);
        if(isSOSL) {
            queryString += ')';
            system.debug('***'+Search.query(queryString)[0]);
            setController = new ApexPages.StandardSetController(Search.query(queryString)[0]);
        } else {
            setController = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        }  
        setController.setPageSize(10);   
    }
    
    public integer getResultSize() {
        return setController.getResultSize();
    }
    
    public void home() {
        action = 'home';
    }

    public list<Account> getResults() {
        return setController.getRecords();
    }

    public void next() {
        setController.next();
    }
    
    public boolean getHasNext() {
        return setController.getHasNext();
    }
    
     public void previous() {
        setController.previous();
    }
    
    public boolean getHasPrevious() {
        return setController.getHasPrevious();
    }


    private string mapToQueryString(map<string, boolean> selectedMap) {    
        string returnString;
     
        for(string key : selectedMap.keySet()) {
            if(selectedMap.get(key)) {
                if(returnString == null) {
                    returnString = '\''+key+'\'';
                } else {
                    returnString += ',\''+key+'\'';
                }
            }
        }       
        return returnString;
    }

    private list<string> mapTolist(map<string, boolean> selectedMap) {
        
        list<string> returnList = new list<string>{};
        
        for(string key : selectedMap.keySet()) {
            if(selectedMap.get(key)) returnList.add(key);  
        }
        
        return returnList;
    }  
}