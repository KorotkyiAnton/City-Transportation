public class ScheduleTriggerTestService {
    public static void onAfterInsert(List<Schedule__c> schedules) {
        ScheduleTriggerHandler.updateBusRouteTime(schedules);
    }
    
    public static void onAfterUpdate(Map<Id, Schedule__c> schedulesOld, List<Schedule__c> schedulesNew) {
        List<Schedule__c> schedulesToUpdate = new List<Schedule__c>();
        for(Schedule__c schedule: schedulesNew) {
            if (schedule.Time__c != schedulesOld.get(schedule.Id).Time__c) {
                schedulesToUpdate.add(schedule);
            }
        }
        	
        ScheduleTriggerHandler.updateBusRouteTime(schedulesToUpdate);
    }
}