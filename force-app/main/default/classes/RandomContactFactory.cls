public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer noOfCont, String lastName){
        List<Contact> contactsToReturn = new List<Contact>();
        for (Integer i=0; i<noOfCont; i++){
            Contact newcont = new Contact(FirstName = 'Name ' + i, Lastname = lastname);
            contactsToReturn.add(newcont);
            system.debug('inserting ' + newcont.FirstName);
        }
        return contactsToReturn;
        }
    }