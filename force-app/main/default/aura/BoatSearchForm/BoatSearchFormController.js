({
    doInit : function(component, event, helper){
        var isEnabled = $A.get('e.force:createRecord');
        
        if (isEnabled){
       component.set('v.showNewButton', true);            
        }

        helper.loadBoatTypes(component);
    },

    handleChange : function(component, event, helper){
        console.log(component.find("boatTypes").get("v.value"));
        component.set("v.selectedType", component.find("boatTypes").get("v.value"));
    },

    search : function(component, event, helper){
        var selectedType = component.get("v.selectedType");
        console.log("Search button pressed " + selectedType)
    },

    newBoat : function(component) {
		var createRecordEvent = $A.get('e.force:createRecord');
		createRecordEvent.setParams({
			'entityApiName' : 'Boat__c',
			'defaultFieldValues': {
				'Name': component.get('v.selectedType')
			},
		});
		createRecordEvent.fire();
	},
    onFormSubmit : function(component, event, helper){
        var boatTypeId = component.get("v.selectedType");
        console.log("Search button pressed " + boatTypeId);
        var formSubmit = component.getEvent("formsubmit");
        formSubmit.setParams({"formData":
                            {"boatTypeId" : boatTypeId}
        });
        formSubmit.fire();
    },

    handleNewBoatForm: function(component, event, helper){
        console.log("handleNewBoatForm handler called.")
        var boatTypeId = component.get("v.selectedType");

        console.log(boatTypeId);
        var createNewBoat = $A.get("e.force:createRecord");
        createNewBoat.setParams({
            "entityApiName": "Boat__c",
        })
        if(! boatTypeId==""){
            createNewBoat.setParams({
                "defaultFieldValues": {'BoatType__c': boatTypeId}
           })
        }
        createNewBoat.fire();
    },
    //more handlers here
})