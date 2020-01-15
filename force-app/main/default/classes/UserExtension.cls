public with sharing class UserExtension {

public UserExtension (ApexPages.StandardController c) {
      controller = c;
      this.user = (User)c.getRecord();
      isActionSuccessful = false;
  }

ApexPages.StandardController controller;
public string newPassword{get; set;}
public User user{get;set;}
public boolean isActionSuccessful {get;set;}

public PageReference setPassword() {
        string results = '';
        ApexPages.Message myMsg;
            
        try {
            System.setPassword(user.id,newPassword); 
            results = 'Users password updated successfully.';
            isActionSuccessful = true;
        ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, results));        
        } catch (Exception e) {      
            results = e.getMessage();
        ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Error: ' + results));            
        }       
        
        PageReference p = Page.setpassword;
        return p;         
    }    
}