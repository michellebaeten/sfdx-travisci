global class LeadProcessor implements Database.Batchable<sObject>{
   global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead ' 
        );    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> lds = new List<Lead>();
        for (Lead ld : records){
            ld.LeadSource = 'Dreamforce';
            lds.add(ld);
        }update lds;

    }   

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }

}