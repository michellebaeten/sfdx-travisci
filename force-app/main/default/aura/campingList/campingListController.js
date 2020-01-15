({
     doInit : function(component, event, helper){
        var getCampingItemListingAction = component.get('c.getItems');
        getCampingItemListingAction.setCallback(this, function(response){
            var respState = response.getState();
            if(respState == 'SUCCESS'){
                var vItems = component.get('v.items');
                vItems = response.getReturnValue();
                component.set('v.items', vItems);
            }
        });
        $A.enqueueAction(getCampingItemListingAction);
    },
    
    
    clickCreateItem: function(component, event, helper) {
        var validItem = component.find('campinglist').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validExpense){
            // Create the new expense
            var Item = component.get("v.newItem");
            console.log("Create Item: " + JSON.stringify(newItem));
            var itemList = component.get("v.items");
             var newItem = JSON.parse(JSON.stringify(Item));
             itemList.push(newItem);
         component.set("v.items", itemList);
         component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                    'Price__c': 0,'Packed__c': false });
        }
    },
        createItem: function(component, event, helper) {    
        if(helper.validateItemForm(component)){
            // Create the new item
            var newItem = component.get("v.newItem");
            helper.createItem(component, newItem);
        }
    },
        handleAddItem : function (component,event,helper){
	var action = component.get("c.saveItem");
        var Item = event.getParam("item");
        var lstItems = component.get("v.items");

        lstItems.push(Item);
        component.set("v.items",lstItems);
        console.log("After:"+lstItems);
        action.setParams({"CampingItem":Item});
        action.setCallback(this,function(response){
            var state = response.getState();
                
            if (component.isValid() && state === "SUCCESS") {
                //let the magic happen
            }
         });
        $A.enqueueAction(action);   
     }

})