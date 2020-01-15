@isTest
public class TestRestrictContactByName {
		@isTest static void TestName() {
            Contact newcont = new Contact(Lastname = 'INVALIDNAME');
            try{insert newcont;}
            catch(exception e){}
        }
}