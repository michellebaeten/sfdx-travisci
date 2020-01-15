@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
//k
        @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String AccountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/',request.requestURI.lastIndexOf('/') - 1)+1, request.requestURI.lastIndexOf('/'));
        system.debug(AccountId);
        Account result =  [SELECT Id, Name, (Select Id, Name from Contacts)
                        FROM Account
                        WHERE Id = :AccountId];
        return result;
    }
}