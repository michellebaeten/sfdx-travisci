({
onBoatSelected : function(component, event, helper) {
        
		var boat = event.getParam('boat');
        alert('BoatSelected '+ boat.Id);

        component.set('v.boat' , boat);
        component.set('v.id' , boat.Id);
var service = component.find("service");
service.reloadRecord();
        
	},
    onBoatReviewAdded : function(component, event, helper) {
    component.find("tabs").set("v.selectedTabId", 'boatreviewtab');
                var BoatReviews = component.find("BoatReviews");
        BoatReviews.refresh();
}
})