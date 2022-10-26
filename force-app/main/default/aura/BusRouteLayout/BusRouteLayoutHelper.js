({
    getBusRoutes : function(component, event, helper) {
        var action = component.get("c.getBusRoutesFromBack");
        
        action.setCallback(this, function(response) {
            component.set("v.routes", response.getReturnValue());
        });
        
        $A.enqueueAction(action);
    },
    
    setColumns : function(component) {
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'Auto Number'},
            {label: 'Route Number', fieldName: 'RouteNumber__c', type: 'text'},
            {label: 'Start Time', fieldName: 'StartTime__c', type: 'date', typeAttributes:{ hour: "2-digit", minute: "2-digit", timeZone: "UTC"}},
            {label: 'End Time', fieldName: 'EndTime__c', type: 'date', typeAttributes:{ hour: "2-digit", minute: "2-digit", timeZone: "UTC"}},
            {label: 'Total Stops', fieldName: 'TotalStops__c', type: 'Integer'}
        ]);
    }
})