public class ScheduleTriggerHandler {
    public static void onAfterInsert(List<Schedule__c> schedules) {
        Set<Id> busRouteIds = new Set<Id>();
        for(Schedule__c schedule: schedules) {
            busRouteIds.add(schedule.BusRoute__c);
        }

        List<Schedule__c> allTimeOfRoute = [SELECT Id, BusRoute__c, Time__c FROM Schedule__c WHERE BusRoute__c IN :busRouteIds ORDER BY BusRoute__c, Time__c ASC];
        List<SObject> objectsToUpdate = new List<SObject>();
        List<Schedule__c> sliceAllTimeOfROute = new List<Schedule__c>();
           
        for(Schedule__c timeRoute: allTimeOfRoute) {
            if((allTimeOfRoute.indexOf(timeRoute)==allTimeOfRoute.size()-1) || (allTimeOfRoute.indexOf(timeRoute)+1 < allTimeOfRoute.size() && timeRoute.BusRoute__c != allTimeOfRoute[allTimeOfRoute.indexOf(timeRoute)+1].BusRoute__c)) {
                Integer TimeToNextStop = schedules[0].Time__c.hour()*60 + schedules[0].Time__c.minute() -  sliceAllTimeOfROute[sliceAllTimeOfROute.size()-1].Time__c.hour()*60 -  sliceAllTimeOfROute[sliceAllTimeOfROute.size()-1].Time__c.minute();
                
                objectsToUpdate.add(new BusRoute__c(
                    Id = sliceAllTimeOfROute[0].BusRoute__c,
                    StartTime__c = sliceAllTimeOfROute[0].Time__c,
                    EndTime__c = schedules[0].Time__c
                ));
                
                System.debug(TimeToNextStop);
                objectsToUpdate.add(new Schedule__c (
                Id = sliceAllTimeOfRoute[sliceAllTimeOfRoute.size()-1].Id,
                TimeToNextStop__c = TimeToNextStop
            ));
                
                sliceAllTimeOfROute.clear();
            } else {
                sliceAllTimeOfROute.add(timeRoute);
            }
        }

        try {
            update objectsToUpdate;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
}