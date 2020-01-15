({
search: function(component, event, helper){
        console.log("BSRController: search called");
        var params = event.getParam('arguments');
        console.log("boatTypeId extracted: " + params.boatTypeId);
        component.set("v.boatTypeId", params.boatTypeId);
        helper.onSearch(component);
        return "search complete.";
    },
        doSearch : function(component, event, helper) {
        component.get("v.boatTypeId");
        helper.onSearch(component, event, helper);
    },
    onBoatSelect : function(component, event, helper) {
    	var boatId = event.getParam("boatId");
        console.log(boatId);
        component.set("v.selectedBoatId",boatId);
    }
    
})