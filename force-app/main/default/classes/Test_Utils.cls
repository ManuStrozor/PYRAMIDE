/**
 * @name         : Test_Utils
 * @description  : 
 * @author       : Patrice PIERY
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 13-05-2022
**/
public class Test_Utils {

    /**
     * @name createWorkers
     * @description Creation de workers
     */
    public static List<Contact> createWorkers() {

        // Création de 2 Workers dans le scope de la method
        // et ajout des 2 elements dans la liste
        List<Contact> listWorkers = new List<Contact> {
            new Contact(
                Lastname = 'Test worker 1',
                Contract_start_date__c = Date.today(),
                Contract_end_date__c = Date.today() + 30
            ),
            new Contact(
                Lastname = 'Test worker 2',
                Contract_start_date__c = Date.today() + 10,
                Contract_end_date__c = Date.today() + 40
            )
        };
        
        // Insert de la liste en Base
        insert listWorkers;
        // retourner la liste
        return listWorkers;
    }

    /**
     * @name createCustomer
     */
    public static List<Customer__c> createCustomers(ID buildingId) {

        // Creation d'un customer dans le scope de la method
        List<Customer__c> customers = new List<Customer__c> {
            new Customer__c(
                Name = 'Test Customer 1',
                Apartment_number_Purchased__c = 321654987,
                Building__c = buildingId,
                Purchase_date__c = Date.today(),
                Amount_paid__c = 0,
                Status__c = 'Active'
            ),
            new Customer__c(
                Name = 'Test Customer 2',
                Apartment_number_Purchased__c = 123456789,
                Building__c = buildingId,
                Purchase_date__c = Date.today(),
                Amount_paid__c = 0,
                Status__c = 'Active'
            )
        };
        // Insert du customer en Base
        insert customers;

        // retourner customer
        return customers;
    }

    /**
     * @name createVillage
     */
    public static Village__c createVillage(String villAddress) {
        
        // Creation d'un village dans le scope de la method
        Village__c ville = new Village__c(Address__c = villAddress);
        
        // Insert du village en Base
        insert ville;

        // retourner village
        return ville;
    }

    /**
     * @name createBuilding
     */
    public static Building__c createBuilding(ID villageId, String buildName) {

        // Creation d'un building dans le scope de la method
        Building__c building = new Building__c(
            Name = buildName,
            Apartment_price__c = 100000,
            NumberOfApartments__c = 1,
            Village__c = villageId
        );

        // Insert du building en Base
        insert building;

        // retourner building
        return building;
    }
}
