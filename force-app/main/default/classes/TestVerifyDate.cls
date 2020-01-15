@isTest
public class TestVerifyDate {
	@isTest static void TestDate() {
date Date1 = date.newInstance(2017, 11, 21);
date Date2 = Date1.addMonths(3);
date Date3 = date.newInstance(2017, 11, 10);   
date Date4 = VerifyDate.CheckDates(Date1, Date2);
date Date5 = VerifyDate.CheckDates(Date1, Date3);        
date Date6 = VerifyDate.CheckDates(Date3, Date1); 
	}
}