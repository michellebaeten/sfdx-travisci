({
    onBoatClick : function(component, event, helper) {
        var cmpEvent = component.getEvent("BoatSelect");
        //var boatId = component.get("v.boat.Id");
        var boatId = event.getSource().get("v.name");
        cmpEvent.setParams({
            "boatId" : boatId
        });
        cmpEvent.fire();
    var boatselected = component.get("v.boat");
var boatSelectedEvent = $A.get("e.c:BoatSelected");
boatSelectedEvent.setParams({ "boatselected" : boatselected });
console.log("Firing BoatSelected Event");
boatSelectedEvent.fire();
        
         var lat = boat.Geolocation__Latitude__s;
        var long = boat.Geolocation__Longitude__s;
        var label = boat.Name;
        var sObjectId;
        var PlotMapMarker = $A.get("e.c:PlotMapMarker");
        PlotMapMarker.setParams({
            "lat"   : lat,
            "long"  : long,
            "label" : label,
            "SObjectId" : boat.Id
});
              plotMapMarkerAppEvent.fire();  
                                }
})