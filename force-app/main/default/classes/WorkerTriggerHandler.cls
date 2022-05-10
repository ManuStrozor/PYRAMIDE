/**
 * @name         : WorkerTriggerHandler
 * @author       : Emmanuel Turbet-Delof
 * @description  : Handler that 
 * @modified by  : Thomas BOYER
 * @modified on  : 10-05-2022
**/
public class WorkerTriggerHandler {
    
    /**
     * checkWorkerFields - Check if Contract_end_date Field is modified or record is created in order to send email to Contact owner
     * @param newList - INSERT : newly created records  | UPDATE : new records that were modified
     * @param oldMap -  INSERT : null                   | UPDATE : old records that were modified
     * @return void
     */
    public static void checkWorkerFields(List<Contact> newList, Map<ID, Contact> oldMap) {

        List<Contact> workers = new List<Contact>();

        for(Contact worker : newList) {

            // INSERT || UPDATE
            if(
                (oldMap == null && worker.Date_end_contract__c != null) ||
                (oldMap != null && worker.Date_end_contract__c != oldMap.get(worker.Id).Date_end_contract__c)
                ) {
                workers.add(worker);
            }
        }

        if(workers.size() > 0) {
            AP01_Worker.sendEmails(workers);
        }
    }
}