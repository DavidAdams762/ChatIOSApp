#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JBChatViewController.h"

@interface JBChatViewControllerTest : XCTestCase
@end

@implementation JBChatViewControllerTest {
    JBChatViewController *jbChat;
    NSString *userAddress;
}

- (void)setUp {
    [super setUp];
    userAddress = @"ophelie@localhost";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

   jbChat = [storyboard instantiateViewControllerWithIdentifier:@"chatView"];
    [jbChat view];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitUser {
    id user = [jbChat initWithUser:userAddress];
    XCTAssertNotNil(user);
}

-(void) testMessageFieldConnected {
    XCTAssertNotNil([jbChat messageField]);
}

-(void) testTViewConnected {
    XCTAssertNotNil([jbChat tView]);
}

-(void) testInitalMessageField {
    NSString *t = [[jbChat messageField]text];
    XCTAssertTrue([t isEqualToString:@""]);
}


@end
