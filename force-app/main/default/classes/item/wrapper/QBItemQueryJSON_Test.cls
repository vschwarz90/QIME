//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

@IsTest
public class QBItemQueryJSON_Test {
  public static String json =
    '{' +
    '    \"QueryResponse\": {' +
    '        \"Item\": [' +
    '            {' +
    '                \"Name\": \"Concrete\",' +
    '                \"Description\": \"Concrete for fountain installation\",' +
    '                \"Active\": true,' +
    '                \"FullyQualifiedName\": \"Concrete\",' +
    '                \"Taxable\": true,' +
    '                \"UnitPrice\": 0,' +
    '                \"Type\": \"Service\",' +
    '                \"IncomeAccountRef\": {' +
    '                    \"value\": \"48\",' +
    '                    \"name\": \"Fountains and Garden Lighting\"' +
    '                },' +
    '                \"PurchaseCost\": 0,' +
    '                \"TrackQtyOnHand\": false,' +
    '                \"domain\": \"QBO\",' +
    '                \"sparse\": false,' +
    '                \"Id\": \"3\",' +
    '                \"SyncToken\": \"1\",' +
    '                \"MetaData\": {' +
    '                    \"CreateTime\": \"2023-08-16T10:36:03-07:00\",' +
    '                    \"LastUpdatedTime\": \"2023-08-19T12:47:47-07:00\"' +
    '                }' +
    '            }' +
    '        ],' +
    '        \"startPosition\": 1,' +
    '        \"maxResults\": 1' +
    '    }' +
    '}';
  static testMethod void testParse() {
    QBItemQueryJSON obj = QBItemQueryJSON.parse(json);
    System.assert(obj != null);
  }
}