@isTest
private class QBCustomerTest {
  @TestSetup
  static void makeData() {
    Account a = new Account();
    a.Name = 'Jizuke';
    insert a;
    Contact c = new Contact();
    c.LastName = 'Jizuke Kazoo';
    c.AccountId = a.Id;
    insert c;
  }

  @isTest
  static void testController() {
    Test.setMock(HttpCalloutMock.class, new QBMock());

    Account a = QBCustomerHelper.getAccount(
      [SELECT Id FROM Account WHERE Name = 'Jizuke'].Id
    );

    Test.startTest();

    PageReference pageRef = Page.QBCustomerVF; // Add your VF page Name here
    pageRef.getParameters().put('Id', String.valueOf(a.Id));
    Test.setCurrentPage(pageRef);
    ApexPages.StandardController stdAccount = new ApexPages.StandardController(
      a
    );
    QBCustomerController controller = new QBCustomerController(stdAccount);
    controller.syncQB();
    Test.stopTest();

    System.assert(controller != null);
  }

  @isTest
  static void testPullController() {
    Test.setMock(HttpCalloutMock.class, new QBMock());

    Account a = QBCustomerHelper.getAccount(
      [SELECT Id FROM Account WHERE Name = 'Jizuke'].Id
    );
    a.qime__QB_Id__c = '1234';
    update a;
    Test.startTest();

    PageReference pageRef = Page.QBCustomerPullVF; // Add your VF page Name here
    pageRef.getParameters().put('Id', String.valueOf(a.Id));
    Test.setCurrentPage(pageRef);
    ApexPages.StandardController stdAccount = new ApexPages.StandardController(
      a
    );
    QBCustomerPullController controller = new QBCustomerPullController(
      stdAccount
    );
    controller.syncQB();
    Test.stopTest();

    System.assert(controller != null);
  }

  @isTest
  static void testCustomerCreate() {
    Test.setMock(HttpCalloutMock.class, new QBMock());
    Account a = QBCustomerHelper.getAccount(
      [SELECT Id FROM Account WHERE Name = 'Jizuke'].Id
    );
    Test.startTest();
    QBCustomerResponseJSON customer = QBCallout.createCustomer(
      QBMap.mapAccountData(a)
    );
    Test.stopTest();

    System.assert(customer != null);
    System.assert(customer.Customer != null);
  }

  @isTest
  static void testCustomerQuery() {
    Test.setMock(HttpCalloutMock.class, new QBMock());
    Account a = QBCustomerHelper.getAccount(
      [SELECT Id FROM Account WHERE Name = 'Jizuke'].Id
    );
    Test.startTest();
    QBCustomerJSON customer = QBCallout.getCustomer(a);
    Test.stopTest();

    System.assert(customer != null);
    System.assert(customer.QueryResponse != null);
  }

  @isTest
  static void testCustomerBatch() {
    Test.setMock(HttpCalloutMock.class, new QBMock());

    Test.startTest();
    QBCustomerBatch batch = new QBCustomerBatch();
    Database.executeBatch(batch);
    Test.stopTest();

    System.assert(batch != null);
    List<Account> accs = [SELECT Id FROM Account WHERE QB_Id__c = '1'];
    System.assert(accs.size() > 0);
  }

  @isTest
  static void testCustomerQueueable() {
    Test.setMock(HttpCalloutMock.class, new QBMock());

    Test.startTest();
    System.enqueueJob(new QBCustomerQueueable(0, 0, 50, 0));
    Test.stopTest();

    List<Account> accs = [SELECT Id FROM Account WHERE QB_Id__c = '1'];
    System.assert(accs.size() > 0);
  }

  // Implement a mock http response generator for QBAuth.
  public class QBMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
      HTTPResponse res = new HTTPResponse();

      if (req.getEndpoint().contains('query')) {
        res.setBody(QBCustomerJSON_Test.json);
        res.setStatusCode(200);
      } else if (req.getEndpoint().contains('customer')) {
        res.setBody(QBCustomerResponseJSON_Test.json);
        res.setStatusCode(200);
      } else {
        System.assert(false, 'unexpected endpoint ' + req.getEndpoint());
        return null;
      }

      return res;
    }
  }
}