public class changePassword {
@AuraEnabled
    public static String changePassword(String password, String password2, String oldPassword){

        return JSON.serialize(Site.changePassword(password, password2, oldPassword));

    } 
}