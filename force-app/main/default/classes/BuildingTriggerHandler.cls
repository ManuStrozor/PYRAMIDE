/**
 * @name         : BuildingTriggerHandler
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 13-05-2022
**/
public class BuildingTriggerHandler {

    /**
    * @name checkProductionEngineer
    * @description Check if production engineer exists & attach one to building if not
    * @author Emmanuel Turbet-Delof | 10-05-2022 
    * @param List<Building__c> newList 
    **/
    public static void checkProductionEngineer(List<Building__c> newList) {

        // Temp list to store only buildings without engineer
        List<SObject> buildingsWithoutEngineer = new List<SObject>();

        // Loop threw new buildings triggered
        for(Building__c bui : newList) {

            // If the field Production_Engineer is empty, add building to the temp list buildingsWithoutEngineer
            if(bui.Production_Engineer__c == null) {
                buildingsWithoutEngineer.add(bui);
            }
        }

        // if the temp list is not empty, we attach an engineer to the buildings
        if(buildingsWithoutEngineer.size() > 0) {

            AP01_Building.attachEngineer(buildingsWithoutEngineer);
        }
    }
}