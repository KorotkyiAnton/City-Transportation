public class TimeUtils {
    
    public static Time calculateMinimumTime(Time[] timesList) {
        timesList.sort();
        return timesList.get(0);
    }
    
    public static Time calculateMaximumTime(Time[] timesList) {
        timesList.sort();
        return timesList.get(timesList.size()-1);
    }
}

// TimeUtils timeUtils = new TimeUtils(); 
// List<Time> test = new List<Time>();
// test.add(Time.newInstance(18, 30, 2, 20)); 
// test.add(Time.newInstance(12, 30, 2, 20));
// test.add(Time.newInstance(10, 30, 2, 20));
// test.add(Time.newInstance(11, 30, 2, 20));
// System.debug(timeUtils.calculateMinimumTime(test));
// System.debug(timeUtils.calculateMaximumTime(test));