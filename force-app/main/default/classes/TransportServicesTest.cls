@isTest
public class TransportServicesTest {
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
    static void createStopTest() {
        Test.startTest();        
        List<BusStop__c> busStops = [SELECT Id FROM BusStop__c];
        Test.stopTest();
        
        System.assert(busStops.size() == 3, 'Wrong size of stops list: '+String.valueOf(busStops.size()));
    }
    
    @isTest
    static void addStopToScheduleTest() {
        Test.startTest();        
        List<Schedule__c> schedules = [SELECT Id FROM Schedule__c];
        Test.stopTest();
        
        System.assert(schedules.size() == 3, 'Wrong size of schedules list: '+String.valueOf(schedules.size()));
    }
    
    @isTest
    static void updateScheduleTimesTest() {
        Test.startTest();  
        Integer i = 1;
        List<Schedule__c> schedules = [SELECT Id, Time__c  FROM Schedule__c];
        for(Schedule__c schedule: schedules) {
            schedule.Time__c = Time.newInstance(i, i, 0, 0);  
            i += 1;
        }
        TransportServices.updateScheduleTimes(schedules);
      	schedules = [SELECT Id, Time__c  FROM Schedule__c];
        Test.stopTest();
        
        System.assert(schedules[0].Time__c == Time.newInstance(1, 1, 0, 0), 'Wrong size of schedules list: '+String.valueOf(schedules[0].Time__c));
    }
    
    @isTest
    static void deleteBusStopTest() {
        Test.startTest(); 
        for(BusStop__c busStop: [SELECT Id FROM BusStop__c]) {
            TransportServices.deleteBusStop(busStop.Id);
        }
        List<BusStop__c> busStops = [SELECT Id FROM BusStop__c];
        Test.stopTest();
        
        System.assert(busStops.size() == 0, 'Wrong size of stops list: '+String.valueOf(busStops.size()));
    }
}