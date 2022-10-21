trigger ScheduleTrigger on Schedule__c (after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            ScheduleTriggerTestService.onAfterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            ScheduleTriggerTestService.onAfterUpdate(Trigger.old, Trigger.new);
        }
    }
}