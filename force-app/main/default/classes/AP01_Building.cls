/**
 * @name         : AP01_Building
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 10-05-2022
**/
public class AP01_Building {
    
    /**
    * @name     attachEngineer
    * @description Attach an engineer to buildings
    * @author   Emmanuel Turbet-Delof | 10-05-2022
    * @param    ID buildingId
    **/
    public static void attachEngineer(List<Building__c> buildings) {

        // Retrieve The RecordType ID From Schema class
        //
        // Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName() -->
        // Map<
        //      DeveloperName,
        //      RecordTypeInfos (class) { getRecordTypeId() }
        //    >
        ID personalRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Label.personalRecordType).getRecordTypeId();

        // Insert a brand new Engineer in Database
        Account engineer = new Account(Name = Label.autoCreatedEngineerName, RecordTypeId = personalRecordTypeID);
        insert engineer;

        for (Building__c building : buildings) {

            // Change Production Engineer value of the building
            building.Production_Engineer__c = engineer.Id;
        }
    }
}