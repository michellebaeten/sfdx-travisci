trigger MaintenanceRequest on Case (before update, after update) {
            if(Trigger.isUpdate && Trigger.isBefore){
                MaintenanceRequestHelper.updateWorkOrders(Trigger.old, Trigger.New, Trigger.newMap, Trigger.oldMap);}
    // call MaintenanceRequestHelper.updateWorkOrders  
}