/**
 * @name         : Test_Utils
 * @description  : 
 * @author       : Patrice PIERY
 * @modified by  : Emmanuel Turbet-Delof
 * @modified on  : 11-05-2022
**/
@isTest
private class Test_Utils {

    @TestSetup
    /**
     * @name makeData
     * @description Creation d'un jeu de données, independant, seulement dans le context du Test
     */
    private static void makeData() {
        
        // Création de 2 Workers dans le scope de la method
        Contact testWorker1 = new Contact(Lastname = 'Test worker 1', Contract_start_date__c = Date.today(),
                                             Contract_end_date__c = Date.today() + 30);
        Contact testWorker2 = new Contact(Lastname = 'Test worker 2', Contract_start_date__c = Date.today() + 10,
                                             Contract_end_date__c = Date.today() + 40);

        // jout des 2 elements dans la liste
        List<Contact> listWorkers = new List<Contact> {testWorker1, testWorker2};
        // Insert de la liste en Base
        insert listWorkers;

        // Creation d'un village dans le scope de la method
        Village__c testVillage = new Village__c(Address__c = 'Test road 01000 Village');
        // Insert du village en Base
        insert testVillage; 
    }

    @isTest
    /**
     * @name insertWorker
     * @description Insert d'un worker (avec une date de fin de contrat -> Envoi du mail) en Base
     */
    private static void insertWorker() {
        
        // Creation d'un worker dans le scope de la method
        Contact worker = new Contact(LastName = 'Test worker',
                                        Contract_start_date__c = Date.today() + 5,
                                        Contract_end_date__c = Date.today() + 35);

        // assert = verifie que | worker NotEquals null
        System.assertNotEquals(null, worker);

        // Perform the DML in the method scope
        Test.startTest();
        // Insert en Base (de test temporaire)
        insert worker;
        Test.stopTest();

        // Check the result (comme INSERT alors SOQL)
        Contact workerRes = [SELECT LastName, Contract_start_date__c, Contract_end_date__c FROM Contact WHERE ID = :worker.Id];

        // Verifie que workerRes n'est pas null
        System.assertNotEquals(null, workerRes);
        // Verifie les attributs
        System.assertEquals('Test worker', workerRes.LastName);
        System.assertEquals(Date.today() + 5, workerRes.Contract_start_date__c);
        System.assertEquals(Date.today() + 35, workerRes.Contract_end_date__c);

        // Verifie l'envoi du mail (attribut static emailSuccess)
        System.assertEquals(true, AP01_Worker.emailSuccess);
    }

    @isTest
    /**
     * @name insertWorkerNoEndDate
     * @description Même test que insertWorker a la diference que l'envoi du mail ne se fait pas (pas de end date)
     */
    private static void insertWorkerNoEndDate() {
        
        Contact worker = new Contact(Lastname = 'Test worker', Contract_start_date__c = Date.today() + 5);

        System.assertNotEquals(null, worker);

        Test.startTest();
        insert(worker);
        Test.stopTest();

        Contact workerRes = [SELECT Lastname, Contract_start_date__c, Contract_end_date__c FROM Contact WHERE ID = :worker.Id];

        System.assertNotEquals(null, workerRes);

        System.assertEquals('Test worker', workerRes.LastName);
        System.assertEquals(Date.today() + 5, workerRes.Contract_start_date__c);
        System.assertEquals(null, workerRes.Contract_end_date__c);

        System.assertEquals(false, AP01_Worker.emailSuccess);
    }

    @isTest
    /**
     * @name updateWorker
     * @description A toi de jouer Thomas
     */
    private static void updateWorker() {
        
        List<Contact> workersList = [SELECT Lastname, Contract_end_date__c FROM Contact];

        System.assertEquals(2, workersList.size());

        workersList[0].Contract_end_date__c = Date.today() + 50;
        workersList[1].Contract_end_date__c = null;

        // Perform the DML ine the scope of the method
        Test.startTest();
        //List<Database.SaveResult> srs =  Database.update(workersList);
        Database.SaveResult[] srs =  Database.update(workersList);
        Test.stopTest();

        Integer errors = 0;
        for(Database.SaveResult sr : srs) {
            if(!sr.isSuccess()) { // if(sr.isSuccess() != true) {
                errors++;
            }
        }

        // Check amount of errors
        System.assertEquals(0, errors);

        System.assertEquals(true, AP01_Worker.emailSuccess);
    }

    @isTest
    /**
     * @name insertBuilding
     * @description Attach Enginner to a buidling (without engineer)
     */
    private static void insertBuilding() {
        
        List<Village__c> villages = [SELECT Id FROM Village__c];

        System.assertEquals(1, villages.size());

        Building__c building = new Building__c(Name = 'test Building', Village__c = villages[0].Id);

        // Perform the test
        Test.startTest();
        insert building; // Declanchement du Trigger before insert
        Test.stopTest();

        // Check the result
        Building__c build = [SELECT Production_Engineer__c FROM building__c WHERE ID = :building.Id];

        System.assertNotEquals(null, build.Production_Engineer__c);

        Account engineer = [SELECT Name, RecordTypeId FROM Account WHERE ID = :build.Production_Engineer__c];
        ID personalRecordTypeID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Label.personalRecordType).getRecordTypeId();

        System.assertEquals(Label.autoCreatedEngineerName, engineer.Name);
        System.assertEquals(personalRecordTypeID, engineer.RecordTypeId);

    }
}
