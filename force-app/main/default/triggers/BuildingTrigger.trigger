/**
 * @name         : BuildingTrigger
 * @author       : Thomas BOYER
 * @modified by  : Thomas BOYER
 * @modified on  : 10-05-2022
**/
trigger BuildingTrigger on Building__c (before insert) {

    BuildingTriggerHandler.checkProductionEngineer(Trigger.new);
}