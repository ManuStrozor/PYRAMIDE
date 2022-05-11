/**
 * @name         : 
 * @description  : 
 * @author       : Emmanuel Turbet-Delof
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 11-05-2022
**/
public with sharing class CustomerDisplayPurchasesHeld_CX {
    
    private final Customer__c cust;

    public CustomerDisplayPurchasesHeld_CX(Apexpages.StandardController ctrl) {
        this.cust = (Customer__c) ctrl.getRecord();
    }

    public List<Customer__c> results {
        get {
            if(results == null) {
                results = [SELECT Name, Firstname__c , Apartment_number_Purchased__c, Purchase_date__c, Building__c, Amount_paid__c FROM Customer__c WHERE Building__c != null];
            }
            return results;
        }
        private set;        
    }

    public Integer total {
        get {
            return results.size();
        }
        private set;
    }
}
