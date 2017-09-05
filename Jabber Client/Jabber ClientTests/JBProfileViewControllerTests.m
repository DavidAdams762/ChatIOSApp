
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JBProfileViewController.h"

@interface JBProfileViewControllerTests : XCTestCase {
    JBProfileViewController *jbProfile;
}
@end

@implementation JBProfileViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    jbProfile = [storyboard instantiateViewControllerWithIdentifier:@"showProfile"];
    [jbProfile view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNameFieldConnected {
    XCTAssertNotNil([jbProfile textFieldName]);
}

- (void)testFirstnameFieldConnected {
    XCTAssertNotNil([jbProfile textFieldPrenom]);
}

- (void)testAgeFieldConnected {
    XCTAssertNotNil([jbProfile textFieldAge]);
}

- (void)testSaveButtonConnected {
    XCTAssertNotNil([jbProfile enregistrer]);
}

- (void)testInitWithUser {
    NSString *testName = @"Bryan";
    JBProfileViewController *testView = [jbProfile initWithUser:testName];
    XCTAssertEqual([testView strUsername], testName);
}



@end
