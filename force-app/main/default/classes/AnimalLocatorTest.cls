@isTest
private class AnimalLocatorTest {

static testmethod void AnimalLocatetes() {
        // Create the mock response based on a static resource
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test
        String result = AnimalLocator.getAnimalNameById(1);
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');


    }  
}