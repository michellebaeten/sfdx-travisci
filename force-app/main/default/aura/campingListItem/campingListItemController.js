({
    packItem: function(component, event, helper) {
        var a = component.get("v.item",true);
 		a.Packed__c = true;
 		component.set("v.item",a);
        var disabled = True;
        component.set("v.disabled", disabled);
    }
		
	
})