trigger ScheduleTrigger on Schedule__c (after insert) {
    ScheduleTriggerHandler.onAfterInsert(Trigger.new);
}