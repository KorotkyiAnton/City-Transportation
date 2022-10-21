public class ScheduleTriggerTestService {
    public static void onAfterInsert(List<Schedule__c> schedules) {
        ScheduleTriggerHandler.updateBusRouteTime(schedules);
    }
    
    public static void onAfterUpdate(List<Schedule__c> schedulesOld, List<Schedule__c> schedulesNew) {
        List<Schedule__c> schedulesToUpdate = new List<Schedule__c>();
        for(Schedule__c schedule: schedulesNew) {
            if(schedulesOld[schedulesNew.indexOf(schedule)].Time__c != schedule.Time__c) {
                schedulesToUpdate.add(schedule);
            }
        }
        	
        ScheduleTriggerHandler.updateBusRouteTime(schedulesToUpdate);
    }
}