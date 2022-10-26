({
	doInit : function(component, event, helper) {
		helper.setColumns(component);
        helper.getBusRoutes(component, event, helper);
	}
})