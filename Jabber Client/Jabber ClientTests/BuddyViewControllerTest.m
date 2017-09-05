#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <BuddyViewController.h>

@interface BuddyViewControllerTest : XCTestCase
@end

@implementation BuddyViewControllerTest
{
    BuddyViewController *buddyView;
}

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    buddyView = [storyboard instantiateViewControllerWithIdentifier:@"showBuddys"];
    [buddyView view];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testTabViewConnected {
    XCTAssertNotNil([buddyView tabView]);
}
@end
