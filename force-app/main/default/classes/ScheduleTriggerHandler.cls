public class ScheduleTriggerHandler {
    public static void updateBusRouteTime(List<Schedule__c> schedules) {
        Set<Id> busRouteIds = new Set<Id>();
        for(Schedule__c schedule: schedules) {
            busRouteIds.add(schedule.BusRoute__c);
        }
        
        List<Schedule__c> allTimeOfRoute = [SELECT Id, BusRoute__c, Time__c FROM Schedule__c WHERE BusRoute__c IN :busRouteIds ORDER BY BusRoute__c, Time__c ASC];
        //List<Bus_Route__c> busRouteList = [
              //  SELECT Start_Time__c, End_Time__c, 
              //  (SELECT Time__c, TimeToNextStop__c FROM Schedules__r ORDER BY Time__c ASC) 
              //  FROM Bus_Route__c 
               // WHERE Id 
               // IN: idsSet];
        List<SObject> objectsToUpdate = new List<SObject>();
        List<Schedule__c> sliceAllTimeOfROute = new List<Schedule__c>();
        
        for(Schedule__c timeRoute: allTimeOfRoute) {
            sliceAllTimeOfROute.add(timeRoute);
            
            if((allTimeOfRoute.indexOf(timeRoute)==allTimeOfRoute.size()-1) || (allTimeOfRoute.indexOf(timeRoute)+1 < allTimeOfRoute.size() && timeRoute.BusRoute__c != allTimeOfRoute[allTimeOfRoute.indexOf(timeRoute)+1].BusRoute__c)) {
                if(allTimeOfRoute.size() > 1){
                    for(Schedule__c timeRouteS: sliceAllTimeOfROute) {
                        if (sliceAllTimeOfROute.indexOf(timeRoute) == 0) {
                            Schedule__c NextScheduleItem = sliceAllTimeOfROute[sliceAllTimeOfROute.indexOf(timeRoute)+1];
                            timeRouteS.TimeToNextStop__c = NextScheduleItem.Time__c.hour()*60 + NextScheduleItem.Time__c.minute() -  timeRouteS.Time__c.hour()*60 -  timeRouteS.Time__c.minute();
                        } else if (allTimeOfRoute.indexOf(timeRouteS) == allTimeOfRoute.size()-1) {
                            timeRouteS.TimeToNextStop__c = 0;
                        } else {
                            Schedule__c NextScheduleItem = sliceAllTimeOfROute[sliceAllTimeOfROute.indexOf(timeRouteS)+1];
                            Schedule__c PrevScheduleItem = sliceAllTimeOfROute[sliceAllTimeOfROute.indexOf(timeRouteS)+1];
                            PrevScheduleItem.TimeToNextStop__c = timeRouteS.Time__c.hour()*60 + timeRouteS.Time__c.minute() -  PrevScheduleItem.Time__c.hour()*60 -  PrevScheduleItem.Time__c.minute();
                            timeRouteS.TimeToNextStop__c = NextScheduleItem.Time__c.hour()*60 + NextScheduleItem.Time__c.minute() -  timeRouteS.Time__c.hour()*60 -  timeRouteS.Time__c.minute();
                        }
                    }
                }
                
                objectsToUpdate.add(new BusRoute__c(
                    Id = sliceAllTimeOfROute[0].BusRoute__c,
                    StartTime__c = sliceAllTimeOfROute[0].Time__c,
                    EndTime__c = sliceAllTimeOfROute[sliceAllTimeOfROute.size()-1].Time__c
                ));
                
                if(allTimeOfRoute.size() > 1){
                    Integer TimeToNextStop = schedules[0].Time__c.hour()*60 + schedules[0].Time__c.minute() -  sliceAllTimeOfROute[sliceAllTimeOfROute.size()-2].Time__c.hour()*60 -  sliceAllTimeOfROute[sliceAllTimeOfROute.size()-2].Time__c.minute();
                    objectsToUpdate.add(new Schedule__c (
                        Id = sliceAllTimeOfRoute[sliceAllTimeOfRoute.size()-2].Id,
                        TimeToNextStop__c = TimeToNextStop
                    ));
                }
                
                sliceAllTimeOfROute.clear();
            }
        }
        
        try { 
            update objectsToUpdate;
            update allTimeOfRoute;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
}