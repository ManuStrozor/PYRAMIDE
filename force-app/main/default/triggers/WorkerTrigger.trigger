/**
 * @name : WorkerTrigger
 * @author : Emmanuel Turbet-Delof
 * @description : Triggered when the Worker record is created or Contract_end_date Field is modified
 * @modified by : Emmanuel Turbet-Delof
 * @modified on : 10-05-2022
 */

// After Trigger is used because of asynchronous behaviour of sendEmail (can't be canceled)
// If Before Trigger is used and an error occured in the save order*, We can't cancel the Send
trigger WorkerTrigger on Contact (after insert, after update) {

    // Check if Contract_end_date Field is modified or record is created
    // -> send email to Contact Owner
    WorkerTriggerHandler.checkWorkerFields(Trigger.new, Trigger.oldMap);
}

// * [TRIGGER BEFORE] ----> [SAVE (errors?)] ----> [TRIGGER AFTER] ----> [COMMIT (update / insert)]