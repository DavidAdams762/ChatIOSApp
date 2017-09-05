#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JBLoginViewController.h"

@interface JBLoginViewControllerTests : XCTestCase
@end

@implementation JBLoginViewControllerTests
{
    JBLoginViewController *jbLogin;
}

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    jbLogin = [storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    [jbLogin view];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoginFieldConnected {
    XCTAssertNotNil([jbLogin loginField]);
}

- (void)testPasswordFieldConnected {
    XCTAssertNotNil([jbLogin passwordField]);
}

-(void) testInitalLoginField {
    NSString *t = [[jbLogin loginField]text];
    XCTAssertTrue([t isEqualToString:@""]);
}

-(void) testInitalPasswordField {
    NSString *t = [[jbLogin passwordField]text];
    XCTAssertTrue([t isEqualToString:@""]);
}


@end
