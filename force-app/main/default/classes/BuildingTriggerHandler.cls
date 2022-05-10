/**
 * @name         : BuildingTriggerHandler
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 10-05-2022
**/
public class BuildingTriggerHandler {

    /**
    * @name checkProductionEngineer
    * @description Check if production engineer exists & attach one to building if not
    * @author Emmanuel Turbet-Delof | 10-05-2022 
    * @param List<Building__c> newList 
    **/
    public static void checkProductionEngineer(List<Building__c> newList) {

        // New constructor of buildings
        List<Building__c> buildingsWithoutEngineer = new List<Building__c>();

        // Loop for all buildings inside newList
        for(Building__c bui : newList) {

            // if the list of buildings is empty, we add all the list off buildings  
            // without an engineer to the list bui
            if(bui.Production_Engineer__c == null) {
                buildingsWithoutEngineer.add(bui);
            }
        }

        // if the list of buildings whithout engineer is not empty, we attach an engineer
        if(buildingsWithoutEngineer.size() > 0) {
            AP01_Building.attachEngineer(buildingsWithoutEngineer);
        }
    }
}