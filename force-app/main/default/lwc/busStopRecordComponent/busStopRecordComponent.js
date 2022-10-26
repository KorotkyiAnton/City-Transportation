import { LightningElement, wire, api } from 'lwc';
import getClosestSheduleV1 from '@salesforce/apex/BusStopLayoutController.getClosestSheduleV1';
import getClosestSheduleV2 from '@salesforce/apex/BusStopLayoutController.getClosestSheduleV2';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'Text'},
    { label: 'Time', fieldName: 'Time__c', type: 'date', typeAttributes:{ hour: "2-digit", minute: "2-digit", timeZone: "UTC"}},
    { label: 'Time To Next Stop', fieldName: 'TimeToNextStop__c', type: 'Integer' },
    { label: 'Bus Route', fieldName: 'BusRoute__c', type: 'Id' },
    { label: 'Bus Stop', fieldName: 'BusStop__c', type: 'Id' },
];

export default class BusStopRecordComponent extends LightningElement {
    columns = columns;
    @api recordId;

    @wire(getClosestSheduleV1, {busStopId: '$recordId'}) schedules;
    @wire(getClosestSheduleV2, {busStopId: '$recordId'}) schedulesV2;
}