/**
 * @name         : BuildingTrigger
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 10-05-2022
**/
trigger BuildingTrigger on Building__c (before insert) {

    BuildingTriggerHandler.checkProductionEngineer(Trigger.new);
}