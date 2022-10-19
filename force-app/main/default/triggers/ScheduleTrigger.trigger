trigger ScheduleTrigger on Schedule__c (after insert, after update) {
    if(Trigger.isInsert) {
        ScheduleTriggerHandler.onAfterInsert(Trigger.new);
    } else if (Trigger.isUpdate) {
        if(Trigger.old[0].Time__c != Trigger.new[0].Time__c)
        ScheduleTriggerHandler.onAfterUpdate(Trigger.new);
    }
}