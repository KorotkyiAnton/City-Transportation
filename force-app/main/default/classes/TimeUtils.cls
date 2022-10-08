public class TimeUtils {

    public Time calculateMinimumTime(BusRoute__c[] timesList) {
        timesList.sort();
        return timesList.get(0).StartTime__c;
    }

    public Time calculateMaximumTime(BusRoute__c[] timesList) {
        timesList.sort();
        return timesList.get(timesList.size()-1).StartTime__c;
    }
}
