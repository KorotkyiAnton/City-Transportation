public with sharing class BusRoutesBackController {
	@AuraEnabled(cacheable=true)
    public static List<BusRoute__c> getBusRoutesFromBack() {
        return [SELECT Id, Name, RouteNumber__c, StartTime__c, EndTime__c, TotalStops__c 
                FROM BusRoute__c 
                WHERE TotalStops__c > 0
                ORDER BY Name ASC
               ];
    }
}