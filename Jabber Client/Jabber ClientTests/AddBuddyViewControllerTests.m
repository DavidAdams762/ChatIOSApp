#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AddBuddyViewController.h"

@interface AddBuddyViewControllerTests : XCTestCase {
    AddBuddyViewController *addBuddyView;
}

@end

@implementation AddBuddyViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    addBuddyView = [storyboard instantiateViewControllerWithIdentifier:@"addBuddy"];
    [addBuddyView view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIdFriendFieldFriendConnectd {
    XCTAssertNotNil([addBuddyView textFieldIdFriend]);
}

- (void)testRemoveFriendFieldConnectd {
    XCTAssertNotNil([addBuddyView textRemoveFieldFriend]);
}

- (void)testSendInvitation {
    addBuddyView.textFieldIdFriend.text = @"hey";
    [addBuddyView sendInvite];
    XCTAssertTrue([[[addBuddyView textFieldIdFriend]text] isEqualToString:@""]);
}

@end
