/**
 * @name         : Test_Utils
 * @description  : 
 * @author       : Patrice PIERY
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 11-05-2022
**/
public class Test_Utils {

    public static List<Contact> createWorkers() {

        // Création de 2 Workers dans le scope de la method
        // et ajout des 2 elements dans la liste
        List<Contact> listWorkers = new List<Contact> {new Contact(Lastname = 'Test worker 1', Contract_start_date__c = Date.today(),
        Contract_end_date__c = Date.today() + 30), new Contact(Lastname = 'Test worker 2', Contract_start_date__c = Date.today() + 10,
        Contract_end_date__c = Date.today() + 40)};
        
        // Insert de la liste en Base
        insert listWorkers;
        // retourner la liste
        return listWorkers;
    }

    public static Village__c createVillage(String villAddress) {
        
        // Creation d'un village dans le scope de la method
        Village__c testVillage = new Village__c(Address__c = villAddress);
        
        // Insert du village en Base
        insert testVillage;

        // retourner village
        return testVillage;
    }

    public static Building__c createBuilding(ID villageId, String buildName) {

        Building__c building = new Building__c(Name = buildName, Village__c = villageId);

        // Insert du building en Base
        insert building;

        // retourner village
        return building;
    }
}
