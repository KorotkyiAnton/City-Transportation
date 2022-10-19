public class TransportDAO {
    public Integer getNumberOfStops(Id busRouteId) {
        return (Integer) [SELECT COUNT(BusStop__c)BusStop, BusRoute__c
        FROM Schedule__c 
        WHERE BusRoute__c = :busRouteId 
        GROUP BY BusRoute__c][0].get('BusStop');
    }

    public Id getLongestByTimeRouteId() {
        return [SELECT Id FROM BusRoute__C ORDER BY DurationInMinutes__c DESC LIMIT 1].Id;
    }
    
    public List<Schedule__c> getSchedules(Integer lim, Integer offset) {
        return [SELECT Name, BusRoute__c, BusStop__c, Time__c, TimeToNextStop__c 
        FROM Schedule__c LIMIT :lim OFFSET :offset];
    }
    
    public List<BusStop__c>  getBusStopsByIds(Set<Id> busStops) {
        return [SELECT Name, Address__c FROM BusStop__c WHERE Id IN :busStops];
    }
    
    public List<BusRoute__c> getBusRoutes(Set<Id> bustStops) {
        return [SELECT Name, RouteNumber__c FROM BusRoute__c WHERE Id IN (SELECT BusRoute__c FROM Schedule__c WHERE BusStop__c IN :bustStops)];
    }

    public Map<Id, String> getBusRoutesWithMinDuration(Integer lim) {
        Map<Id, String> routes = new Map<Id, String>();

        for(BusRoute__c route: [SELECT RouteNumber__c FROM BusRoute__c ORDER BY DurationInMinutes__c ASC LIMIT :lim]) {
            routes.put(route.Id, route.RouteNumber__c);
        }

        return routes;
    }

    public Map<Id, String> getBusRoutesWithMaxDuration(Integer lim) {
        Map<Id, String> routes = new Map<Id, String>();

        for(BusRoute__c route: [SELECT RouteNumber__c FROM BusRoute__c ORDER BY DurationInMinutes__c DESC LIMIT :lim]) {
            routes.put(route.Id, route.RouteNumber__c);
        }

        return routes;
    }
}


// TransportDAO transportObj = new TransportDAO();
// Set<Id> bustStops = new Set<Id>();
// bustStops.add('a017Q000018uwBqQAI');
// bustStops.add('a017Q000018uwC1QAI');

// System.debug(transportObj.getNumberOfStops('a007Q00000AtvQnQAJ'));
// System.debug(transportObj.getLongestByTimeRouteId());
// System.debug(transportObj.getSchedules(1, 2));
// System.debug(transportObj.getBusStopsByIds(bustStops));
// System.debug(transportObj.getBusRoutes(bustStops));
// System.debug(transportObj.getBusRoutesWithMinDuration(3));
// System.debug(transportObj.getBusRoutesWithMaxDuration(3));