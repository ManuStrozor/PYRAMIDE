/**
 * @name         : BuildingTriggerHandler
 * @author       : Thomas BOYER
 * @modified by  : Thomas BOYER
 * @modified on  : 10-05-2022
**/
public class BuildingTriggerHandler {

    /**
    * @name checkProductionEngineer
    * @description Check if production engineer exists & attach one to building if not
    * @author Thomas BOYER | 10-05-2022 
    * @param List<Building__c> newList 
    **/
    public static void checkProductionEngineer(List<Building__c> newList) {

        List<Building__c> buildingsWithoutEngineer = new List<Building__c>();

        for(Building__c bui : newList) {

            if(bui.Production_Engineer__c == null) {
                buildingsWithoutEngineer.add(bui);
            }
        }

        if(buildingsWithoutEngineer.size() > 0) {
            AP01_Building.attachEngineer(buildingsWithoutEngineer);
        }
    }
}