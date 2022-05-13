/**
 * @name         : 
 * @description  : 
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 12-05-2022
**/
@isTest
public class CustomerController_Test {
    
    @TestSetup
    public static void makeData() {

        Village__c ville = Test_Utils.createVillage('Test village 1');
        Building__c build = Test_Utils.createBuilding(ville.Id, 'Test Building 1');

        Test_Utils.createCustomers(build.Id);
    }

    @isTest
    public static void getCustomers() {
        
        List<Customer__c> customers = CustomerController.getCustomers();

        Building__c build = [SELECT Apartments_Purchased__c, NumberOfApartments__c FROM Building__c LIMIT 1];

        System.assertEquals(1, build.Apartments_Purchased__c); // FLow Bulkify
        System.assertEquals(2, build.NumberOfApartments__c);

        System.assertNotEquals(null, customers);
        System.assertEquals(2, customers.size());
    }
}
