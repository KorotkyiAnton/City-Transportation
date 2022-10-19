public class TransportServices {
    public void createStop(String name, String address) {
        BusStop__c newBusStop = new BusStop__c (
            Name = name,
            Address__c = address
        );

        try {
            insert newBusStop;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    //create schedule record
    public void addStopToSchedule(Id busRouteId, Id busStopId, Time timeValue) {
        Schedule__c newSchedule = new Schedule__c(
            BusRoute__c = busRouteId,
            BusStop__c = busStopId,
            Time__c = timeValue
        );

        try {
            insert newSchedule;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    //update schedule with specific time
    public void updateScheduleTimes(List<Schedule__c> scheduleTimes) {
        try {
            update scheduleTimes;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    //delete bus stop and all related schedules
    public void deleteBusStop(Id busStopId) {
        BusStop__c t = new BusStop__c();
        t.Id = busStopId;

        List<BusStop__c> deleteBusStop = new List<BusStop__c>();
        deleteBusStop.add(t);
        List<Schedule__c> deleteSchedule = [SELECT Id FROM Schedule__c WHERE BusStop__c = :busStopId];

        try {
            delete deleteBusStop;
            delete deleteSchedule;
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
}


//TransportServices transportServices = new TransportServices();

//Schedule__c t = new Schedule__c(Id = 'a027Q000001vvt4QAA', Time__c = Time.newInstance(18, 20, 2, 20));
//List<Schedule__c> scheduleTimes = new List<Schedule__c>();
//scheduleTimes.add(t);

//transportServices.createStop('Stop6', 'Address6');
//transportServices.addStopToSchedule('a007Q00000AtvhSQAR', 'a017Q00000dF8hNQAS', Time.newInstance(18, 30, 2, 20));
//transportServices.updateScheduleTimes(scheduleTimes);
//transportServices.deleteBusStop('a017Q00000dF8hNQAS');