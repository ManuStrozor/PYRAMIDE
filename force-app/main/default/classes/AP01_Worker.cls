/**
 * @name        : AP01_Worker
 * @author      : Emmanuel Turbet-Delof
 * @description : Class used to send emails
 * @modified by : Emmanuel Turbet-Delof
 * @modified on : 10-05-2022
 */
public class AP01_Worker {

    public static Boolean emailSuccess = false;

    /**
     * sendEmails - send emails to the contact owner of all the workers
     * @param workers - List of records of type Contact
     * @return void
     */
    public static void sendEmails(List<Contact> workers) {
        
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();

        // Retrieve workers Ids
        List<ID> workerIDs = new List<ID>();
        for(Contact worker : workers) {
            workerIDs.add(worker.Id);
        }

        for(List<Contact> workersWithOwner : [SELECT Name, Email, Contract_start_date__c, Contract_end_date__c, Owner.Name, Owner.Email FROM Contact WHERE ID IN :workerIDs]) {

            // Loop over 200 workersWithOwner from SOQL request
            for(Contact worker : workersWithOwner) {

                // Construction of the msg object
                Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                
                msg.setToAddresses(new List<String> {worker.Owner.Email});
                msg.setSubject(Label.subjectEmail);
                msg.setPlainTextBody(String.format(Label.plainTextEmailBody, new List<Object> {
                    worker.Owner.Name,
                    worker.Name,
                    worker.Email,
                    worker.Contract_start_date__c,
                    worker.Contract_end_date__c
                }));

                messages.add(msg);
            }
        }

        // Send all the messages
        if(messages.size() > 0) {
            try {
                Messaging.sendEmail(messages);
                emailSuccess = true;
            } catch(Exception e) {
                emailSuccess = false;
            }
        }
    }
}