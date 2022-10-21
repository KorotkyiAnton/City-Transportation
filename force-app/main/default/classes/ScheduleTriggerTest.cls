@isTest
private class ScheduleTriggerTest {
    @testSetup
    static void dataSetup() {
        BusRoute__c newBusRoute = new BusRoute__c(
            RouteNumber__c = '111D',
            StartTime__c = Time.newInstance(0, 0, 0, 0),
            EndTime__c = Time.newInstance(0, 0, 0, 0)
        );
        insert newBusRoute;
        
        TransportServices.createStop('Stop6', 'Address6');
        TransportServices.createStop('Stop7', 'Address7');
        TransportServices.createStop('Stop8', 'Address8');
        
        Integer i = 1;
        for(BusStop__c busStop: [SELECT Id FROM BusStop__c]) {
            TransportServices.addStopToSchedule(newBusRoute.Id, busStop.Id, Time.newInstance(i, 0, 0, 0));
            i += 1;
        }
    }
    
    @isTest
    static void onAfterInsertUpdateStartEndTimeTest() {
        Test.startTest();        
        List<BusRoute__c> busRoute = [SELECT StartTime__c, EndTime__c FROM BusRoute__c];
        Test.stopTest();
        
        System.assert(busRoute[0].StartTime__c == Time.newInstance(1, 0, 0, 0) && busRoute[0].EndTime__c == Time.newInstance(3, 0, 0, 0), 'Wrong start time: '+String.valueOf(busRoute[0].StartTime__c));
    }
    
    @isTest
    static void onAfterInsertUpdateTimeToNextStopTest() {
        Test.startTest();        
        List<Schedule__c> schedules = [SELECT TimeToNextStop__c FROM Schedule__c];
        Test.stopTest();
        
        System.assert(schedules[0].TimeToNextStop__c == 60, 'Wrong start time: '+String.valueOf(schedules[0].TimeToNextStop__c));
    }
}