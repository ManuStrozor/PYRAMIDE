/**
 * Name : WorkerTrigger
 * Author : Thomas BOYER
 * Description : Triggered when the Worker record is created or Contract_end_date Field is modified
 * Modified by : Thomas BOYER
 * Modif Date : 09/05/2022
 */
trigger WorkerTrigger on Contact (after insert, after update) {

    // Check if Contract_end_date Field is modified or record is created
    // -> send email to Contact Owner
    WorkerTriggerHandler.checkWorkerFields(Trigger.new, Trigger.oldMap);
}