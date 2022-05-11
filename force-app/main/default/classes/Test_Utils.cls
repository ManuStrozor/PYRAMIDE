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
    private static void makeData() {
        
        Contact testWorker1 = new Contact(Lastname = 'Test worker 1', Contract_start_date__c = Date.today(),
                                             Contract_end_date__c = Date.today() + 30);
        Contact testWorker2 = new Contact(Lastname = 'Test worker 2', Contract_start_date__c = Date.today() + 10,
                                             Contract_end_date__c = Date.today() + 40);
        List<Contact> listWorkers = new List<Contact> {testWorker1, testWorker2};
        insert listWorkers;

        Village__c testVillage = new Village__c(Address__c = 'Test road 01000 Village');
        insert testVillage; 
    }

    @isTest
    private static void insertWorker() {
        
        Contact worker = new Contact(Lastname = 'Test worker',
                                        Contract_start_date__c = Date.today() + 5,
                                        Contract_end_date__c = Date.today() + 35);

        System.assertNotEquals(null, worker);

        // Perform the test
        Test.startTest();
        insert(worker);
        Test.stopTest();

        // Check the result
        Contact workerRes = [SELECT Lastname, Contract_start_date__c, Contract_end_date__c FROM Contact WHERE ID = :worker.Id];
        System.assertNotEquals(null, workerRes);
        System.assertEquals(Date.today() + 5, workerRes.Contract_start_date__c);
        System.assertEquals(Date.today() + 35, workerRes.Contract_end_date__c);

        System.assertEquals(true, AP01_Worker.emailSuccess);
    }

    @isTest
    private static void insertWorkerNoEndDate() {
        
        Contact worker = new Contact(Lastname = 'Test worker', Contract_start_date__c = Date.today() + 5);

        System.assertNotEquals(null, worker);

        // Perform the test
        Test.startTest();
        insert(worker);
        Test.stopTest();

        // Check the result
        Contact workerRes = [SELECT Lastname, Contract_start_date__c, Contract_end_date__c FROM Contact WHERE ID = :worker.Id];
        System.assertNotEquals(null, workerRes);
        System.assertEquals(Date.today() + 5, workerRes.Contract_start_date__c);
        System.assertEquals(null, workerRes.Contract_end_date__c);

        System.assertEquals(false, AP01_Worker.emailSuccess);
    }

    @isTest
    private static void updateWorker() {
        
        List<Contact> workersList = [SELECT Lastname, Contract_end_date__c FROM Contact];

        System.assertEquals(2, workersList.size());

        workersList[0].Contract_end_date__c = Date.today() + 50;
        workersList[1].Contract_end_date__c = null;

        // Perform the test
        Test.startTest();
        Database.SaveResult[] srs = Database.update(workersList);
        Test.stopTest();

        Integer errors = 0;
        for(Database.SaveResult sr : srs) {
            if(!sr.isSuccess()) {
                errors++;
            }
        }

        // Check amount of errors
        System.assertEquals(0, errors);

        System.assertEquals(true, AP01_Worker.emailSuccess);
    }

    @isTest
    private static void insertBuilding() {
        
        Village__c village = [SELECT Id FROM Village__c];

        System.assertNotEquals(null, village);

        Building__c building = new Building__c(Name = 'test Building', Village__c = village.Id);
        // Perform the test
        Test.startTest();
        insert building;
        Test.stopTest();

        // Check the result
        Building__c build = [SELECT Name, Production_Engineer__c FROM building__c WHERE ID = :building.Id];
        System.assertNotEquals(null, build.Production_Engineer__c);

        Account engineer = [SELECT Name FROM Account WHERE ID = :build.Production_Engineer__c];
        System.assertEquals(Label.autoCreatedEngineerName, engineer.Name);

    }
}
