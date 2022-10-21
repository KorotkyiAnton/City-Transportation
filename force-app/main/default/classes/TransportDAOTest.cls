@isTest
public class TransportDAOTest { 
    @testSetup
    static void dataSetup() {
        BusRoute__c newBusRoute1 = new BusRoute__c(
            RouteNumber__c = '111D',
            StartTime__c = Time.newInstance(0, 0, 0, 0),
            EndTime__c = Time.newInstance(0, 0, 0, 0)
        );
        BusRoute__c newBusRoute2 = new BusRoute__c(
            RouteNumber__c = '112D',
            StartTime__c = Time.newInstance(0, 0, 0, 0),
            EndTime__c = Time.newInstance(0, 0, 0, 0)
        );
        insert newBusRoute1;
        insert newBusRoute2;
        
        TransportServices.createStop('Stop6', 'Address6');
        TransportServices.createStop('Stop7', 'Address7');
        TransportServices.createStop('Stop8', 'Address8');
        
        Integer i = 1;
        for(BusStop__c busStop: [SELECT Id FROM BusStop__c]) {
            TransportServices.addStopToSchedule(newBusRoute1.Id, busStop.Id, Time.newInstance(i, 0, 0, 0));
            TransportServices.addStopToSchedule(newBusRoute2.Id, busStop.Id, Time.newInstance(i, 2*i, 0, 0));
            i += 1;
        }
    }
    
    @isTest
    static void getNumberOfStopsTest() {
        Test.startTest(); 
        Id busStopId = [SELECT Id FROM BusRoute__c][0].Id;
        Test.stopTest();
        
        System.assert(TransportDAO.getNumberOfStops(busStopId) == 3, 'Wrong number of stops for bus route'+String.valueOf(TransportDAO.getNumberOfStops(busStopId)));
    }
    
    @isTest
    static void getLongestByTimeRouteIdTest() {
        Test.startTest();        
        Id longestByTimeRouteId = TransportDAO.getLongestByTimeRouteId();
        Test.stopTest();
        
        System.assert(longestByTimeRouteId == [SELECT Id FROM BusRoute__c][1].Id, 'Its not a longest route'+String.valueOf(longestByTimeRouteId));
    }
    
    @isTest
    static void getSchedulesTest() {
        Test.startTest();        
        List<Schedule__c> schedules1 = TransportDAO.getSchedules(1, 0);
        List<Schedule__c> schedules2 = TransportDAO.getSchedules(2, 1);
        List<Schedule__c> schedules3 = TransportDAO.getSchedules(3, 0);
        Test.stopTest();
        
        System.assert(schedules1.size() == 1, 'Wrong size of schedules list1'+String.valueOf(schedules1));
        System.assert(schedules2.size() == 2, 'Wrong size of schedules list2'+String.valueOf(schedules2));
        System.assert(schedules3.size() == 3, 'Wrong size of schedules list3'+String.valueOf(schedules3));
    }
    
    @isTest
    static void getBusStopsByIdsTest() {
        Test.startTest(); 
        Set<Id> bustStopsSet = new Set<Id>();
        for(BusStop__c busStop: [SELECT Id FROM BusStop__c]) {
            bustStopsSet.add(busStop.Id);
        }
        List<BusStop__c> busStops = TransportDAO.getBusStopsByIds(bustStopsSet);
        Test.stopTest();
        
        System.assert(busStops.size() == 3, 'Wrong size of stops list'+String.valueOf(busStops));
    }
    
    @isTest
    static void getBusRoutesTest() {
        Test.startTest();        
        Set<Id> bustStopsSet = new Set<Id>();
        for(BusStop__c busStop: [SELECT Id FROM BusStop__c]) {
            bustStopsSet.add(busStop.Id);
        }
        List<BusRoute__c> busRoutes = TransportDAO.getBusRoutes(bustStopsSet);
        Test.stopTest();
        
        System.assert(busRoutes.size() == 2, 'Wrong size of routes list'+String.valueOf(busRoutes));
    }
    
    @isTest
    static void getBusRoutesWithMinDurationTest() {
        Test.startTest();        
        Map<Id, String> busRoutesWithMinDuration1 = TransportDAO.getBusRoutesWithMinDuration(1);
        Map<Id, String> busRoutesWithMinDuration2 = TransportDAO.getBusRoutesWithMinDuration(2);
        Test.stopTest();
        
        System.assert(busRoutesWithMinDuration1.size() == 1, 'Wrong size of routes list1'+String.valueOf(busRoutesWithMinDuration1));
        System.assert(busRoutesWithMinDuration2.size() == 2, 'Wrong size of routes list2'+String.valueOf(busRoutesWithMinDuration2));
    }
    
    @isTest
    static void getBusRoutesWithMaxDurationTest() {
        Test.startTest();        
        Map<Id, String> busRoutesWithMaxDuration1 = TransportDAO.getBusRoutesWithMaxDuration(1);
        Map<Id, String> busRoutesWithMaxDuration2 = TransportDAO.getBusRoutesWithMaxDuration(2);
        Test.stopTest();
        
        System.assert(busRoutesWithMaxDuration1.size() == 1, 'Wrong size of routes list1'+String.valueOf(busRoutesWithMaxDuration1));
        System.assert(busRoutesWithMaxDuration2.size() == 2, 'Wrong size of routes list2'+String.valueOf(busRoutesWithMaxDuration2));
    }
}