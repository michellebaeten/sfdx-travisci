({
    doInit : function(component, event, helper) {
        helper.onInit(component,event);
    },
onSave : function(component, event, helper){
    	component.set("v.boatReview.Boat__c",component.get("v.boat.Id"));

//        component.find("service").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {

               var cmpEvent = component.getEvent("BoatreviewAdded");
		       cmpEvent.fire();

               //Attempt at trying an Application event instead
		       //var cmpEvent = $A.get("e.c:BoatReviewAdded");
		       //cmpEvent.fire();


var resultsToast = $A.get("e.force:showToast");
                  if ($A.util.isUndefined(resultsToast)){
                  	alert('Review Saved successfully.');
                  }else{
                      resultsToast.setParams({
                        "title": "Saved",
                        "message": "Review Saved successfully."
                    });
				resultsToast.fire();
                  }
		
            }},
        onRecordUpdated : function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            var changedFields = eventParams.changedFields;
            var saveResultsToast = $A.get("e.force:showToast");
                if(saveResultsToast!='undefined')
                {
                    saveResultsToast.setParams({
                        "title": "Saved",
                        "message": "Boat Review Saved"
                    });
                    saveResultsToast.fire(); 
                }
                else
                {
                    alert('Boat Review Saved');
                }
        }
    }
})