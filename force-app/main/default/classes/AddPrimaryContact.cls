public class AddPrimaryContact implements Queueable{
    
    private Contact ct;
    private String st;
    
    public AddPrimaryContact(Contact contact, String state){
        this.ct = contact;
        this.st = state;
    }
    
    public void execute(QueueableContext context) {
	List<Account> acctstoupdate = [Select Id, BillingState from Account where Billingstate = :st limit 200];
    List<Contact> contactstoinsert = new List<Contact>();
        for (Account acc: acctstoupdate){
            Contact newcont = ct.clone();
            newcont.AccountId = acc.Id;           
            contactstoinsert.add(newcont);
        }
        insert contactstoinsert;
        }

}