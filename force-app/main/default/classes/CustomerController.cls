/**
 * @name         : CustomerController
 * @description  : 
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 12-05-2022
**/
public with sharing class CustomerController {

    @AuraEnabled(cacheable=true)
    public static List<Customer__c> getCustomers() {

        return [SELECT Id, Name, Firstname__c, Apartment_number_Purchased__c, Purchase_date__c, Building__c, Building__r.Name, Amount_paid__c FROM Customer__c];
    }
}
