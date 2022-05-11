/**
 * @name         : 
 * @description  : 
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 11-05-2022
**/
@isTest
public class AP01_Building_Test {
    
    @TestSetup
    /**
     * @name makeData
     * @description Creation d'un jeu de données, independant, seulement dans le context du Test
     */
    private static void makeData() {
        
        Test_Utils.createVillage('Test road 01000 Village');
    }

    @isTest
    /**
     * @name insertBuilding
     * @description Attach Enginner to a buidling (without engineer)
     */
    private static void insertBuilding() {
        
        Village__c village = [SELECT Id FROM Village__c];
        System.assertNotEquals(null, village);

        Building__c build = Test_Utils.createBuilding(village.Id, 'test Building');

        System.assertNotEquals(null, build.Production_Engineer__c);

        Account engineer = [SELECT Name, RecordTypeId FROM Account WHERE ID = :build.Production_Engineer__c];
        ID personalRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Label.personalRecordType).getRecordTypeId();

        System.assertEquals(Label.autoCreatedEngineerName, engineer.Name);
        System.assertEquals(personalRecordTypeID, engineer.RecordTypeId);

    }
}
