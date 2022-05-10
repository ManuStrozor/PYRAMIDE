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
        //      DeveloperName ('Personal'),
        //      RecordTypeInfos (class) { getRecordTypeId() }
        //    >
        ID personalRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Label.personalRecordType).getRecordTypeId();

        // Create a new empty object Engineer (personal) with Name = 'Auto Created Engineer'
        Account engineer = new Account(Name = Label.autoCreatedEngineerName, RecordTypeId = personalRecordTypeID);
        // Insert Engineer in database
        insert engineer;

        for (Building__c building : buildings) {

            // Charge Production_Engineer value with previously inserted Engineer's Id
            building.Production_Engineer__c = engineer.Id;
        }
    }
}