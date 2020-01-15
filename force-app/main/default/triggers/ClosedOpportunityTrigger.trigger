trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    List<Task> newtasks = new List<Task>();
    for (Opportunity opp : Trigger.new){
        if (opp.StageName == 'Closed Won'){
            Task newtask = new Task(whatId = opp.Id, Subject = 'Follow Up Test Task');
            newtasks.add(newtask);
        }
    }
    insert newtasks;

}