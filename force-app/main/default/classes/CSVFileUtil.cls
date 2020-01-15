/* 
 * Copyright (c) 2016, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license. 
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */
 
public class CSVFileUtil {
	//from https://developer.salesforce.com/page/Code_Samples#Parse_a_CSV_with_APEX
    public static List<List<String>> parseCSV(Blob csvFileBody,Boolean skipHeaders) {
        if(csvFileBody == null) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, Label.FILE_MISSING);
            ApexPages.addMessage(errorMessage);
            return null;
        }
        
        String contents = csvFileBody.toString();
        system.debug('contents' + contents);
        List<List<String>> allFields = new List<List<String>>();

        // replace instances where a double quote begins a field containing a comma
        // in this case you get a double quote followed by a doubled double quote
        // do this for beginning and end of a field
        contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
        system.debug('contents2' + contents);        
        // now replace all remaining double quotes - we do this so that we can reconstruct
        // fields with commas inside assuming they begin and end with a double quote
        contents = contents.replaceAll('""','DBLQT');
         system.debug('contents3' + contents);
	//windows case - replace all carriage + new line character to just new line character
	contents = contents.replaceAll('\r\n','\n');
                system.debug('contents4' + contents);
        //now replace all return char to new line character
        contents = contents.replaceAll('\r','\n');
                system.debug('contents5' + contents);
        // we are not attempting to handle fields with a newline inside of them
        // so, split on newline to get the spreadsheet rows
        List<String> lines = new List<String>();
        try {
            lines = contents.split('\n');
        } catch (System.ListException e) {
            System.debug('Limits exceeded?' + e.getMessage());
        }
                system.debug('lines' + lines);
        Integer num = 0;
        for(String line : lines) {
            // check for blank CSV lines (only commas)
            if (line.replaceAll(',','').trim().length() == 0) break;
            
            List<String> fields = line.split(',');  
            system.debug('fields' + fields);
            List<String> cleanFields = new List<String>();
            String compositeField;
            Boolean makeCompositeField = false;
            for(String field : fields) {
                system.debug('field' + field);
                if (field.startsWith('"') && field.endsWith('"')) {
                    cleanFields.add(field.replaceAll('DBLQT','"').trim());
                system.debug('cleanfields1' + cleanFields);                    
                } else if (field.startsWith('"')) {
                    makeCompositeField = true;
                    compositeField = field;
                   system.debug('cleanfields2');     
                } else if (field.endsWith('"')) {
                    compositeField += ',' + field;
                    cleanFields.add(compositeField.replaceAll('DBLQT','"').trim());
                	system.debug('cleanfields3' + cleanFields);                         
                    makeCompositeField = false;
                } else if (makeCompositeField) {
                    compositeField +=  ',' + field;
                    system.debug('cleanfields4');     
                } else {
                    cleanFields.add(field.replaceAll('DBLQT','"').trim());
                    system.debug('cleanfields5' + cleanFields);     
                }
            }
            
            allFields.add(cleanFields);
        }
        if (skipHeaders) allFields.remove(0);
        system.debug('allfields' + allFields);
        return allFields;       
    }
}