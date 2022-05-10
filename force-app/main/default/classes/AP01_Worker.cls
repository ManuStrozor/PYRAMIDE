/**
 * @name        : AP01_Worker
 * @author      : Emmanuel Turbet-Delof
 * @description : Class used to send emails
 * @modified by : Thomas BOYER
 * @modified on : 10-05-2022
 */
public class AP01_Worker {

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

        for(List<Contact> workersWithOwner : [SELECT Name, Email, Date_init_contract__c, Date_end_contract__c, Owner.Name, Owner.Email FROM Contact WHERE ID IN :workerIDs]) {

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
                    worker.Date_init_contract__c,
                    worker.Date_end_contract__c
                }));

                messages.add(msg);
            }
        }

        // Send all the messages
        if(messages.size() > 0) {
            Messaging.sendEmail(messages);
        }
    }
}