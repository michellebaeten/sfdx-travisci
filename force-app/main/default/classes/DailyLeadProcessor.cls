global class DailyLeadProcessor implements Schedulable{
    
    global void execute(SchedulableContext ctx){
        List<Lead> ldstoupdate = [Select Id, LeadSource from Lead where LeadSource = '' limit 200];
        for (Lead ls : ldstoupdate){
            ls.LeadSource = 'Dreamforce';           
        }update ldstoupdate;
    }

}